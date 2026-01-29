import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/account_model.dart';

/// 계좌 카드 위젯
/// Material 3 디자인, Pretendard 폰트 적용
class AccountCard extends StatelessWidget {
  final AccountModel account;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AccountCard({
    super.key,
    required this.account,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildBalance(),
              if (account.type.requiresMaturityDate) ...[
                const SizedBox(height: 12),
                _buildMaturityInfo(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getTypeColor().withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getTypeIcon(),
            size: 22,
            color: _getTypeColor(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                account.name,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor().withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      account.type.displayName,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _getTypeColor(),
                      ),
                    ),
                  ),
                  if (account.institution != null) ...[
                    const SizedBox(width: 6),
                    Text(
                      account.institution!,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        if (onEdit != null || onDelete != null)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.gray400),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              if (value == 'edit') onEdit?.call();
              if (value == 'delete') onDelete?.call();
            },
            itemBuilder: (context) => [
              if (onEdit != null)
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined, size: 20),
                      SizedBox(width: 8),
                      Text('수정'),
                    ],
                  ),
                ),
              if (onDelete != null)
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, size: 20, color: AppColors.error),
                      SizedBox(width: 8),
                      Text('삭제', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildBalance() {
    return Text(
      CurrencyFormatter.formatWon(account.balance),
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.gray900,
      ),
    );
  }

  Widget _buildMaturityInfo() {
    final daysRemaining = account.daysUntilMaturity;
    final expectedInterest = account.expectedInterestAfterTax;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildInfoItem(
              icon: Icons.calendar_today_outlined,
              label: '만기까지',
              value: daysRemaining != null ? '$daysRemaining일' : '-',
              isWarning: daysRemaining != null && daysRemaining <= 30,
            ),
          ),
          Container(
            width: 1,
            height: 32,
            color: AppColors.gray200,
          ),
          Expanded(
            child: _buildInfoItem(
              icon: Icons.attach_money_outlined,
              label: '예상 이자',
              value: expectedInterest != null
                  ? CurrencyFormatter.formatWon(expectedInterest.round())
                  : '-',
            ),
          ),
          if (account.interestRate != null) ...[
            Container(
              width: 1,
              height: 32,
              color: AppColors.gray200,
            ),
            Expanded(
              child: _buildInfoItem(
                icon: Icons.percent_outlined,
                label: '이자율',
                value: '${account.interestRate!.toStringAsFixed(2)}%',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    bool isWarning = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.gray500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isWarning ? AppColors.error : AppColors.gray900,
          ),
        ),
      ],
    );
  }

  Color _getTypeColor() {
    switch (account.type) {
      case AccountType.checking:
        return const Color(0xFF3B82F6); // blue
      case AccountType.parking:
        return const Color(0xFF8B5CF6); // violet
      case AccountType.deposit:
        return const Color(0xFF10B981); // emerald
      case AccountType.savings:
        return const Color(0xFFF59E0B); // amber
      case AccountType.subscription:
        return const Color(0xFFEC4899); // pink
    }
  }

  IconData _getTypeIcon() {
    switch (account.type) {
      case AccountType.checking:
        return Icons.account_balance_wallet_outlined;
      case AccountType.parking:
        return Icons.savings_outlined;
      case AccountType.deposit:
        return Icons.lock_clock_outlined;
      case AccountType.savings:
        return Icons.trending_up_outlined;
      case AccountType.subscription:
        return Icons.home_work_outlined;
    }
  }
}
