import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/number_extensions.dart';

/// 자산 요약 카드 위젯
class AssetSummaryCard extends StatelessWidget {
  const AssetSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 실제 데이터로 교체
    const int totalAssets = 450000000;  // 4.5억
    const int totalDebts = 100000000;   // 1억
    const int netAssets = 350000000;    // 3.5억

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
          // 순자산
          _buildMainAssetRow(
            label: AppStrings.homeNetAsset,
            amount: netAssets,
            isHighlighted: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.paddingM),
            child: Divider(height: 1),
          ),
          // 총 자산 & 총 부채
          Row(
            children: [
              Expanded(
                child: _buildAssetColumn(
                  label: AppStrings.homeTotalAsset,
                  amount: totalAssets,
                  color: AppColors.secondary,
                  icon: Icons.trending_up_rounded,
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: AppColors.surfaceVariant,
              ),
              Expanded(
                child: _buildAssetColumn(
                  label: AppStrings.homeTotalDebt,
                  amount: totalDebts,
                  color: AppColors.error,
                  icon: Icons.trending_down_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainAssetRow({
    required String label,
    required int amount,
    bool isHighlighted = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: const Icon(
                Icons.account_balance_wallet_rounded,
                color: AppColors.primary,
                size: AppSizes.iconS,
              ),
            ),
            const SizedBox(width: AppSizes.paddingM),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppSizes.fontM,
              ),
            ),
          ],
        ),
        Text(
          amount.toCompact,
          style: TextStyle(
            color: isHighlighted ? AppColors.primary : AppColors.textPrimary,
            fontSize: AppSizes.fontXXL,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAssetColumn({
    required String label,
    required int amount,
    required Color color,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: AppSizes.iconXS),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppSizes.fontS,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingXS),
          Text(
            amount.toCompact,
            style: TextStyle(
              color: color,
              fontSize: AppSizes.fontL,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
