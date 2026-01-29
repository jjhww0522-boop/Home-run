import 'package:equatable/equatable.dart';

/// 목표 주택 Entity
/// 사용자의 내집마련 목표를 나타냅니다.
class HomeGoal extends Equatable {
  final String id;
  final String name;              // 목표명 (예: "강남구 30평 아파트")
  final String? regionCode;       // 지역 코드 (국토교통부 API용, 예: "11680")
  final String? address;          // 목표 지역/주소
  final String? apartmentName;    // 아파트명
  final double? exclusiveArea;    // 전용면적 (㎡)
  final int targetPrice;          // 목표 금액 (실거래가 기준)
  final int? downPayment;         // 계약금 (보통 10%)
  final int? intermediatePayment; // 중도금
  final int? balance;             // 잔금
  final DateTime? targetDate;     // 목표 달성 예정일
  final String? memo;             // 메모
  final DateTime createdAt;
  final DateTime updatedAt;

  const HomeGoal({
    required this.id,
    required this.name,
    this.regionCode,
    this.address,
    this.apartmentName,
    this.exclusiveArea,
    required this.targetPrice,
    this.downPayment,
    this.intermediatePayment,
    this.balance,
    this.targetDate,
    this.memo,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 계약금 비율 (기본 10%)
  int get calculatedDownPayment => downPayment ?? (targetPrice * 0.1).toInt();

  @override
  List<Object?> get props => [
        id,
        name,
        regionCode,
        address,
        apartmentName,
        exclusiveArea,
        targetPrice,
        downPayment,
        intermediatePayment,
        balance,
        targetDate,
        memo,
        createdAt,
        updatedAt,
      ];
}
