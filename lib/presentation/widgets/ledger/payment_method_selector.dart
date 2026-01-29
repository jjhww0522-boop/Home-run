import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/models_stub.dart'
    if (dart.library.io) '../../../data/models/models.dart';

/// 결제 수단 선택 위젯
class PaymentMethodSelector extends StatelessWidget {
  final List<PaymentMethodModel> paymentMethods;
  final int? selectedId;
  final ValueChanged<PaymentMethodModel> onSelected;
  final String label;

  const PaymentMethodSelector({
    super.key,
    required this.paymentMethods,
    this.selectedId,
    required this.onSelected,
    this.label = '결제 수단',
  });

  IconData _getTypeIcon(PaymentMethodType type) {
    switch (type) {
      case PaymentMethodType.bankAccount:
        return Icons.account_balance;
      case PaymentMethodType.creditCard:
        return Icons.credit_card;
      case PaymentMethodType.debitCard:
        return Icons.payment;
      case PaymentMethodType.cash:
        return Icons.payments;
    }
  }

  Color _getTypeColor(PaymentMethodType type) {
    switch (type) {
      case PaymentMethodType.bankAccount:
        return AppColors.info;
      case PaymentMethodType.creditCard:
        return AppColors.warning;
      case PaymentMethodType.debitCard:
        return AppColors.secondary;
      case PaymentMethodType.cash:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: paymentMethods.map((method) {
              final isSelected = selectedId == method.id;
              return _PaymentMethodTile(
                method: method,
                icon: _getTypeIcon(method.type),
                iconColor: _getTypeColor(method.type),
                isSelected: isSelected,
                onTap: () => onSelected(method),
                isFirst: method == paymentMethods.first,
                isLast: method == paymentMethods.last,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final PaymentMethodModel method;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  const _PaymentMethodTile({
    required this.method,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
          borderRadius: BorderRadius.vertical(
            top: isFirst ? const Radius.circular(12) : Radius.zero,
            bottom: isLast ? const Radius.circular(12) : Radius.zero,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (method.memo != null)
                    Text(
                      method.memo!,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textTertiary,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
