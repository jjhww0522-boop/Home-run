import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../providers/dashboard_provider.dart';

/// 비상금 체크 위젯
/// 배우자의 수입 공백을 대비하여 월 생활비 3개월치가 모여있는지 체크
class EmergencyFundWidget extends ConsumerWidget {
  const EmergencyFundWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(dashboardSettingsNotifierProvider);
    final numberFormat = NumberFormat('#,###');

    final targetAmount = settings.targetEmergencyFund;
    final currentAmount = settings.currentEmergencyFund;
    final progress = settings.emergencyFundProgress;
    final remaining = targetAmount - currentAmount;
    final isComplete = progress >= 100;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 헤더
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isComplete
                    ? [
                        AppColors.primary.withOpacity(0.15),
                        AppColors.primary.withOpacity(0.05),
                      ]
                    : [
                        AppColors.warning.withOpacity(0.15),
                        AppColors.warning.withOpacity(0.05),
                      ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isComplete
                        ? AppColors.primary.withOpacity(0.2)
                        : AppColors.warning.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    isComplete ? AppIcons.success : AppIcons.savings,
                    color: isComplete ? AppColors.primary : AppColors.warning,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '비상금 체크',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray900,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isComplete
                                  ? AppColors.primary.withOpacity(0.15)
                                  : AppColors.warning.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isComplete ? '안전' : '부족',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isComplete ? AppColors.primary : AppColors.warning,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${settings.emergencyFundMonths}개월치 생활비 대비',
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 본문
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 진행률 원형 표시
                Row(
                  children: [
                    // 원형 진행률
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Stack(
                        children: [
                          SizedBox.expand(
                            child: CircularProgressIndicator(
                              value: progress / 100,
                              strokeWidth: 8,
                              backgroundColor: AppColors.gray200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isComplete ? AppColors.primary : AppColors.warning,
                              ),
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                          Center(
                            child: Text(
                              '${progress.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: isComplete ? AppColors.primary : AppColors.warning,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),

                    // 금액 정보
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAmountRow(
                            '현재 비상금',
                            '${numberFormat.format(currentAmount)}원',
                            AppColors.gray900,
                          ),
                          const SizedBox(height: 8),
                          _buildAmountRow(
                            '목표 금액',
                            '${numberFormat.format(targetAmount)}원',
                            AppColors.gray600,
                          ),
                          if (!isComplete) ...[
                            const SizedBox(height: 8),
                            _buildAmountRow(
                              '부족 금액',
                              '${numberFormat.format(remaining)}원',
                              AppColors.error,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 안내 메시지
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.infoOutlined,
                        size: 18,
                        color: AppColors.gray600,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          isComplete
                              ? '비상금이 충분히 준비되어 있어요!\n수입 공백이 생겨도 ${settings.emergencyFundMonths}개월간 안정적으로 생활할 수 있어요.'
                              : '수입 공백에 대비해 월 생활비 ${settings.emergencyFundMonths}개월치를\n비상금으로 준비하는 것을 권장해요.',
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray700,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // 월 생활비 정보
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '설정된 월 생활비',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${numberFormat.format(settings.monthlyLivingExpense)}원',
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray900,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => _showEditDialog(context, ref, settings),
                          child: const Icon(
                            AppIcons.edit,
                            size: 16,
                            color: AppColors.gray400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String amount, Color amountColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.gray600,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: amountColor,
          ),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, DashboardSettings settings) {
    final controller = TextEditingController(
      text: (settings.monthlyLivingExpense ~/ 10000).toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '월 생활비 설정',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '한 달 평균 생활비를 입력해주세요.\n비상금 목표 금액 계산에 사용됩니다.',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.gray600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '월 생활비',
                suffixText: '만원',
                filled: true,
                fillColor: AppColors.gray100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = int.tryParse(controller.text) ?? 0;
              if (value > 0) {
                ref.read(dashboardSettingsNotifierProvider.notifier)
                    .updateLivingExpense(value * 10000);
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }
}
