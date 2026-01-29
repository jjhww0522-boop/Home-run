import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/number_extensions.dart';
import '../../../../domain/entities/home_goal.dart';
import '../../../providers/home_goal_provider.dart';

/// 순자산 & 목표 실거래가 요약 카드
class SummaryCards extends ConsumerWidget {
  final int netAssets;
  final int targetPrice;
  final String? lastTradeDate;
  final String? apartmentName;
  final double? exclusiveArea;

  const SummaryCards({
    super.key,
    required this.netAssets,
    required this.targetPrice,
    this.lastTradeDate,
    this.apartmentName,
    this.exclusiveArea,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        // 내 순자산 카드
        Expanded(
          child: _SummaryCard(
            icon: Icons.account_balance_wallet_rounded,
            iconColor: AppColors.secondary,
            iconBgColor: AppColors.secondary.withValues(alpha: 0.1),
            label: '내 순자산',
            amount: netAssets,
            amountColor: AppColors.secondary,
            subtitle: '총 자산 - 부채',
          ),
        ),
        const SizedBox(width: AppSizes.paddingM),
        // 목표 아파트 실거래가 카드
        Expanded(
          child: _GoalCard(
            apartmentName: apartmentName,
            amount: targetPrice,
            exclusiveArea: exclusiveArea,
            lastTradeDate: lastTradeDate,
            onDirectSetting: () => _showDirectSettingSheet(context, ref),
          ),
        ),
      ],
    );
  }

  /// 직접설정 바텀시트 표시
  void _showDirectSettingSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DirectSettingSheet(
        initialName: apartmentName,
        initialArea: exclusiveArea,
        initialPrice: targetPrice,
        onSaved: (name, area, price) async {
          final now = DateTime.now();
          final goal = HomeGoal(
            id: const Uuid().v4(),
            name: name,
            apartmentName: name,
            exclusiveArea: area,
            targetPrice: price,
            createdAt: now,
            updatedAt: now,
          );
          await ref.read(homeGoalNotifierProvider.notifier).setGoal(goal);
          if (context.mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('목표가 설정되었습니다'),
                backgroundColor: AppColors.primary,
              ),
            );
          }
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final int amount;
  final Color amountColor;
  final String subtitle;

  const _SummaryCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    required this.amount,
    required this.amountColor,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 아이콘 & 라벨
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(AppSizes.radiusS),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSizes.paddingS),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: AppSizes.fontS,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),

          // 금액
          Text(
            amount.toCompact,
            style: TextStyle(
              fontSize: AppSizes.fontXXL,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
          const SizedBox(height: AppSizes.paddingXS),

          // 서브타이틀
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: AppSizes.fontXS,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

/// 목표 아파트 카드
class _GoalCard extends StatelessWidget {
  final String? apartmentName;
  final int amount;
  final double? exclusiveArea;
  final String? lastTradeDate;
  final VoidCallback? onDirectSetting;

  const _GoalCard({
    this.apartmentName,
    required this.amount,
    this.exclusiveArea,
    this.lastTradeDate,
    this.onDirectSetting,
  });

  @override
  Widget build(BuildContext context) {
    final pyeong = exclusiveArea != null
        ? (exclusiveArea! / 3.3058).toStringAsFixed(0)
        : null;

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 아이콘 & 라벨
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusS),
                ),
                child: const Icon(
                  Icons.apartment_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSizes.paddingS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '목표 아파트',
                      style: TextStyle(
                        fontSize: AppSizes.fontXS,
                        color: AppColors.textTertiary,
                      ),
                    ),
                    if (apartmentName != null)
                      Text(
                        apartmentName!,
                        style: const TextStyle(
                          fontSize: AppSizes.fontS,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),

          // 금액
          Text(
            amount > 0 ? amount.toCompact : '목표 미설정',
            style: TextStyle(
              fontSize: AppSizes.fontXXL,
              fontWeight: FontWeight.bold,
              color: amount > 0 ? AppColors.primary : AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSizes.paddingXS),

          // 면적 & 거래일
          Row(
            children: [
              if (pyeong != null) ...[
                Text(
                  '$pyeong평',
                  style: const TextStyle(
                    fontSize: AppSizes.fontXS,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  lastTradeDate ?? '',
                  style: const TextStyle(
                    fontSize: AppSizes.fontXS,
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingS),
          // 직접설정 버튼
          GestureDetector(
            onTap: onDirectSetting,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingS,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_rounded,
                    size: 12,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '직접설정',
                    style: TextStyle(
                      fontSize: AppSizes.fontXS,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 목표 직접설정 바텀시트
class _DirectSettingSheet extends StatefulWidget {
  final String? initialName;
  final double? initialArea;
  final int initialPrice;
  final Function(String name, double area, int price) onSaved;

  const _DirectSettingSheet({
    this.initialName,
    this.initialArea,
    required this.initialPrice,
    required this.onSaved,
  });

  @override
  State<_DirectSettingSheet> createState() => _DirectSettingSheetState();
}

class _DirectSettingSheetState extends State<_DirectSettingSheet> {
  late TextEditingController _nameController;
  late TextEditingController _areaController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');

    // 평수 변환 (제곱미터 -> 평)
    final initialPyeong = widget.initialArea != null
        ? (widget.initialArea! / 3.3058).toStringAsFixed(0)
        : '';
    _areaController = TextEditingController(text: initialPyeong);

    // 가격 변환 (원 -> 억원)
    final initialBillion = widget.initialPrice > 0
        ? (widget.initialPrice / 100000000).toStringAsFixed(1)
        : '';
    _priceController = TextEditingController(text: initialBillion);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아파트 이름을 입력해주세요')),
      );
      return;
    }

    final pyeong = double.tryParse(_areaController.text.trim()) ?? 0;
    final areaSqm = pyeong * 3.3058; // 평 -> 제곱미터

    final billion = double.tryParse(_priceController.text.trim()) ?? 0;
    final priceWon = (billion * 100000000).toInt(); // 억원 -> 원

    if (priceWon <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('목표 가격을 입력해주세요')),
      );
      return;
    }

    widget.onSaved(name, areaSqm, priceWon);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 핸들
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // 헤더
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  '목표 아파트 설정',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // 폼
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 아파트 이름
                  const Text(
                    '아파트 이름',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: '예: 래미안 퍼스티지',
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 평수
                  const Text(
                    '평수',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _areaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '예: 34',
                      suffixText: '평',
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 목표 가격
                  const Text(
                    '목표 가격',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _priceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: '예: 15.5',
                      suffixText: '억원',
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 저장 버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '저장',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
