import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/credit_card_model.dart';

/// 신용카드 위젯
/// Material 3 디자인, Pretendard 폰트 적용
class CreditCardWidget extends StatelessWidget {
  final CreditCardModel card;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CreditCardWidget({
    super.key,
    required this.card,
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
              const SizedBox(height: 16),
              _buildUsageInfo(),
              const SizedBox(height: 12),
              _buildAchievementProgress(),
              const SizedBox(height: 12),
              _buildPaymentInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final brandColor = Color(CardIssuerColors.getBrandColor(card.issuer));

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: brandColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            card.cardType == CardType.credit
                ? Icons.credit_card
                : Icons.payment,
            size: 24,
            color: brandColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card.name,
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
                      color: brandColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      card.cardType.displayName,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: brandColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    card.issuer,
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray500,
                    ),
                  ),
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

  Widget _buildUsageInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '현재 사용액',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                CurrencyFormatter.formatWon(card.currentUsage),
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray900,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '목표 실적',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.gray500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              CurrencyFormatter.formatWon(card.targetAmount),
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.gray700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementProgress() {
    final rate = card.achievementRate;
    final statusColor = Color(card.achievementColorCode);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    card.achievementStatus,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '${rate.toStringAsFixed(1)}%',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: rate / 100,
            minHeight: 8,
            backgroundColor: AppColors.gray200,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
        ),
        if (card.remainingToTarget > 0) ...[
          const SizedBox(height: 8),
          Text(
            '${CurrencyFormatter.formatWon(card.remainingToTarget)} 더 사용하면 달성!',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.gray600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPaymentInfo() {
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
              label: '결제일',
              value: '매월 ${card.paymentDay}일',
            ),
          ),
          Container(
            width: 1,
            height: 32,
            color: AppColors.gray200,
          ),
          Expanded(
            child: _buildInfoItem(
              icon: Icons.schedule_outlined,
              label: '결제일까지',
              value: '${card.daysUntilPayment}일',
              isWarning: card.daysUntilPayment <= 3,
            ),
          ),
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
}
