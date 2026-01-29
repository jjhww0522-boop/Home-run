import 'package:equatable/equatable.dart';

/// 수입 유형
enum IncomeType {
  salary,   // 월급
  bonus,    // 성과급/보너스
  other,    // 기타 수입
}

/// 수입 Entity
/// 사용자의 수입 항목을 나타냅니다.
class Income extends Equatable {
  final String id;
  final String name;          // 수입명 (예: "월급", "연말 성과급")
  final IncomeType type;      // 수입 유형
  final int amount;           // 금액
  final int? month;           // 발생 월 (성과급의 경우, 1~12)
  final bool isRecurring;     // 매월 반복 여부 (월급의 경우 true)
  final String? memo;         // 메모
  final DateTime createdAt;
  final DateTime updatedAt;

  const Income({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    this.month,
    required this.isRecurring,
    this.memo,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 연간 총액 계산
  int get annualAmount {
    if (isRecurring) {
      return amount * 12; // 월급은 12개월
    }
    return amount; // 성과급 등은 1회
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        amount,
        month,
        isRecurring,
        memo,
        createdAt,
        updatedAt,
      ];
}
