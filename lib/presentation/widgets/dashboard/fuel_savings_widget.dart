import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_button_styles.dart';
import '../../providers/dashboard_provider.dart';

/// 주유비 절약 저금통 위젯
/// 이번 달 주유비가 평균보다 낮으면 차액을 가상 저금통에 저축
class FuelSavingsWidget extends ConsumerWidget {
  const FuelSavingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fuelSavingsAsync = ref.watch(fuelSavingsProvider);
    final settings = ref.watch(dashboardSettingsNotifierProvider);
    final numberFormat = NumberFormat('#,###');

    return fuelSavingsAsync.when(
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildErrorState(error.toString()),
      data: (data) => Container(
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
            // 헤더 - 차량 정보
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF448AFF).withOpacity(0.15),
                    const Color(0xFF448AFF).withOpacity(0.05),
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
                      color: const Color(0xFF448AFF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      AppIcons.transport,
                      color: Color(0xFF448AFF),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '주유비 절약 저금통',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data.carName,
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
                  // 저금통 아이콘
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          AppIcons.savings,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatCompact(settings.virtualSavings),
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
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
                  // 주유비 비교
                  Row(
                    children: [
                      Expanded(
                        child: _buildCostCard(
                          '이번 달 주유비',
                          data.thisMonthCost,
                          numberFormat,
                          const Color(0xFF448AFF),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCostCard(
                          '평균 주유비',
                          data.averageCost,
                          numberFormat,
                          AppColors.gray600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 절약/초과 표시
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: data.hasSavings
                          ? LinearGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.1),
                                AppColors.primary.withOpacity(0.05),
                              ],
                            )
                          : LinearGradient(
                              colors: [
                                AppColors.error.withOpacity(0.1),
                                AppColors.error.withOpacity(0.05),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              data.hasSavings
                                  ? AppIcons.success
                                  : AppIcons.warning,
                              color: data.hasSavings
                                  ? AppColors.primary
                                  : AppColors.error,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              data.hasSavings
                                  ? '${numberFormat.format(data.savings)}원 절약!'
                                  : '${numberFormat.format(-data.savings)}원 초과',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: data.hasSavings
                                    ? AppColors.primary
                                    : AppColors.error,
                              ),
                            ),
                          ],
                        ),
                        if (data.hasSavings) ...[
                          const SizedBox(height: 12),
                          Text(
                            '이 금액을 주택 구매 저금통에 저축할까요?',
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.gray700,
                            ),
                          ),
                          const SizedBox(height: 14),
                          GradientButton(
                            text: '🏠 저금통에 넣기',
                            onPressed: () {
                              ref.read(dashboardSettingsNotifierProvider.notifier)
                                  .addToVirtualSavings(data.savings);
                              _showSuccessDialog(context, data.savings);
                            },
                            height: 48,
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 누적 저금통
                  if (settings.virtualSavings > 0)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            AppIcons.home,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '주택 구매 가상 저금통',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.gray600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${numberFormat.format(settings.virtualSavings)}원',
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.gray900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => _showResetDialog(context, ref),
                            child: const Text(
                              '초기화',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 12,
                                color: AppColors.gray500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 12),

                  // 평균 주유비 설정
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '설정된 평균 주유비',
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
                            '${numberFormat.format(settings.averageFuelCost)}원',
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
      ),
    );
  }

  Widget _buildCostCard(String label, int amount, NumberFormat format, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${format.format(amount)}원',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text('오류: $error'),
      ),
    );
  }

  String _formatCompact(int amount) {
    if (amount >= 10000) {
      return '${(amount / 10000).toStringAsFixed(0)}만원';
    }
    return '${NumberFormat('#,###').format(amount)}원';
  }

  void _showSuccessDialog(BuildContext context, int amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              AppIcons.celebration,
              size: 56,
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              '저금 완료!',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${NumberFormat('#,###').format(amount)}원이\n주택 구매 저금통에 추가되었어요!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.gray600,
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('확인'),
            ),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '저금통 초기화',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          '가상 저금통을 초기화하시겠습니까?\n누적 금액이 0원으로 리셋됩니다.',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.gray600,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(dashboardSettingsNotifierProvider.notifier)
                  .resetVirtualSavings();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('초기화'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, DashboardSettings settings) {
    final controller = TextEditingController(
      text: (settings.averageFuelCost ~/ 10000).toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '평균 주유비 설정',
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
              '한 달 평균 주유비를 입력해주세요.\n절약 금액 계산에 사용됩니다.',
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
                labelText: '평균 주유비',
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
                    .updateAverageFuelCost(value * 10000);
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
