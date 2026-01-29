import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// 빠른 액션 버튼 위젯
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            icon: Icons.add_circle_outline_rounded,
            label: '자산 추가',
            color: AppColors.secondary,
            onTap: () {
              // TODO: 자산 추가 화면
            },
          ),
        ),
        const SizedBox(width: AppSizes.paddingM),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.account_balance_wallet,
            label: '계좌 관리',
            color: AppColors.primary,
            onTap: () {
              context.push('/accounts');
            },
          ),
        ),
        const SizedBox(width: AppSizes.paddingM),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.credit_card,
            label: '카드 관리',
            color: AppColors.accent,
            onTap: () {
              context.push('/credit-cards');
            },
          ),
        ),
        const SizedBox(width: AppSizes.paddingM),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.flag_outlined,
            label: '목표 설정',
            color: AppColors.accent,
            onTap: () {
              // TODO: 목표 설정 화면
            },
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.paddingM,
            horizontal: AppSizes.paddingS,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            border: Border.all(color: AppColors.surfaceVariant),
          ),
          child: Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusS),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: AppSizes.iconM,
                ),
              ),
              const SizedBox(height: AppSizes.paddingS),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppSizes.fontS,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
