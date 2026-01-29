import 'package:equatable/equatable.dart';

/// 월별 요약 Entity
/// 매월 자산 현황을 스냅샷으로 저장합니다.
class MonthlySummary extends Equatable {
  final String id;
  final int year;               // 연도
  final int month;              // 월 (1~12)
  final int totalAssets;        // 총 자산
  final int totalDebts;         // 총 부채
  final int netAssets;          // 순자산 (총 자산 - 총 부채)
  final int totalIncome;        // 해당 월 총 수입
  final int totalSavings;       // 해당 월 저축액
  final double savingsRate;     // 저축률 (저축액 / 수입 * 100)
  final double goalProgress;    // 목표 달성률 (%)
  final DateTime createdAt;

  const MonthlySummary({
    required this.id,
    required this.year,
    required this.month,
    required this.totalAssets,
    required this.totalDebts,
    required this.netAssets,
    required this.totalIncome,
    required this.totalSavings,
    required this.savingsRate,
    required this.goalProgress,
    required this.createdAt,
  });

  /// 전월 대비 순자산 변화 계산 (외부에서 전월 데이터와 비교)
  int getNetAssetChange(MonthlySummary? previousMonth) {
    if (previousMonth == null) return 0;
    return netAssets - previousMonth.netAssets;
  }

  @override
  List<Object?> get props => [
        id,
        year,
        month,
        totalAssets,
        totalDebts,
        netAssets,
        totalIncome,
        totalSavings,
        savingsRate,
        goalProgress,
        createdAt,
      ];
}
