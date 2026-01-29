import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/utils/version_utils.dart';
import '../../pages/ledger_page.dart';
import '../../pages/target_map_page.dart';
import '../../providers/home_goal_provider.dart';
import '../../widgets/dashboard/pixel_baseball_field.dart';
import '../../widgets/dashboard/emergency_fund_widget.dart';
import '../../widgets/dashboard/fuel_savings_widget.dart';
import '../../widgets/dashboard/monthly_report_card.dart';
import 'widgets/summary_cards.dart';
import 'widgets/quick_actions.dart';

/// 메인 홈 화면 - 홈런 대시보드
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider에서 목표 데이터 가져오기
    final goalAsync = ref.watch(homeGoalNotifierProvider);

    final goal = goalAsync.valueOrNull;
    final targetName = goal?.apartmentName ?? '목표를 설정하세요';
    final targetPrice = goal?.targetPrice ?? 0;
    const int netAssets = 350000000; // 3.5억 (TODO: 자산 Provider 연동)
    final double progressPercent = targetPrice > 0
        ? (netAssets / targetPrice * 100).clamp(0, 100)
        : 0;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // 밝은 초록 배경 (픽셀 아트 느낌)
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 앱바
            SliverAppBar(
              floating: true,
              backgroundColor: AppColors.background,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(
                  left: AppSizes.paddingM,
                  bottom: AppSizes.paddingM,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppStrings.homeGreeting,
                          style: TextStyle(
                            fontSize: AppSizes.fontS,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          VersionUtils.displayVersion,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textTertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '홈런 대시보드',
                      style: TextStyle(
                        fontSize: AppSizes.fontL,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2, // 픽셀 폰트 느낌
                        shadows: [
                          Shadow(
                            color: AppColors.primary.withOpacity(0.3),
                            offset: const Offset(2, 2),
                            blurRadius: 0, // 선명한 그림자
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    AppIcons.notificationOutlined,
                    color: AppColors.textPrimary,
                    size: 26,
                  ),
                  onPressed: () {
                    // TODO: 알림 화면
                  },
                ),
                IconButton(
                  icon: const Icon(
                    AppIcons.settingsOutlined,
                    color: AppColors.textPrimary,
                    size: 26,
                  ),
                  onPressed: () {
                    // TODO: 설정 화면
                  },
                ),
                const SizedBox(width: AppSizes.paddingXS),
              ],
            ),

            // 컨텐츠
            SliverPadding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // 1. 목표 달성률 야구장 차트 (픽셀 아트 스타일)
                  PixelBaseballField(
                    progressPercent: progressPercent,
                    targetName: targetName,
                    currentAssets: netAssets,
                    targetAssets: targetPrice,
                  ),
                  const SizedBox(height: AppSizes.paddingM),

                  // 2. 순자산 & 목표 실거래가 (나란히)
                  SummaryCards(
                    netAssets: netAssets,
                    targetPrice: targetPrice,
                    apartmentName: goal?.apartmentName,
                    exclusiveArea: goal?.exclusiveArea,
                    lastTradeDate: goal != null
                        ? DateFormat('yyyy.MM').format(goal.updatedAt)
                        : null,
                  ),
                  const SizedBox(height: AppSizes.paddingM),

                  // 3. 남은 금액 안내 (귀여운 스타일)
                  _buildPixelRemainingCard(netAssets, targetPrice),
                  const SizedBox(height: AppSizes.paddingL),

                  // 4. 이달의 성적표
                  _buildSectionTitle('이달의 성적표'),
                  const SizedBox(height: AppSizes.paddingS),
                  const MonthlyReportCard(),
                  const SizedBox(height: AppSizes.paddingL),

                  // 5. 빠른 액션 버튼들
                  const QuickActions(),
                  const SizedBox(height: AppSizes.paddingL),

                  // 6. 비상금 체크 위젯
                  _buildSectionTitle('재정 안전망'),
                  const SizedBox(height: AppSizes.paddingS),
                  const EmergencyFundWidget(),
                  const SizedBox(height: AppSizes.paddingL),

                  // 7. 주유비 절약 저금통
                  _buildSectionTitle('스마트 저축'),
                  const SizedBox(height: AppSizes.paddingS),
                  const FuelSavingsWidget(),
                  const SizedBox(height: AppSizes.paddingL),

                  // 8. 자산 변동 추이 섹션
                  _buildSectionTitle('자산 변동 추이'),
                  const SizedBox(height: AppSizes.paddingS),
                  _buildComingSoonCard('차트가 곧 추가됩니다'),
                  const SizedBox(height: AppSizes.paddingL),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildPixelRemainingCard(int netAssets, int targetPrice) {
    final remaining = targetPrice - netAssets;
    final remainingText = _formatCompact(remaining);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4CAF50),
            Color(0xFF81C784),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 8),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                '🏃',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '남은 금액',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 15,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  remainingText,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Colors.white,
            size: 22,
          )
        ],
      ),
    );
  }

  Widget _buildRemainingCard(int netAssets, int targetPrice) {
    final remaining = targetPrice - netAssets;
    final remainingText = _formatCompact(remaining);

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: const Icon(
              Icons.flag_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSizes.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '목표까지 남은 금액',
                  style: TextStyle(
                    fontSize: AppSizes.fontS,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  remainingText,
                  style: const TextStyle(
                    fontSize: AppSizes.fontXL,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white54,
            size: 16,
          ),
        ],
      ),
    );
  }

  String _formatCompact(int amount) {
    if (amount >= 100000000) {
      double billions = amount / 100000000;
      return '${billions.toStringAsFixed(1)}억원';
    } else if (amount >= 10000) {
      return '${(amount / 10000).toStringAsFixed(0)}만원';
    }
    return '$amount원';
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppSizes.fontL,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: 상세 보기
          },
          child: const Text(
            '더보기',
            style: TextStyle(
              fontSize: AppSizes.fontS,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComingSoonCard(String message) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingXL),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.show_chart_rounded,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSizes.paddingS),
            Text(
              message,
              style: TextStyle(
                color: AppColors.textTertiary,
                fontSize: AppSizes.fontM,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingM,
            vertical: AppSizes.paddingS,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPixelNavItem(
                context,
                '🏠',
                AppStrings.navHome,
                true,
                onTap: () {},
              ),
              _buildPixelNavItem(
                context,
                '📊',
                AppStrings.navLedger,
                false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LedgerPage(),
                    ),
                  );
                },
              ),
              _buildPixelNavItem(
                context,
                '💰',
                AppStrings.navAssets,
                false,
                onTap: () {
                  // TODO: 자산 화면
                },
              ),
              _buildPixelNavItem(
                context,
                '🎯',
                AppStrings.navGoal,
                false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TargetMapPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPixelNavItem(
    BuildContext context,
    String emoji,
    String label,
    bool isSelected, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emoji,
              style: TextStyle(
                fontSize: 22,
                shadows: isSelected
                    ? [
                        Shadow(
                          color: AppColors.primary.withOpacity(0.4),
                          offset: const Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ]
                    : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: AppSizes.fontXS,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
