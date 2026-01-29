import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../data/models/models_stub.dart'
    if (dart.library.io) '../../../data/models/models.dart';

/// 탭별 테마 컬러 정의
class LedgerThemeColors {
  // 수입 - 초록색
  static const Color incomeMain = Color(0xFF00C853);
  static const Color incomeLight = Color(0xFFE8F5E9);
  static const Color incomeDark = Color(0xFF1B5E20);

  // 소비 - 주황색
  static const Color expenseMain = Color(0xFFFF6D00);
  static const Color expenseLight = Color(0xFFFFF3E0);
  static const Color expenseDark = Color(0xFFE65100);

  // 이동/기타 - 파란색
  static const Color transferMain = Color(0xFF2979FF);
  static const Color transferLight = Color(0xFFE3F2FD);
  static const Color transferDark = Color(0xFF1565C0);

  static Color getMainColor(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        return incomeMain;
      case TransactionType.expense:
        return expenseMain;
      case TransactionType.transfer:
        return transferMain;
    }
  }

  static Color getLightColor(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        return incomeLight;
      case TransactionType.expense:
        return expenseLight;
      case TransactionType.transfer:
        return transferLight;
    }
  }
}

/// 거래 내역 카드형 리스트 아이템 위젯
class TransactionListItem extends StatelessWidget {
  final TransactionModel transaction;
  final PaymentMethodModel? paymentMethod;
  final PaymentMethodModel? depositAccount;  // 이동 탭용 입금 계좌
  final PaymentMethodModel? withdrawAccount; // 이동 탭용 출금 계좌
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.paymentMethod,
    this.depositAccount,
    this.withdrawAccount,
    this.onTap,
    this.onDelete,
  });

  IconData get _categoryIcon {
    switch (transaction.category) {
      case TransactionCategory.salary:
        return AppIcons.salary;
      case TransactionCategory.bonus:
        return AppIcons.bonus;
      case TransactionCategory.investment:
        return AppIcons.investment;
      case TransactionCategory.sideJob:
        return AppIcons.sideJob;
      case TransactionCategory.otherIncome:
        return AppIcons.otherIncome;
      case TransactionCategory.food:
        return AppIcons.food;
      case TransactionCategory.transport:
        return AppIcons.transport;
      case TransactionCategory.housing:
        return AppIcons.housing;
      case TransactionCategory.medical:
        return AppIcons.medical;
      case TransactionCategory.education:
        return AppIcons.education;
      case TransactionCategory.culture:
        return AppIcons.culture;
      case TransactionCategory.clothing:
        return AppIcons.clothing;
      case TransactionCategory.living:
        return AppIcons.shopping;
      case TransactionCategory.social:
        return AppIcons.social;
      case TransactionCategory.financial:
        return AppIcons.financial;
      case TransactionCategory.otherExpense:
        return AppIcons.more;
      // 저축/투자
      case TransactionCategory.savingsDeposit:
        return AppIcons.savingsDeposit;
      case TransactionCategory.stock:
        return AppIcons.stock;
      case TransactionCategory.fund:
        return AppIcons.fund;
      case TransactionCategory.insurance:
        return AppIcons.insurance;
      case TransactionCategory.pension:
        return AppIcons.pension;
      case TransactionCategory.crypto:
        return AppIcons.crypto;
      case TransactionCategory.otherSavings:
        return AppIcons.otherSavings;
    }
  }

  Color get _themeColor => LedgerThemeColors.getMainColor(transaction.type);
  Color get _themeLightColor => LedgerThemeColors.getLightColor(transaction.type);

  String get _amountPrefix {
    switch (transaction.type) {
      case TransactionType.income:
        return '+';
      case TransactionType.expense:
        return '-';
      case TransactionType.transfer:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');
    final timeFormat = DateFormat('HH:mm');

    return Dismissible(
      key: Key(transaction.uid),
      direction: onDelete != null ? DismissDirection.endToStart : DismissDirection.none,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(AppIcons.delete, color: Colors.white, size: 24),
      ),
      confirmDismiss: (direction) async {
        onDelete?.call();
        return false; // 직접 삭제하지 않고 provider에서 처리
      },
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.08),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: transaction.type == TransactionType.transfer
                ? _buildTransferLayout(numberFormat, timeFormat)
                : _buildDefaultLayout(numberFormat, timeFormat),
          ),
        ),
      ),
    );
  }

  /// 기본 레이아웃 (수입/소비)
  Widget _buildDefaultLayout(NumberFormat numberFormat, DateFormat timeFormat) {
    return Row(
      children: [
        // 카테고리 아이콘 (CircleAvatar)
        CircleAvatar(
          radius: 24,
          backgroundColor: _themeLightColor,
          child: Icon(
            _categoryIcon,
            color: _themeColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),

        // 중앙 내용
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목 (Medium) + 고정비 아이콘
              Row(
                children: [
                  Expanded(
                    child: Text(
                      transaction.description?.isNotEmpty == true
                          ? transaction.description!
                          : transaction.category.displayName,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (transaction.isRecurring) ...[
                    const SizedBox(width: 6),
                    Icon(
                      AppIcons.repeat,
                      size: 16,
                      color: _themeColor,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),

              // 카테고리 + 결제수단 배지
              Row(
                children: [
                  // 카테고리 Chip
                  _CategoryChip(
                    label: transaction.category.displayName,
                    color: _themeColor,
                  ),
                  if (paymentMethod != null) ...[
                    const SizedBox(width: 6),
                    _PaymentMethodChip(paymentMethod: paymentMethod!),
                  ],
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),

        // 우측: 금액 + 시간
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // 금액 (Bold, 가장 크게)
            Text(
              '$_amountPrefix${numberFormat.format(transaction.amount)}원',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _themeColor,
              ),
            ),
            const SizedBox(height: 4),
            // 시간 (Small, Gray)
            Text(
              timeFormat.format(transaction.date),
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
    );
  }

  /// 저축 탭 특화 레이아웃 ([출금 계좌] → [입금 계좌])
  Widget _buildTransferLayout(NumberFormat numberFormat, DateFormat timeFormat) {
    final fromAccount = withdrawAccount?.name ?? '출금';
    final toAccount = depositAccount?.name ?? '입금';

    return Column(
      children: [
        Row(
          children: [
            // 카테고리 아이콘
            CircleAvatar(
              radius: 24,
              backgroundColor: _themeLightColor,
              child: Icon(
                _categoryIcon,
                color: _themeColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),

            // 계좌 흐름 표시
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목
                  Text(
                    transaction.description?.isNotEmpty == true
                        ? transaction.description!
                        : transaction.category.displayName,
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray900,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // [출금 계좌] → [입금 계좌] 흐름
                  Row(
                    children: [
                      _AccountFlowChip(
                        accountName: fromAccount,
                        isSource: true,
                        paymentMethod: withdrawAccount,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          AppIcons.arrowForward,
                          size: 16,
                          color: _themeColor,
                        ),
                      ),
                      _AccountFlowChip(
                        accountName: toAccount,
                        isSource: false,
                        paymentMethod: depositAccount,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 하단: 금액 + 시간
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 카테고리 Chip
            _CategoryChip(
              label: transaction.category.displayName,
              color: _themeColor,
            ),
            Row(
              children: [
                // 시간
                Text(
                  timeFormat.format(transaction.date),
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray500,
                  ),
                ),
                const SizedBox(width: 12),
                // 금액
                Text(
                  '${numberFormat.format(transaction.amount)}원',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _themeColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// 카테고리 Chip 위젯
class _CategoryChip extends StatelessWidget {
  final String label;
  final Color color;

  const _CategoryChip({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

/// 결제 수단 Chip 위젯 (금융사 브랜드 컬러 적용)
class _PaymentMethodChip extends StatelessWidget {
  final PaymentMethodModel paymentMethod;

  const _PaymentMethodChip({required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    final brandColorValue = PaymentMethodColors.getBrandColor(paymentMethod.name);
    final brandColor = Color(brandColorValue);
    final isLight = PaymentMethodColors.isLightColor(brandColorValue);
    final textColor = isLight ? Colors.black87 : Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: brandColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        paymentMethod.name,
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

/// 계좌 흐름 Chip 위젯 (이동 탭용)
class _AccountFlowChip extends StatelessWidget {
  final String accountName;
  final bool isSource;
  final PaymentMethodModel? paymentMethod;

  const _AccountFlowChip({
    required this.accountName,
    required this.isSource,
    this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    if (paymentMethod != null) {
      final brandColorValue = PaymentMethodColors.getBrandColor(paymentMethod!.name);
      bgColor = Color(brandColorValue);
      textColor = PaymentMethodColors.isLightColor(brandColorValue)
          ? Colors.black87
          : Colors.white;
    } else {
      bgColor = isSource
          ? LedgerThemeColors.expenseLight
          : LedgerThemeColors.incomeLight;
      textColor = isSource
          ? LedgerThemeColors.expenseMain
          : LedgerThemeColors.incomeMain;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: paymentMethod == null
            ? Border.all(
                color: isSource
                    ? LedgerThemeColors.expenseMain.withOpacity(0.3)
                    : LedgerThemeColors.incomeMain.withOpacity(0.3),
                width: 1,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSource ? AppIcons.expense : AppIcons.income,
            size: 12,
            color: textColor,
          ),
          const SizedBox(width: 4),
          Text(
            accountName,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// 날짜 구분선 위젯
class DateDivider extends StatelessWidget {
  final DateTime date;
  final Color? themeColor;

  const DateDivider({
    super.key,
    required this.date,
    this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
    final isYesterday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1;

    String dateText;
    if (isToday) {
      dateText = '오늘';
    } else if (isYesterday) {
      dateText = '어제';
    } else {
      dateText = DateFormat('M월 d일 (E)', 'ko_KR').format(date);
    }

    final color = themeColor ?? AppColors.gray500;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              dateText,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 1,
              color: color.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
