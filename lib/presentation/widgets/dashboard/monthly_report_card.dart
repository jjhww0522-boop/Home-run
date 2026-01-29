import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../providers/dashboard_provider.dart';

/// 이달의 성적표 위젯
/// 수입, 지출, 자산증가를 한눈에 보여주는 요약 카드
class MonthlyReportCard extends ConsumerWidget {
  const MonthlyReportCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(monthlyReportProvider);
    final numberFormat = NumberFormat('#,###');

    return reportAsync.when(
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildErrorState(error.toString()),
      data: (report) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.assessment_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${report.month}월의 성적표',
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 세 개의 카드
            Row(
              children: [
                // 수입 카드
                Expanded(
                  child: _ReportItem(
                    label: '수입',
                    amount: report.totalIncome,
                    numberFormat: numberFormat,
                    color: const Color(0xFF00C853), // 초록색
                    icon: Icons.arrow_upward_rounded,
                  ),
                ),
                const SizedBox(width: 10),

                // 지출 카드
                Expanded(
                  child: _ReportItem(
                    label: '지출',
                    amount: report.totalExpense,
                    numberFormat: numberFormat,
                    color: const Color(0xFFFF6D00), // 주황색
                    icon: Icons.arrow_downward_rounded,
                  ),
                ),
                const SizedBox(width: 10),

                // 자산 증가 카드
                Expanded(
                  child: _ReportItem(
                    label: '저축',
                    amount: report.totalSavings,
                    numberFormat: numberFormat,
                    color: const Color(0xFF7C4DFF), // 보라색
                    icon: Icons.star_rounded,
                  ),
                ),
              ],
            ),

            // 순수익 요약 (수입 - 지출)
            if (report.totalIncome > 0 || report.totalExpense > 0) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: report.netChange >= 0
                      ? const Color(0xFF00C853).withOpacity(0.08)
                      : const Color(0xFFFF6D00).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      report.netChange >= 0
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 18,
                      color: report.netChange >= 0
                          ? const Color(0xFF00C853)
                          : const Color(0xFFFF6D00),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      report.netChange >= 0
                          ? '이번 달 ${_formatCompact(report.netChange)} 흑자'
                          : '이번 달 ${_formatCompact(-report.netChange)} 적자',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: report.netChange >= 0
                            ? const Color(0xFF00C853)
                            : const Color(0xFFFF6D00),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text('오류: $error'),
      ),
    );
  }

  String _formatCompact(int amount) {
    if (amount >= 100000000) {
      double billions = amount / 100000000;
      return '${billions.toStringAsFixed(1)}억원';
    } else if (amount >= 10000) {
      return '${(amount / 10000).toStringAsFixed(0)}만원';
    }
    return '${NumberFormat('#,###').format(amount)}원';
  }
}

/// 개별 리포트 아이템 위젯
class _ReportItem extends StatelessWidget {
  final String label;
  final int amount;
  final NumberFormat numberFormat;
  final Color color;
  final IconData icon;

  const _ReportItem({
    required this.label,
    required this.amount,
    required this.numberFormat,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _formatAmount(amount),
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _formatAmount(int amount) {
    if (amount >= 100000000) {
      return '${(amount / 100000000).toStringAsFixed(1)}억';
    } else if (amount >= 10000000) {
      return '${(amount / 10000).toStringAsFixed(0)}만';
    } else if (amount >= 10000) {
      return '${(amount / 10000).toStringAsFixed(0)}만원';
    }
    return '${numberFormat.format(amount)}원';
  }
}
