import 'package:equatable/equatable.dart';

/// 부채 유형
enum DebtType {
  bankLoanFixed,     // 은행 대출 (고정 금리)
  bankLoanVariable,  // 은행 대출 (변동 금리)
  companyLoan,       // 사내 대출
  other,             // 기타 부채
}

/// 금리 유형
enum InterestRateType {
  fixed,    // 고정 금리
  variable, // 변동 금리
}

/// 부채 Entity
/// 사용자의 개별 부채 항목을 나타냅니다.
class Debt extends Equatable {
  final String id;
  final String name;                    // 부채명 (예: "주택담보대출")
  final DebtType type;                  // 부채 유형
  final int principalAmount;            // 원금
  final int remainingAmount;            // 남은 금액
  final double interestRate;            // 이자율
  final InterestRateType interestType;  // 금리 유형 (고정/변동)
  final int monthlyPayment;             // 월 상환액
  final DateTime startDate;             // 대출 시작일
  final DateTime? endDate;              // 대출 만기일
  final String? institution;            // 금융기관명
  final String? memo;                   // 메모
  final DateTime createdAt;
  final DateTime updatedAt;

  const Debt({
    required this.id,
    required this.name,
    required this.type,
    required this.principalAmount,
    required this.remainingAmount,
    required this.interestRate,
    required this.interestType,
    required this.monthlyPayment,
    required this.startDate,
    this.endDate,
    this.institution,
    this.memo,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 상환 진행률 (%)
  double get repaymentProgress {
    if (principalAmount == 0) return 100;
    return ((principalAmount - remainingAmount) / principalAmount) * 100;
  }

  /// 은행 대출인지 확인
  bool get isBankLoan =>
      type == DebtType.bankLoanFixed || type == DebtType.bankLoanVariable;

  /// 사내 대출인지 확인
  bool get isCompanyLoan => type == DebtType.companyLoan;

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        principalAmount,
        remainingAmount,
        interestRate,
        interestType,
        monthlyPayment,
        startDate,
        endDate,
        institution,
        memo,
        createdAt,
        updatedAt,
      ];
}
