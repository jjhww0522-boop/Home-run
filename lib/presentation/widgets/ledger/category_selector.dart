import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/models_stub.dart'
    if (dart.library.io) '../../../data/models/models.dart';
import '../../providers/ledger_provider.dart';

/// 카테고리 선택 위젯
class CategorySelector extends ConsumerWidget {
  final TransactionType transactionType;
  final TransactionCategory? selectedCategory;
  final String? selectedCustomCategoryId;
  final ValueChanged<TransactionCategory> onSelected;
  final ValueChanged<String>? onCustomCategorySelected;
  final ValueChanged<TransactionCategory>? onLongPress;
  final ValueChanged<String>? onCustomCategoryLongPress;
  final VoidCallback? onManage;

  const CategorySelector({
    super.key,
    required this.transactionType,
    this.selectedCategory,
    this.selectedCustomCategoryId,
    required this.onSelected,
    this.onCustomCategorySelected,
    this.onLongPress,
    this.onCustomCategoryLongPress,
    this.onManage,
  });

  List<TransactionCategory> get _categories {
    switch (transactionType) {
      case TransactionType.income:
        return TransactionCategoryExtension.incomeCategories;
      case TransactionType.expense:
        return TransactionCategoryExtension.expenseCategories;
      case TransactionType.transfer:
        return TransactionCategoryExtension.savingsCategories;
    }
  }

  IconData _getCategoryIcon(TransactionCategory category) {
    switch (category) {
      // 소득
      case TransactionCategory.salary:
        return Icons.work_outline;
      case TransactionCategory.bonus:
        return Icons.card_giftcard;
      case TransactionCategory.investment:
        return Icons.trending_up;
      case TransactionCategory.sideJob:
        return Icons.add_business;
      case TransactionCategory.otherIncome:
        return Icons.attach_money;
      // 지출
      case TransactionCategory.food:
        return Icons.restaurant;
      case TransactionCategory.transport:
        return Icons.directions_car;
      case TransactionCategory.housing:
        return Icons.home;
      case TransactionCategory.medical:
        return Icons.local_hospital;
      case TransactionCategory.education:
        return Icons.school;
      case TransactionCategory.culture:
        return Icons.movie;
      case TransactionCategory.clothing:
        return Icons.checkroom;
      case TransactionCategory.living:
        return Icons.shopping_cart;
      case TransactionCategory.social:
        return Icons.people;
      case TransactionCategory.financial:
        return Icons.account_balance;
      case TransactionCategory.otherExpense:
        return Icons.more_horiz;
      // 저축/투자
      case TransactionCategory.savingsDeposit:
        return Icons.savings_rounded;
      case TransactionCategory.stock:
        return Icons.candlestick_chart_rounded;
      case TransactionCategory.fund:
        return Icons.pie_chart_rounded;
      case TransactionCategory.insurance:
        return Icons.health_and_safety_rounded;
      case TransactionCategory.pension:
        return Icons.elderly_rounded;
      case TransactionCategory.crypto:
        return Icons.currency_bitcoin_rounded;
      case TransactionCategory.otherSavings:
        return Icons.wallet_rounded;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customCategoriesAsync = ref.watch(
      customTransactionCategoriesByTypeProvider(transactionType),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '카테고리',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
            if (onManage != null)
              GestureDetector(
                onTap: onManage,
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined, size: 16, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      '관리',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // 기본 카테고리
            ..._categories.map((category) {
              final isSelected = selectedCategory == category && selectedCustomCategoryId == null;
              return _CategoryChip(
                icon: _getCategoryIcon(category),
                label: category.displayName,
                isSelected: isSelected,
                onTap: () => onSelected(category),
                onLongPress: onLongPress != null ? () => onLongPress!(category) : null,
              );
            }),
            // 사용자 정의 카테고리
            ...customCategoriesAsync.when(
              loading: () => [],
              error: (_, __) => [],
              data: (customCategories) => customCategories.map((custom) {
                final isSelected = selectedCustomCategoryId == custom.uid;
                return _CategoryChip(
                  icon: null,
                  emoji: custom.iconName,
                  label: custom.name,
                  isSelected: isSelected,
                  color: Color(custom.colorValue),
                  onTap: () {
                    if (onCustomCategorySelected != null) {
                      onCustomCategorySelected!(custom.uid);
                    }
                  },
                  onLongPress: onCustomCategoryLongPress != null
                      ? () => onCustomCategoryLongPress!(custom.uid)
                      : null,
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final String label;
  final bool isSelected;
  final Color? color;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _CategoryChip({
    this.icon,
    this.emoji,
    required this.label,
    required this.isSelected,
    this.color,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? chipColor : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? chipColor : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (emoji != null)
              Text(
                emoji!,
                style: const TextStyle(fontSize: 18),
              )
            else if (icon != null)
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
