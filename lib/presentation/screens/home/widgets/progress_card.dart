import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// 목표 달성률 카드 위젯
class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 실제 데이터로 교체
    const double progressPercent = 35.5;
    const String targetName = '강남구 30평 아파트';
    const String remainingAmount = '6억 4,500만원';

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingL),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.homeProgress,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: AppSizes.fontM,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingS,
                  vertical: AppSizes.paddingXS,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
                child: const Text(
                  targetName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.fontS,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),

          // 퍼센트 표시
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '${progressPercent.toStringAsFixed(1)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  '%',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: AppSizes.fontXXL,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              // 목표 아이콘
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                ),
                child: const Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),

          // 프로그레스 바
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            child: LinearProgressIndicator(
              value: progressPercent / 100,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: AppSizes.progressHeight,
            ),
          ),
          const SizedBox(height: AppSizes.paddingM),

          // 남은 금액
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.goalRemaining,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: AppSizes.fontS,
                ),
              ),
              const Text(
                remainingAmount,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppSizes.fontM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
