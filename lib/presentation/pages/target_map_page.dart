import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/region_codes.dart';
import '../../data/services/geocoding_service.dart';
import '../../data/services/api_service.dart';
import '../../data/models/house_price_model.dart';
import '../providers/home_goal_provider.dart';

/// 목표 아파트 선택 지도 페이지
class TargetMapPage extends ConsumerStatefulWidget {
  const TargetMapPage({super.key});

  @override
  ConsumerState<TargetMapPage> createState() => _TargetMapPageState();
}

class _TargetMapPageState extends ConsumerState<TargetMapPage> {
  final MapController _mapController = MapController();
  final GeocodingService _geocodingService = GeocodingService();
  final TextEditingController _searchController = TextEditingController();

  // 서울 강남구 기본 위치
  static const LatLng _defaultPosition = LatLng(37.5172, 127.0473);
  LatLng _currentPosition = _defaultPosition;
  LatLng? _selectedPosition;
  AddressInfo? _selectedAddress;
  List<HousePriceModel> _trades = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _mapError = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onMapTap(LatLng position) async {
    // 웹 환경에서는 지도 탭 기능 비활성화
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('웹에서는 주소 검색을 이용해주세요.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() {
      _selectedPosition = position;
      _isLoading = true;
      _errorMessage = null;
      _trades = [];
    });

