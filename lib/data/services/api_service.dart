import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/house_price_model.dart';

/// 국토교통부 부동산 API 서비스
class ApiService {
  static const String _baseUrl =
      'https://apis.data.go.kr/1613000/RTMSDataSvcAptTrade';

  /// 웹용 CORS 프록시 (무료 프록시 서비스)
  static const String _corsProxy = 'https://corsproxy.io/?';

  final Dio _dio;

  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              queryParameters: {},
            ));

  /// API 키 가져오기
  String get _apiKey => dotenv.env['DATA_GO_KR_API_KEY'] ?? '';

  /// 플랫폼에 맞는 URL 생성
  String _buildUrl(String apiUrl) {
    if (kIsWeb) {
      // 웹에서는 CORS 프록시 사용
      return '$_corsProxy${Uri.encodeComponent(apiUrl)}';
    }
    return apiUrl;
  }

  /// 아파트매매 실거래 상세 자료 조회
  ///
  /// [lawdCd] 법정동코드 5자리 (예: 11680 - 강남구)
  /// [dealYm] 계약년월 YYYYMM (예: 202401)
  Future<List<HousePriceModel>> getApartmentTradeDetail({
    required String lawdCd,
    required String dealYm,
  }) async {
    final apiUrl =
        '$_baseUrl/getRTMSDataSvcAptTrade?serviceKey=$_apiKey&LAWD_CD=$lawdCd&DEAL_YMD=$dealYm';
    final url = _buildUrl(apiUrl);

    try {
      final response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        final xmlString = response.data as String;
        return HousePriceModel.parseXmlResponse(xmlString);
      } else {
        throw ApiException(
          message: 'API 호출 실패: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        message: 'API 통신 오류: ${e.message}',
        statusCode: e.response?.statusCode,
      );
    }
  }

  /// 가장 최근 거래 하나 반환
  ///
  /// [lawdCd] 법정동코드 5자리 (예: 11680 - 강남구)
  /// [dealYm] 계약년월 YYYYMM (예: 202401)
  Future<HousePriceModel?> getLatestTrade({
    required String lawdCd,
    required String dealYm,
  }) async {
    final trades = await getApartmentTradeDetail(
      lawdCd: lawdCd,
      dealYm: dealYm,
    );

    if (trades.isEmpty) {
      return null;
    }

    // 거래일 기준으로 정렬하여 가장 최근 거래 반환
    trades.sort((a, b) => b.dealDay.compareTo(a.dealDay));
    return trades.first;
  }
}

/// API 예외 클래스
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'ApiException: $message (statusCode: $statusCode)';
}
