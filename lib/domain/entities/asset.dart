import 'package:equatable/equatable.dart';

/// 자산 유형
enum AssetType {
  deposit,        // 예금
  savings,        // 적금
  stock,          // 주식/펀드
  pensionSaving,  // 연금저축펀드
  irp,            // IRP (개인형 퇴직연금)
  jeonseDeposit,  // 전세보증금
  realEstate,     // 부동산
  other,          // 기타
}

/// 자산 Entity
/// 사용자의 개별 자산 항목을 나타냅니다.
class Asset extends Equatable {
  final String id;
  final String name;              // 자산명 (예: "카카오뱅크 적금")
  final AssetType type;           // 자산 유형
  final int amount;               // 현재 금액
  final double? interestRate;     // 이자율 (적금/예금의 경우)
  final DateTime? maturityDate;   // 만기일 (적금/예금의 경우)
  final String? institution;      // 금융기관명
  final String? memo;             // 메모
  final DateTime createdAt;
  final DateTime updatedAt;

  const Asset({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    this.interestRate,
    this.maturityDate,
    this.institution,
    this.memo,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 세액공제 대상 자산인지 확인
  bool get isTaxDeductible =>
      type == AssetType.pensionSaving || type == AssetType.irp;

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        amount,
        interestRate,
        maturityDate,
        institution,
        memo,
        createdAt,
        updatedAt,
      ];
}