    try {
      // 주소 조회
      final addressInfo = await _geocodingService.getAddressFromCoordinates(position);
      if (addressInfo != null) {
        setState(() {
          _selectedAddress = addressInfo;
        });

        // 법정동 코드 추출 및 실거래가 조회
        await _fetchTradeData(addressInfo, position);
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = '주소를 찾을 수 없습니다.';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '데이터 조회 중 오류가 발생했습니다. 주소 검색을 이용해주세요.';
      });
    }
  }

  Future<void> _fetchTradeData(AddressInfo? addressInfo, LatLng position) async {
    // 웹 환경에서는 API 호출 비활성화
    if (kIsWeb) {
      setState(() {
        _isLoading = false;
        _errorMessage = '웹에서는 주소 검색을 이용해주세요.';
      });
      return;
    }

    String? regionCode;

    try {
      // 주소에서 법정동 코드 추출
      if (addressInfo != null) {
        regionCode = RegionCodes.extractCodeFromAddress(addressInfo.displayName);
      }

      // 주소에서 못 찾으면 위치 기반으로 추정
      regionCode ??= RegionCodes.getCodeByLocation(position.latitude, position.longitude);

      if (regionCode == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = '해당 지역의 법정동 코드를 찾을 수 없습니다.';
        });
        return;
      }

      final apiService = ref.read(apiServiceProvider);
      final now = DateTime.now();
      final dealYm = DateFormat('yyyyMM').format(now);

      final trades = await apiService.getApartmentTradeDetail(
        lawdCd: regionCode,
        dealYm: dealYm,
      );

      // 거래 데이터가 없으면 이전 달 조회
      if (trades.isEmpty) {
        final prevMonth = DateTime(now.year, now.month - 1);
        final prevDealYm = DateFormat('yyyyMM').format(prevMonth);
        final prevTrades = await apiService.getApartmentTradeDetail(
          lawdCd: regionCode,
          dealYm: prevDealYm,
        );
        setState(() {
          _trades = prevTrades;
          _isLoading = false;
        });
      } else {
        setState(() {
          _trades = trades;
          _isLoading = false;
        });
      }

      // 바텀시트 표시
      if (_trades.isNotEmpty && mounted) {
        _showTradeListBottomSheet(regionCode);
      } else if (mounted) {
        setState(() {
          _errorMessage = '해당 지역의 실거래 데이터가 없습니다.';
        });
      }
    } on ApiException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'API 오류: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '데이터 조회 실패: 주소 검색을 이용해주세요.';
      });
    }
  }

  void _showTradeListBottomSheet(String regionCode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TradeListBottomSheet(
        trades: _trades,
        address: _selectedAddress?.shortAddress ?? '선택한 위치',
        regionCode: regionCode,
        onSelectTrade: (trade) {
          Navigator.pop(context);
          _showTradeDetailBottomSheet(trade, regionCode);
        },
      ),
    );
  }

  void _showTradeDetailBottomSheet(HousePriceModel trade, String regionCode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TradeDetailBottomSheet(
        trade: trade,
        allTrades: _trades,
        address: _selectedAddress?.shortAddress ?? '선택한 위치',
        regionCode: regionCode,
        onSetGoal: () async {
          await _setAsGoal(trade, regionCode);
          if (mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${trade.apartmentName}을(를) 목표로 설정했습니다.'),
                backgroundColor: AppColors.success,
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _setAsGoal(HousePriceModel trade, String regionCode) async {
    final notifier = ref.read(homeGoalNotifierProvider.notifier);
    await notifier.setGoalFromTradeInfo(
      tradeInfo: trade,
      regionCode: regionCode,
      address: _selectedAddress?.shortAddress ?? '',
    );
  }

  Future<void> _searchAddress() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await _geocodingService.searchAddress(query);
      setState(() {
        _isLoading = false;
      });

      if (results.isNotEmpty && mounted) {
        final result = results.first;
        if (!kIsWeb) {
          _mapController.move(result.position, 15);
        }
        // 웹이 아닌 경우에만 지도 탭 이벤트 호출
        if (!kIsWeb) {
          _onMapTap(result.position);
        } else {
          // 웹에서는 검색 결과로 바로 실거래가 조회
          // SearchResult를 AddressInfo로 변환
          final addressInfo = AddressInfo(
            displayName: result.displayName,
            position: result.position,
          );
          setState(() {
            _selectedAddress = addressInfo;
            _selectedPosition = result.position;
          });
          await _fetchTradeDataFromAddress(addressInfo);
        }
      } else if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('검색 결과가 없습니다.')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '주소 검색 중 오류가 발생했습니다.';
      });
    }
  }

  /// 웹 환경에서 주소 검색 결과로 실거래가 조회
  Future<void> _fetchTradeDataFromAddress(AddressInfo addressInfo) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _trades = [];
    });

    try {
      String? regionCode = RegionCodes.extractCodeFromAddress(addressInfo.displayName);
      
      if (regionCode == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = '해당 지역의 법정동 코드를 찾을 수 없습니다.';
        });
        return;
      }

      final apiService = ref.read(apiServiceProvider);
      final now = DateTime.now();
      final dealYm = DateFormat('yyyyMM').format(now);

      final trades = await apiService.getApartmentTradeDetail(
        lawdCd: regionCode,
        dealYm: dealYm,
      );

      // 거래 데이터가 없으면 이전 달 조회
      if (trades.isEmpty) {
        final prevMonth = DateTime(now.year, now.month - 1);
        final prevDealYm = DateFormat('yyyyMM').format(prevMonth);
        final prevTrades = await apiService.getApartmentTradeDetail(
          lawdCd: regionCode,
          dealYm: prevDealYm,
        );
        setState(() {
          _trades = prevTrades;
          _isLoading = false;
        });
      } else {
        setState(() {
          _trades = trades;
          _isLoading = false;
        });
      }

      // 바텀시트 표시
      if (_trades.isNotEmpty && mounted) {
        _showTradeListBottomSheet(regionCode);
      } else if (mounted) {
        setState(() {
          _errorMessage = '해당 지역의 실거래 데이터가 없습니다.';
        });
      }
    } on ApiException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'API 오류: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '데이터 조회 실패: 다시 시도해주세요.';
      });
    }
  }

  /// 웹 환경용 지도 플레이스홀더
  Widget _buildWebMapPlaceholder() {
    return Container(
      color: AppColors.surfaceVariant,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              '주소 검색으로 아파트 찾기',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                '위 검색창에 주소나 아파트명을 입력하여\n실거래가를 조회할 수 있습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 지도 오류 시 대체 UI
  Widget _buildMapErrorWidget() {
    return Container(
      color: AppColors.surfaceVariant,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.map_outlined,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            const Text(
              '지도를 불러올 수 없습니다',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                '주소 검색을 통해 아파트를 찾을 수 있습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 가격이 표시된 마커 위젯
  Widget _buildPriceMarker() {
    if (_trades.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              '조회중...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: AppColors.primary,
            size: 24,
          ),
        ],
      );
    }

    // 가장 최근 거래의 평균 가격 계산
    final avgPrice = _trades.map((t) => t.dealAmount).reduce((a, b) => a + b) ~/ _trades.length;
    final priceText = avgPrice >= 10000
        ? '${(avgPrice / 10000).toStringAsFixed(1)}억'
        : '${avgPrice}만';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            priceText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Icon(
          Icons.arrow_drop_down,
          color: AppColors.primary,
          size: 24,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // 웹 환경에서는 지도 오류 플래그 설정
    if (kIsWeb) {
      _mapError = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '목표 아파트 선택',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.surface,
      ),
      body: Stack(
        children: [
          // 지도 (웹 환경에서는 렌더링하지 않음)
          if (kIsWeb)
            _buildWebMapPlaceholder()
          else if (!_mapError)
            Builder(
              builder: (context) {
                try {
                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _currentPosition,
                      initialZoom: 14,
                      onTap: (tapPosition, point) => _onMapTap(point),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.homerun.app',
                        maxZoom: 19,
                        minZoom: 3,
                      ),
                      // 선택된 위치 마커 (금액 표시)
                      if (_selectedPosition != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _selectedPosition!,
                              width: 100,
                              height: 60,
                              child: _buildPriceMarker(),
                            ),
                          ],
                        ),
                    ],
                  );
                } catch (e) {
                  // 에러 발생 시 지도 대체 UI 표시
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _mapError = true;
                        _errorMessage = '지도를 불러올 수 없습니다. 주소 검색을 이용해주세요.';
                      });
                    }
                  });
                  return _buildMapErrorWidget();
                }
              },
            )
          else
            _buildMapErrorWidget(),

          // 검색 바
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '주소 또는 아파트명 검색',
                  hintStyle: const TextStyle(color: AppColors.textTertiary),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primary),
                    onPressed: _searchAddress,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onSubmitted: (_) => _searchAddress(),
              ),
            ),
          ),

          // 로딩 인디케이터
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),

          // 안내 메시지
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.touch_app,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _errorMessage ?? '지도를 탭하여 해당 지역의 아파트 실거래가를 조회하세요.',
                      style: TextStyle(
                        color: _errorMessage != null
                            ? AppColors.error
                            : AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 거래 목록 바텀시트
class _TradeListBottomSheet extends StatelessWidget {
  final List<HousePriceModel> trades;
  final String address;
  final String regionCode;
  final Function(HousePriceModel) onSelectTrade;

  const _TradeListBottomSheet({
    required this.trades,
    required this.address,
    required this.regionCode,
    required this.onSelectTrade,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 핸들
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // 헤더
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.apartment, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '최근 거래 ${trades.length}건',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // 거래 목록
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: trades.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final trade = trades[index];
                return ListTile(
                  onTap: () => onSelectTrade(trade),
                  title: Text(
                    trade.apartmentName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    '${trade.exclusiveArea.toStringAsFixed(1)}㎡ · ${trade.floor}층 · ${trade.dealDay}일',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  trailing: Text(
                    '${numberFormat.format(trade.dealAmount)}만원',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 거래 상세 바텀시트
class _TradeDetailBottomSheet extends StatelessWidget {
  final HousePriceModel trade;
  final List<HousePriceModel> allTrades;
  final String address;
  final String regionCode;
  final VoidCallback onSetGoal;

  const _TradeDetailBottomSheet({
    required this.trade,
    required this.allTrades,
    required this.address,
    required this.regionCode,
    required this.onSetGoal,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');
    final priceInBillion = trade.dealAmount / 10000;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 핸들
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textTertiary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // 아파트명
          Text(
            trade.apartmentName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$address · ${trade.dongName}',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          // 가격 정보
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '최신 실거래가',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '${priceInBillion.toStringAsFixed(1)}억원',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 상세 정보
          _InfoRow(label: '전용면적', value: '${trade.exclusiveArea.toStringAsFixed(2)}㎡ (${(trade.exclusiveArea / 3.3058).toStringAsFixed(1)}평)'),
          _InfoRow(label: '거래일', value: '${trade.dealYearMonth.substring(0, 4)}년 ${trade.dealYearMonth.substring(4)}월 ${trade.dealDay}일'),
          _InfoRow(label: '층수', value: '${trade.floor}층'),
          _InfoRow(label: '건축년도', value: '${trade.buildYear}년'),
          _InfoRow(label: '평당가', value: '${numberFormat.format(trade.pricePerPyeong.round())}만원'),
          const SizedBox(height: 20),
          // 최근 거래 추이 차트
          if (allTrades.length > 1) ...[
            const Text(
              '최근 거래 추이',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: _buildPriceChart(),
            ),
          ],
          const SizedBox(height: 24),
          // 목표 설정 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSetGoal,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '내 목표로 설정하기',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildPriceChart() {
    // 같은 아파트의 거래만 필터링하고 날짜순 정렬
    final sameTrades = allTrades
        .where((t) => t.apartmentName == trade.apartmentName)
        .toList();

    // 같은 아파트 거래가 2개 미만이면 전체 지역 거래 표시
    final chartTrades = sameTrades.length >= 2 ? sameTrades : allTrades;

    // 거래일 기준 정렬
    chartTrades.sort((a, b) => a.dealDay.compareTo(b.dealDay));

    if (chartTrades.isEmpty) return const SizedBox();

    final spots = chartTrades.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        entry.value.dealAmount.toDouble() / 10000, // 억원 단위
      );
    }).toList();

    final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.1;

    return Container(
      padding: const EdgeInsets.only(right: 16, top: 8),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: (maxY - minY) / 3,
            getDrawingHorizontalLine: (value) => FlLine(
              color: AppColors.surfaceVariant,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < chartTrades.length) {
                    return Text(
                      '${chartTrades[index].dealDay}일',
                      style: const TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 10,
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toStringAsFixed(1)}억',
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (spots.length - 1).toDouble(),
          minY: minY - padding,
          maxY: maxY + padding,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: AppColors.primary,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 정보 행 위젯
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
