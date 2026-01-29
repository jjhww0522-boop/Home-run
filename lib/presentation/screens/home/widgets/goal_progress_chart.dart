import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// 목표 달성률 원형 차트 위젯
class GoalProgressChart extends StatelessWidget {
  final double progressPercent;
  final String targetName;

  const GoalProgressChart({
    super.key,
    required this.progressPercent,
    required this.targetName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingL),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '목표 달성률',
                style: TextStyle(
                  fontSize: AppSizes.fontL,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingS,
                  vertical: AppSizes.paddingXS,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.home_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      targetName,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: AppSizes.fontS,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingL),

          // 원형 차트
          SizedBox(
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    startDegreeOffset: -90,
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    sections: [
                      // 달성률
                      PieChartSectionData(
                        value: progressPercent,
                        color: AppColors.primary,
                        radius: 24,
                        showTitle: false,
                      ),
                      // 남은 부분
                      PieChartSectionData(
                        value: 100 - progressPercent,
                        color: AppColors.surfaceVariant,
                        radius: 20,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
                // 중앙 텍스트
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${progressPercent.toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '달성',
                      style: TextStyle(
                        fontSize: AppSizes.fontM,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.paddingM),

          // 범례
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('달성', AppColors.primary),
              const SizedBox(width: AppSizes.paddingL),
              _buildLegendItem('남은 목표', AppColors.surfaceVariant),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: AppSizes.fontS,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
