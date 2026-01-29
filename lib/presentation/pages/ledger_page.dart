import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_button_styles.dart';
import '../../core/utils/transaction_category_customizer.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';
import '../../data/services/homerun_insight_service.dart';
import '../providers/ledger_provider.dart';
import '../providers/fixed_expense_provider.dart';
import '../widgets/ledger/transaction_list_item.dart';
import '../widgets/ledger/amount_input_field.dart';
import '../widgets/ledger/category_selector.dart';
import '../widgets/ledger/payment_method_selector.dart';
import 'payment_method_page.dart';
import 'account_page.dart';
import 'fixed_expense_page.dart';

/// 가계부 메인 페이지
class LedgerPage extends ConsumerStatefulWidget {
  const LedgerPage({super.key});

  @override
  ConsumerState<LedgerPage> createState() => _LedgerPageState();
}

class _LedgerPageState extends ConsumerState<LedgerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _hasInitializedFixedExpenses = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 고정비 자동 등록 (한 번만 실행)
    if (!_hasInitializedFixedExpenses) {
      _hasInitializedFixedExpenses = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _registerFixedExpenses();
      });
    }
  }

  Future<void> _registerFixedExpenses() async {
    try {
      final service = ref.read(fixedExpenseServiceProvider);
      final result = await service.registerMonthlyFixedExpenses();
      
      if (mounted && result.autoRegisteredCount > 0) {
        // 거래 목록 새로고침
        ref.invalidate(transactionListProvider);
      }
    } catch (e) {
      // 에러는 조용히 무시 (초기화 실패가 앱 사용을 막지 않도록)
      debugPrint('고정비 자동 등록 실패: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddTransactionSheet(
    TransactionType type, {
    int? referenceIncomeAmount,
    bool isFromIncomeLinkage = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddTransactionSheet(
        type: type,
        referenceIncomeAmount: referenceIncomeAmount,
        isFromIncomeLinkage: isFromIncomeLinkage,
        onSaved: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  /// 통장 쪼개기 연계: 저축/이체 바텀시트 열기
  void _openSavingsSheetForSplitting(int incomeAmount) {
    _showAddTransactionSheet(
      TransactionType.transfer,
      referenceIncomeAmount: incomeAmount,
      isFromIncomeLinkage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ledgerBackground,
      appBar: AppBar(
        title: const Text(
          '가계부',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(AppIcons.repeat, size: 24),
            tooltip: '고정비 관리',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FixedExpensePage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(AppIcons.walletOutlined, size: 26),
            tooltip: '계좌/카드 관리',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountPage(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          tabs: [
            Tab(
              child: Text(
                '소득',
                style: TextStyle(
                  color: _tabController.index == 0
                      ? LedgerThemeColors.incomeMain
                      : AppColors.textTertiary,
                ),
              ),
            ),
            Tab(
              child: Text(
                '소비',
                style: TextStyle(
                  color: _tabController.index == 1
                      ? LedgerThemeColors.expenseMain
                      : AppColors.textTertiary,
                ),
              ),
            ),
            Tab(
              child: Text(
                '저축',
                style: TextStyle(
                  color: _tabController.index == 2
                      ? LedgerThemeColors.transferMain
                      : AppColors.textTertiary,
                ),
              ),
            ),
          ],
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 3,
              color: _tabController.index == 0
                  ? LedgerThemeColors.incomeMain
                  : _tabController.index == 1
                      ? LedgerThemeColors.expenseMain
                      : LedgerThemeColors.transferMain,
            ),
          ),
          onTap: (index) => setState(() {}),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TransactionListView(type: TransactionType.income),
          _TransactionListView(type: TransactionType.expense),
          _TransactionListView(type: TransactionType.transfer),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          TransactionType type;
          switch (_tabController.index) {
            case 0:
              type = TransactionType.income;
              break;
            case 1:
              type = TransactionType.expense;
              break;
            default:
              type = TransactionType.transfer;
          }
          _showAddTransactionSheet(type);
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(AppIcons.add, size: 22),
        label: const Text(
          '내역 추가',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 거래 목록 뷰
class _TransactionListView extends ConsumerWidget {
  final TransactionType type;

  const _TransactionListView({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(filteredTransactionsByTypeProvider(type));
    final paymentMethodsAsync = ref.watch(paymentMethodListProvider);
    final usageAsync = ref.watch(paymentMethodMonthlyUsageProvider);
    final selectedFilterId = ref.watch(paymentMethodFilterProvider);
    final selectedYearMonth = ref.watch(selectedYearMonthNotifierProvider);
    final numberFormat = NumberFormat('#,###');

    return transactionsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('오류: $error')),
      data: (transactions) {
        // 선택된 연월의 거래 (이미 Provider에서 필터링됨)
        final totalAmount = transactions.fold<int>(
            0, (sum, t) => sum + t.amount);

        return paymentMethodsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('오류: $error')),
          data: (paymentMethods) {
            final methodMap = {for (var m in paymentMethods) m.id: m};
            final usageMap = usageAsync.valueOrNull ?? {};

            return CustomScrollView(
              slivers: [
                // 연월 선택 UI
                SliverToBoxAdapter(
                  child: _MonthSelector(
                    selectedYearMonth: selectedYearMonth,
                    onPrevious: () {
                      ref.read(selectedYearMonthNotifierProvider.notifier).previousMonth();
                    },
                    onNext: () {
                      ref.read(selectedYearMonthNotifierProvider.notifier).nextMonth();
                    },
                    onSelectMonth: () => _showMonthPicker(context, ref, selectedYearMonth),
                  ),
                ),

                // 상단 요약 카드
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: _buildSummaryCard(
                      type,
                      totalAmount,
                      transactions,
                      numberFormat,
                    ),
                  ),
                ),

                // 고정비 설정 버튼 (지출 탭에서만, 항상 표시)
                if (type == TransactionType.expense)
                  SliverToBoxAdapter(
                    child: _FixedExpenseSettingsButton(),
                  ),

                // 결제 수단 필터 칩 (지출 탭에서만)
                if (type == TransactionType.expense && paymentMethods.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _PaymentMethodFilterChips(
                      paymentMethods: paymentMethods,
                      selectedId: selectedFilterId,
                      usageMap: usageMap,
                      numberFormat: numberFormat,
                      onSelected: (id) {
                        ref.read(paymentMethodFilterProvider.notifier).setFilter(id);
                      },
                      onClear: () {
                        ref.read(paymentMethodFilterProvider.notifier).clearFilter();
                      },
                    ),
                  ),

                // 거래 목록 헤더
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          '${selectedYearMonth.month}월 내역',
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.textTertiary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${transactions.length}건',
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 4)),

                // 거래 목록 (날짜별 그룹화)
                if (transactions.isEmpty)
                  SliverFillRemaining(
                    child: _EmptyState(type: type),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final transaction = transactions[index];
                        final paymentMethod = transaction.withdrawAccountId != null
                            ? methodMap[transaction.withdrawAccountId]
                            : transaction.depositAccountId != null
                                ? methodMap[transaction.depositAccountId]
                                : null;

                        // 날짜 구분선 표시 여부 확인
                        final showDateDivider = index == 0 ||
                            !_isSameDay(
                              transactions[index - 1].date,
                              transaction.date,
                            );

                        // 이동 탭인 경우 출금/입금 계좌 정보 추출
                        final depositAccount = transaction.depositAccountId != null
                            ? methodMap[transaction.depositAccountId]
                            : null;
                        final withdrawAccount = transaction.withdrawAccountId != null
                            ? methodMap[transaction.withdrawAccountId]
                            : null;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (showDateDivider)
                              DateDivider(
                                date: transaction.date,
                                themeColor: LedgerThemeColors.getMainColor(type),
                              ),
                            TransactionListItem(
                              transaction: transaction,
                              paymentMethod: paymentMethod,
                              depositAccount: depositAccount,
                              withdrawAccount: withdrawAccount,
                              onDelete: () {
                                ref.read(transactionNotifierProvider.notifier)
                                    .deleteTransaction(transaction.id);
                              },
                            ),
                          ],
                        );
                      },
                      childCount: transactions.length,
                    ),
                  ),

                // 하단 여백
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            );
          },
        );
      },
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Widget _buildSummaryCard(
    TransactionType type,
    int totalAmount,
    List<TransactionModel> transactions,
    NumberFormat numberFormat,
  ) {
    switch (type) {
      case TransactionType.income:
        return _IncomeSummaryCard(
          totalAmount: totalAmount,
          transactions: transactions,
          numberFormat: numberFormat,
        );
      case TransactionType.expense:
        return _ExpenseSummaryCard(
          totalAmount: totalAmount,
          transactions: transactions,
          numberFormat: numberFormat,
        );
      case TransactionType.transfer:
        return _TransferSummaryCard(
          totalAmount: totalAmount,
          transactions: transactions,
          numberFormat: numberFormat,
        );
    }
  }
}

/// 수입 요약 카드
class _IncomeSummaryCard extends StatelessWidget {
  final int totalAmount;
  final List<TransactionModel> transactions;
  final NumberFormat numberFormat;

  const _IncomeSummaryCard({
    required this.totalAmount,
    required this.transactions,
    required this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    // 급여와 기타 수입 분리
    final salaryAmount = transactions
        .where((t) => t.category == TransactionCategory.salary)
        .fold<int>(0, (sum, t) => sum + t.amount);
    final bonusAmount = transactions
        .where((t) => t.category == TransactionCategory.bonus)
        .fold<int>(0, (sum, t) => sum + t.amount);
    final otherAmount = totalAmount - salaryAmount - bonusAmount;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            LedgerThemeColors.incomeMain,
            LedgerThemeColors.incomeMain.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: LedgerThemeColors.incomeMain.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  AppIcons.income,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '이번 달 총 수입',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${numberFormat.format(totalAmount)}원',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          // 수입 내역 분리
          Row(
            children: [
              if (salaryAmount > 0)
                _IncomeTag(label: '급여', amount: salaryAmount, numberFormat: numberFormat),
              if (bonusAmount > 0) ...[
                const SizedBox(width: 8),
                _IncomeTag(label: '성과급', amount: bonusAmount, numberFormat: numberFormat),
              ],
              if (otherAmount > 0) ...[
                const SizedBox(width: 8),
                _IncomeTag(label: '기타', amount: otherAmount, numberFormat: numberFormat),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _IncomeTag extends StatelessWidget {
  final String label;
  final int amount;
  final NumberFormat numberFormat;

  const _IncomeTag({
    required this.label,
    required this.amount,
    required this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '${numberFormat.format(amount)}원',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// 지출 요약 카드
class _ExpenseSummaryCard extends StatelessWidget {
  final int totalAmount;
  final List<TransactionModel> transactions;
  final NumberFormat numberFormat;

  const _ExpenseSummaryCard({
    required this.totalAmount,
    required this.transactions,
    required this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    // 예산 (임시로 300만원 설정 - 추후 설정 기능 추가)
    const int budget = 3000000;
    final double usagePercent = budget > 0 ? (totalAmount / budget * 100).clamp(0, 100) : 0;
    final remaining = budget - totalAmount;

    // 카테고리별 상위 3개
    final categoryTotals = <TransactionCategory, int>{};
    for (final t in transactions) {
      categoryTotals[t.category] = (categoryTotals[t.category] ?? 0) + t.amount;
    }
    final sortedCategories = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topCategories = sortedCategories.take(3).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.ledgerSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '이번 달 지출',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${numberFormat.format(totalAmount)}원',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: LedgerThemeColors.expenseMain,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: remaining >= 0
                      ? LedgerThemeColors.transferMain.withOpacity(0.1)
                      : LedgerThemeColors.expenseMain.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  remaining >= 0
                      ? '${numberFormat.format(remaining)}원 남음'
                      : '${numberFormat.format(-remaining)}원 초과',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: remaining >= 0
                        ? LedgerThemeColors.transferMain
                        : LedgerThemeColors.expenseMain,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 예산 게이지 바
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '예산 ${numberFormat.format(budget)}원',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  Text(
                    '${usagePercent.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: usagePercent > 80
                          ? LedgerThemeColors.expenseMain
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: usagePercent / 100,
                  minHeight: 10,
                  backgroundColor: AppColors.ledgerSurfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    usagePercent > 80
                        ? LedgerThemeColors.expenseMain
                        : usagePercent > 50
                            ? AppColors.warning
                            : LedgerThemeColors.transferMain,
                  ),
                ),
              ),
            ],
          ),
          if (topCategories.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            // 상위 카테고리
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: topCategories.map((entry) {
                return _CategoryBadge(
                  category: entry.key,
                  amount: entry.value,
                  numberFormat: numberFormat,
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final TransactionCategory category;
  final int amount;
  final NumberFormat numberFormat;

  const _CategoryBadge({
    required this.category,
    required this.amount,
    required this.numberFormat,
  });

  IconData get _icon {
    switch (category) {
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
      default:
        return AppIcons.more;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: LedgerThemeColors.expenseLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _icon,
            size: 14,
            color: LedgerThemeColors.expenseMain,
          ),
          const SizedBox(width: 6),
          Text(
            category.displayName,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '${numberFormat.format(amount)}원',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// 저축 요약 카드
class _TransferSummaryCard extends StatelessWidget {
  final int totalAmount;
  final List<TransactionModel> transactions;
  final NumberFormat numberFormat;

  const _TransferSummaryCard({
    required this.totalAmount,
    required this.transactions,
    required this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    // 카테고리별 합계 계산
    final categoryTotals = <TransactionCategory, int>{};
    for (final t in transactions) {
      categoryTotals[t.category] = (categoryTotals[t.category] ?? 0) + t.amount;
    }
    final sortedCategories = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topCategories = sortedCategories.take(3).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            LedgerThemeColors.transferMain,
            LedgerThemeColors.transferMain.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: LedgerThemeColors.transferMain.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  AppIcons.savings,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '이번 달 저축',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${numberFormat.format(totalAmount)}원',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          // 카테고리별 내역 표시
          if (topCategories.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: topCategories.map((entry) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entry.key.displayName,
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${numberFormat.format(entry.value)}원',
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 16),
          // 응원 메시지
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  AppIcons.home,
                  color: Colors.white,
                  size: 26,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    totalAmount > 0
                        ? '이번 달 내 집 마련을 위해\n${numberFormat.format(totalAmount)}원을 모았어요!'
                        : '저축을 시작하고\n내 집 마련에 한 발짝 다가가세요!',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 빈 상태 위젯
class _EmptyState extends StatelessWidget {
  final TransactionType type;

  const _EmptyState({required this.type});

  String get _message {
    switch (type) {
      case TransactionType.income:
        return '소득 내역이 없습니다';
      case TransactionType.expense:
        return '지출 내역이 없습니다';
      case TransactionType.transfer:
        return '저축 내역이 없습니다';
    }
  }

  IconData get _icon {
    switch (type) {
      case TransactionType.income:
        return AppIcons.income;
      case TransactionType.expense:
        return AppIcons.expense;
      case TransactionType.transfer:
        return AppIcons.transfer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _icon,
            size: 72,
            color: AppColors.gray300,
          ),
          const SizedBox(height: 16),
          Text(
            _message,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '+ 버튼을 눌러 추가하세요',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

/// 거래 추가 바텀시트
class _AddTransactionSheet extends ConsumerStatefulWidget {
  final TransactionType type;
  final VoidCallback onSaved;

  /// 통장 쪼개기 연계용: 참조할 소득 금액 (이체 가능 금액으로 표시)
  final int? referenceIncomeAmount;

  /// 통장 쪼개기 연계로 열렸는지 여부 (소득 추가 후 바로 연계된 경우)
  final bool isFromIncomeLinkage;

  /// 변동 고정비 내역 불러오기용 prefill
  final String? prefillDescription;
  final TransactionCategory? prefillCategory;
  final int prefillAmount;
  final int? prefillPaymentMethodId;
  final DateTime? prefillDate;

  const _AddTransactionSheet({
    required this.type,
    required this.onSaved,
    this.referenceIncomeAmount,
    this.isFromIncomeLinkage = false,
    this.prefillDescription,
    this.prefillCategory,
    this.prefillAmount = 0,
    this.prefillPaymentMethodId,
    this.prefillDate,
  });

  @override
  ConsumerState<_AddTransactionSheet> createState() =>
      _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<_AddTransactionSheet> {
  late TransactionType _selectedType;
  TransactionCategory? _selectedCategory;
  String? _selectedCustomCategoryId;
  int _amount = 0;
  int? _selectedPaymentMethodId;
  late TextEditingController _descriptionController;
  DateTime _selectedDate = DateTime.now();
  bool _isRecurring = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.type;
    _descriptionController = TextEditingController(
      text: widget.prefillDescription ?? '',
    );
    if (widget.prefillCategory != null) _selectedCategory = widget.prefillCategory;
    if (widget.prefillAmount > 0) _amount = widget.prefillAmount;
    if (widget.prefillPaymentMethodId != null) {
      _selectedPaymentMethodId = widget.prefillPaymentMethodId;
    }
    if (widget.prefillDate != null) _selectedDate = widget.prefillDate!;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Color get _accentColor {
    switch (_selectedType) {
      case TransactionType.income:
        return LedgerThemeColors.incomeMain;
      case TransactionType.expense:
        return LedgerThemeColors.expenseMain;
      case TransactionType.transfer:
        return LedgerThemeColors.transferMain;
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: const Locale('ko', 'KR'),
      helpText: '날짜를 선택해주세요',
      cancelText: '취소',
      confirmText: '확인',
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _save() async {
    // 바텀시트 내부에 직접 에러 메시지 표시
    setState(() {
      _errorMessage = null;
    });
    
    if (_amount <= 0) {
      setState(() {
        _errorMessage = '금액을 입력해주세요';
      });
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _errorMessage = null;
          });
        }
      });
      return;
    }

    if (_selectedCategory == null) {
      setState(() {
        _errorMessage = '카테고리를 선택해주세요';
      });
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _errorMessage = null;
          });
        }
      });
      return;
    }

    if (_selectedPaymentMethodId == null) {
      setState(() {
        _errorMessage = '결제 수단을 선택해주세요';
      });
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _errorMessage = null;
          });
        }
      });
      return;
    }

    final transaction = TransactionModel()
      ..date = _selectedDate
      ..type = _selectedType
      ..category = _selectedCategory ?? TransactionCategory.otherExpense
      ..customCategoryId = _selectedCustomCategoryId
      ..description = _descriptionController.text.trim()
      ..amount = _amount
      ..isRecurring = _isRecurring
      ..recurringDay = _isRecurring ? _selectedDate.day : null;

    if (_selectedType == TransactionType.income) {
      transaction.depositAccountId = _selectedPaymentMethodId;
    } else {
      transaction.withdrawAccountId = _selectedPaymentMethodId;
    }

    // 소득 추가 시 통장 쪼개기 연계용 이벤트 발행 (직접 연계가 아닌 경우에만)
    final shouldEmitIncomeEvent =
        _selectedType == TransactionType.income && !widget.isFromIncomeLinkage;

    await ref.read(transactionNotifierProvider.notifier).addTransaction(
          transaction,
          emitIncomeEvent: shouldEmitIncomeEvent,
        );

    // 홈런 인사이트 표시
    HomeRunInsight? insight;
    if (_selectedType == TransactionType.expense) {
      insight = HomeRunInsightService.getExpenseInsight(_amount);
    } else if (_selectedType == TransactionType.income) {
      insight = HomeRunInsightService.getIncomeInsight(_amount);
    } else if (_selectedType == TransactionType.transfer) {
      insight = HomeRunInsightService.getSavingInsight(_amount);
    }

    // 소득 추가 시 통장 쪼개기 유도 SnackBar 표시
    if (_selectedType == TransactionType.income && context.mounted) {
      final savedAmount = _amount;
      widget.onSaved();

      // 바텀시트가 닫힌 후 SnackBar 표시
      Future.delayed(const Duration(milliseconds: 300), () {
        if (context.mounted) {
          _showAccountSplittingSnackBar(context, savedAmount);
        }
      });
      return;
    }

    if (insight != null && context.mounted) {
      _showInsightDialog(context, insight);
    } else if (_isRecurring && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('매월 ${_selectedDate.day}일에 자동으로 추가됩니다'),
          backgroundColor: LedgerThemeColors.incomeMain,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
        ),
      );
    }

    widget.onSaved();
  }

  /// 통장 쪼개기 유도 SnackBar 표시
  void _showAccountSplittingSnackBar(BuildContext context, int incomeAmount) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '🎉',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '소득이 입력되었어요!',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '바로 \'통장 쪼개기\' 이체를 기록할까요?',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: LedgerThemeColors.incomeMain,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
          label: '이체하기',
          textColor: Colors.white,
          onPressed: () {
            // LedgerPage의 context를 통해 저축 바텀시트 열기
            final ledgerState = context.findAncestorStateOfType<_LedgerPageState>();
            ledgerState?._openSavingsSheetForSplitting(incomeAmount);
          },
        ),
      ),
    );
  }

  void _showInsightDialog(BuildContext context, HomeRunInsight insight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              insight.type == InsightType.positive
                  ? AppIcons.celebration
                  : insight.type == InsightType.warning
                      ? AppIcons.warningAmber
                      : AppIcons.lightbulbOutlined,
              size: 52,
              color: insight.type == InsightType.positive
                  ? AppColors.primary
                  : insight.type == InsightType.warning
                      ? AppColors.error
                      : AppColors.warning,
            ),
            const SizedBox(height: 16),
            Text(
              '홈런 인사이트',
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              insight.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showEditTransactionCategorySheet(BuildContext context, TransactionCategory category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditTransactionCategorySheet(
        category: category,
        onSaved: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showTransactionCategoryManageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TransactionCategoryManageSheet(
        transactionType: _selectedType,
      ),
    );
  }

  void _showEditCustomTransactionCategorySheet(BuildContext context, String customCategoryId) async {
    final customCategory = await ref.read(customTransactionCategoryLocalDataSourceProvider)
        .getByUid(customCategoryId);
    if (customCategory == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditCustomTransactionCategorySheet(
        category: customCategory,
        onSaved: () {
          ref.invalidate(customTransactionCategoryNotifierProvider);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethodsAsync = ref.watch(paymentMethodNotifierProvider);
    final dateFormat = DateFormat('yyyy년 M월 d일');

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
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
                      Text(
                        '내역 추가',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(AppIcons.close, size: 24),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                // 폼
                Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 타입 선택
                  Row(
                    children: [
                      _TypeChip(
                        label: '소득',
                        isSelected: _selectedType == TransactionType.income,
                        color: LedgerThemeColors.incomeMain,
                        onTap: () => setState(() {
                          _selectedType = TransactionType.income;
                          _selectedCategory = null;
                          _isRecurring = false;
                        }),
                      ),
                      const SizedBox(width: 8),
                      _TypeChip(
                        label: '소비',
                        isSelected: _selectedType == TransactionType.expense,
                        color: LedgerThemeColors.expenseMain,
                        onTap: () => setState(() {
                          _selectedType = TransactionType.expense;
                          _selectedCategory = null;
                          _isRecurring = false;
                        }),
                      ),
                      const SizedBox(width: 8),
                      _TypeChip(
                        label: '저축',
                        isSelected: _selectedType == TransactionType.transfer,
                        color: LedgerThemeColors.transferMain,
                        onTap: () => setState(() {
                          _selectedType = TransactionType.transfer;
                          _selectedCategory = null;
                          _isRecurring = false;
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 통장 쪼개기 연계 배너 (소득 연계로 열린 경우)
                  if (widget.isFromIncomeLinkage &&
                      widget.referenceIncomeAmount != null) ...[
                    _AccountSplittingBanner(
                      referenceAmount: widget.referenceIncomeAmount!,
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 금액 입력
                  AmountInputField(
                    label: '금액',
                    accentColor: _accentColor,
                    initialValue: widget.prefillAmount > 0 ? widget.prefillAmount : null,
                    onChanged: (value) => _amount = value,
                  ),
                  const SizedBox(height: 24),

                  // 날짜 선택
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            AppIcons.calendar,
                            size: 22,
                            color: AppColors.gray600,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            dateFormat.format(_selectedDate),
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            AppIcons.chevronRight,
                            color: AppColors.gray400,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 카테고리 선택
                  CategorySelector(
                    transactionType: _selectedType,
                    selectedCategory: _selectedCategory,
                    selectedCustomCategoryId: _selectedCustomCategoryId,
                    onSelected: (category) {
                      setState(() {
                        _selectedCategory = category;
                        _selectedCustomCategoryId = null;
                      });
                    },
                    onCustomCategorySelected: (customCategoryId) {
                      setState(() {
                        _selectedCustomCategoryId = customCategoryId;
                        _selectedCategory = null;
                      });
                    },
                    onLongPress: (category) {
                      _showEditTransactionCategorySheet(context, category);
                    },
                    onCustomCategoryLongPress: (customCategoryId) {
                      _showEditCustomTransactionCategorySheet(context, customCategoryId);
                    },
                    onManage: () {
                      _showTransactionCategoryManageSheet(context);
                    },
                  ),
                  const SizedBox(height: 24),

                  // 결제 수단 선택
                  paymentMethodsAsync.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Text('오류: $error'),
                    data: (paymentMethods) {
                      // 소득/저축 탭에서는 은행 계좌만 표시
                      final filteredMethods = (_selectedType == TransactionType.income ||
                              _selectedType == TransactionType.transfer)
                          ? paymentMethods.where((m) => m.type == PaymentMethodType.bankAccount).toList()
                          : paymentMethods;

                      if (filteredMethods.isEmpty) {
                        return _NoPaymentMethodWidget(
                          message: (_selectedType == TransactionType.income ||
                                  _selectedType == TransactionType.transfer)
                              ? '등록된 은행 계좌가 없습니다'
                              : '등록된 결제 수단이 없습니다',
                          onAdd: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentMethodPage(),
                              ),
                            );
                          },
                        );
                      }
                      return PaymentMethodSelector(
                        paymentMethods: filteredMethods,
                        selectedId: _selectedPaymentMethodId,
                        label: _selectedType == TransactionType.income
                            ? '입금 계좌'
                            : _selectedType == TransactionType.transfer
                                ? '출금 계좌'
                                : '결제 수단',
                        onSelected: (method) {
                          setState(() {
                            _selectedPaymentMethodId = method.id;
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // 월급 반복 설정 (급여 카테고리일 때만)
                  if (_selectedCategory == TransactionCategory.salary) ...[
                    _RecurringToggle(
                      isRecurring: _isRecurring,
                      recurringDay: _selectedDate.day,
                      onChanged: (value) {
                        setState(() {
                          _isRecurring = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                  ],

                  // 메모 입력
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: '메모 (선택)',
                      labelStyle: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 저장 버튼 (그라데이션 스타일)
                  GradientButton(
                    text: '저장',
                    onPressed: _save,
                    height: 54,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        _accentColor.withOpacity(0.9),
                        _accentColor,
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
                ),
              ],
            ),
          ),
          // 에러 메시지 오버레이
          if (_errorMessage != null)
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                color: Colors.black87,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 통장 쪼개기 연계 배너 위젯
class _AccountSplittingBanner extends StatelessWidget {
  final int referenceAmount;

  const _AccountSplittingBanner({
    required this.referenceAmount,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            LedgerThemeColors.transferLight,
            LedgerThemeColors.transferLight.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: LedgerThemeColors.transferMain.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: LedgerThemeColors.transferMain.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  AppIcons.accountBalance,
                  size: 20,
                  color: LedgerThemeColors.transferMain,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '통장 쪼개기',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: LedgerThemeColors.transferDark,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '소득을 용도별 계좌로 나눠 관리하세요',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: LedgerThemeColors.transferMain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '이체 가능 금액',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '${numberFormat.format(referenceAmount)}원',
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: LedgerThemeColors.transferMain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 타입 선택 칩
class _TypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TypeChip({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// 결제 수단 없음 안내 위젯
class _NoPaymentMethodWidget extends StatelessWidget {
  final VoidCallback onAdd;
  final String message;

  const _NoPaymentMethodWidget({
    required this.onAdd,
    this.message = '등록된 결제 수단이 없습니다',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.warning.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            AppIcons.walletOutlined,
            size: 44,
            color: AppColors.warning,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '먼저 계좌/카드를 추가해주세요',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12,
              color: AppColors.gray500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(AppIcons.add, size: 20),
            label: const Text('계좌/카드 추가'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 반복 설정 토글 위젯
class _RecurringToggle extends StatelessWidget {
  final bool isRecurring;
  final int recurringDay;
  final ValueChanged<bool> onChanged;

  const _RecurringToggle({
    required this.isRecurring,
    required this.recurringDay,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRecurring
            ? AppColors.primary.withOpacity(0.08)
            : AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
        border: isRecurring
            ? Border.all(color: AppColors.primary.withOpacity(0.3))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                AppIcons.repeat,
                size: 22,
                color: isRecurring ? AppColors.primary : AppColors.gray500,
              ),
              const SizedBox(width: 8),
              const Text(
                '매월 반복',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Switch(
                value: isRecurring,
                onChanged: onChanged,
                activeColor: AppColors.primary,
              ),
            ],
          ),
          if (isRecurring) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    AppIcons.infoOutlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '매월 $recurringDay일에 자동으로 추가됩니다',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 고정비 설정 버튼 (소비 탭에서 항상 표시)
class _FixedExpenseSettingsButton extends StatelessWidget {
  const _FixedExpenseSettingsButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FixedExpensePage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.ledgerSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: LedgerThemeColors.expenseMain.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: LedgerThemeColors.expenseLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  AppIcons.repeat,
                  size: 20,
                  color: LedgerThemeColors.expenseMain,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '고정비 설정',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '매월 반복 지출 등록·관리',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                AppIcons.chevronRight,
                color: AppColors.gray400,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 결제 수단 필터 칩 위젯
class _PaymentMethodFilterChips extends StatelessWidget {
  final List<PaymentMethodModel> paymentMethods;
  final int? selectedId;
  final Map<int, int> usageMap;
  final NumberFormat numberFormat;
  final ValueChanged<int?> onSelected;
  final VoidCallback onClear;

  const _PaymentMethodFilterChips({
    required this.paymentMethods,
    required this.selectedId,
    required this.usageMap,
    required this.numberFormat,
    required this.onSelected,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: paymentMethods.length + 1, // +1 for "전체" chip
        itemBuilder: (context, index) {
          if (index == 0) {
            // 전체 보기 칩
            final isSelected = selectedId == null;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: const Text('전체'),
                selected: isSelected,
                onSelected: (_) => onClear(),
                backgroundColor: AppColors.ledgerSurfaceVariant,
                selectedColor: LedgerThemeColors.expenseLight,
                checkmarkColor: LedgerThemeColors.expenseMain,
                labelStyle: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? LedgerThemeColors.expenseMain : AppColors.textSecondary,
                ),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }

          final method = paymentMethods[index - 1];
          final isSelected = selectedId == method.id;
          final usage = usageMap[method.id] ?? 0;
          final brandColor = Color(PaymentMethodColors.getBrandColor(method.name));

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(method.name),
                  if (usage > 0) ...[
                    const SizedBox(width: 6),
                    Text(
                      _formatCompact(usage),
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? brandColor : AppColors.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
              selected: isSelected,
              onSelected: (_) => onSelected(isSelected ? null : method.id),
              backgroundColor: AppColors.ledgerSurfaceVariant,
              selectedColor: brandColor.withOpacity(0.15),
              checkmarkColor: brandColor,
              labelStyle: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? brandColor : AppColors.textSecondary,
              ),
              side: isSelected
                  ? BorderSide(color: brandColor.withOpacity(0.5), width: 1)
                  : BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatCompact(int amount) {
    if (amount >= 10000) {
      return '${(amount / 10000).toStringAsFixed(0)}만';
    }
    return numberFormat.format(amount);
  }
}

/// 홈런 인사이트 위젯
class _HomeRunInsightBanner extends StatelessWidget {
  final HomeRunInsight insight;

  const _HomeRunInsightBanner({required this.insight});

  Color get _backgroundColor {
    switch (insight.type) {
      case InsightType.positive:
        return LedgerThemeColors.transferLight;
      case InsightType.neutral:
        return AppColors.textTertiary.withOpacity(0.1);
      case InsightType.caution:
        return AppColors.warning.withOpacity(0.1);
      case InsightType.warning:
        return LedgerThemeColors.expenseLight;
    }
  }

  Color get _borderColor {
    switch (insight.type) {
      case InsightType.positive:
        return LedgerThemeColors.transferMain;
      case InsightType.neutral:
        return AppColors.textTertiary;
      case InsightType.caution:
        return AppColors.warning;
      case InsightType.warning:
        return LedgerThemeColors.expenseMain;
    }
  }

  IconData get _icon {
    switch (insight.type) {
      case InsightType.positive:
        return AppIcons.rocket;
      case InsightType.neutral:
        return AppIcons.infoOutlined;
      case InsightType.caution:
        return AppIcons.warningAmber;
      case InsightType.warning:
        return AppIcons.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(_icon, color: _borderColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              insight.message,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _borderColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================
// 월 선택 UI
// ============================================

/// 연월 선택 위젯
class _MonthSelector extends StatelessWidget {
  final SelectedYearMonth selectedYearMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSelectMonth;

  const _MonthSelector({
    required this.selectedYearMonth,
    required this.onPrevious,
    required this.onNext,
    required this.onSelectMonth,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCurrentMonth = selectedYearMonth.isCurrentMonth;
    final canGoNext = !SelectedYearMonth(
      year: selectedYearMonth.year,
      month: selectedYearMonth.month,
    ).nextMonth.isFutureMonth;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 이전 달 버튼
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.chevron_left_rounded),
            iconSize: 28,
            color: AppColors.textSecondary,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
          
          // 연월 표시 (탭하면 월 선택 다이얼로그)
          InkWell(
            onTap: onSelectMonth,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isCurrentMonth 
                    ? AppColors.primary.withOpacity(0.1) 
                    : AppColors.gray100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${selectedYearMonth.year}년 ${selectedYearMonth.month}월',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isCurrentMonth 
                          ? AppColors.primary 
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: isCurrentMonth 
                        ? AppColors.primary 
                        : AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          
          // 다음 달 버튼
          IconButton(
            onPressed: canGoNext ? onNext : null,
            icon: const Icon(Icons.chevron_right_rounded),
            iconSize: 28,
            color: canGoNext ? AppColors.textSecondary : AppColors.gray300,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ],
      ),
    );
  }
}

/// 월 선택 다이얼로그 표시
void _showMonthPicker(
  BuildContext context,
  WidgetRef ref,
  SelectedYearMonth current,
) {
  final now = DateTime.now();
  
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _MonthPickerSheet(
      currentYear: current.year,
      currentMonth: current.month,
      maxYear: now.year,
      maxMonth: now.month,
      onSelected: (year, month) {
        ref.read(selectedYearMonthNotifierProvider.notifier).setYearMonth(year, month);
        Navigator.pop(context);
      },
    ),
  );
}

/// 월 선택 바텀 시트
class _MonthPickerSheet extends StatefulWidget {
  final int currentYear;
  final int currentMonth;
  final int maxYear;
  final int maxMonth;
  final void Function(int year, int month) onSelected;

  const _MonthPickerSheet({
    required this.currentYear,
    required this.currentMonth,
    required this.maxYear,
    required this.maxMonth,
    required this.onSelected,
  });

  @override
  State<_MonthPickerSheet> createState() => _MonthPickerSheetState();
}

class _MonthPickerSheetState extends State<_MonthPickerSheet> {
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.currentYear;
  }

  bool _isMonthSelectable(int month) {
    if (_selectedYear < widget.maxYear) return true;
    if (_selectedYear == widget.maxYear && month <= widget.maxMonth) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 드래그 핸들
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.gray300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // 헤더
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '월 선택',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          
          // 연도 선택
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedYear--;
                    });
                  },
                  icon: const Icon(Icons.chevron_left_rounded),
                  color: AppColors.textSecondary,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$_selectedYear년',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _selectedYear < widget.maxYear
                      ? () {
                          setState(() {
                            _selectedYear++;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.chevron_right_rounded),
                  color: _selectedYear < widget.maxYear
                      ? AppColors.textSecondary
                      : AppColors.gray300,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // 월 그리드
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final month = index + 1;
                final isSelected = _selectedYear == widget.currentYear && 
                                   month == widget.currentMonth;
                final isSelectable = _isMonthSelectable(month);
                
                return InkWell(
                  onTap: isSelectable
                      ? () => widget.onSelected(_selectedYear, month)
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : isSelectable
                              ? AppColors.gray100
                              : AppColors.gray50,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: isSelectable
                                  ? AppColors.gray200
                                  : AppColors.gray100,
                            ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$month월',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : isSelectable
                                ? AppColors.textPrimary
                                : AppColors.gray300,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 24),
          
          // 이번 달로 이동 버튼
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  widget.onSelected(widget.maxYear, widget.maxMonth);
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  '이번 달로 이동',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          
          // 안전 영역
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

// ============================================
// 거래 카테고리 수정 시트
// ============================================

/// 거래 카테고리 수정 시트
class _EditTransactionCategorySheet extends ConsumerStatefulWidget {
  final TransactionCategory category;
  final VoidCallback onSaved;

  const _EditTransactionCategorySheet({
    required this.category,
    required this.onSaved,
  });

  @override
  ConsumerState<_EditTransactionCategorySheet> createState() => _EditTransactionCategorySheetState();
}

class _EditTransactionCategorySheetState extends ConsumerState<_EditTransactionCategorySheet> {
  late TextEditingController _nameController;
  late int _selectedColorIndex;
  TransactionCategoryCustomization? _currentCustomization;

  // 선택 가능한 색상 팔레트
  static const List<int> _colorPalette = [
    0xFF4CAF50, // 녹색
    0xFF2196F3, // 파랑
    0xFFFF9800, // 주황
    0xFFE91E63, // 분홍
    0xFF9C27B0, // 보라
    0xFF00BCD4, // 청록
    0xFFFF5722, // 깊은 주황
    0xFF795548, // 갈색
    0xFF607D8B, // 회색
    0xFFCDDC39, // 라임
  ];

  @override
  void initState() {
    super.initState();
    _loadCustomization();
  }

  Future<void> _loadCustomization() async {
    final customization = await TransactionCategoryCustomizer.getCustomization(widget.category);
    final defaultName = widget.category.displayName;
    final defaultColor = await TransactionCategoryCustomizer.getCategoryColor(widget.category);
    
    setState(() {
      _currentCustomization = customization;
      _nameController = TextEditingController(
        text: customization?.name ?? defaultName,
      );
      _selectedColorIndex = _colorPalette.indexOf(
        customization?.colorValue ?? defaultColor,
      );
      if (_selectedColorIndex == -1) _selectedColorIndex = 0;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String? _errorMessage;

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _errorMessage = '카테고리 이름을 입력해주세요';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    await TransactionCategoryCustomizer.setCustomization(
      widget.category,
      name,
      _colorPalette[_selectedColorIndex],
    );
    
    widget.onSaved();
  }

  Future<void> _resetToDefault() async {
    await TransactionCategoryCustomizer.removeCustomization(widget.category);
    widget.onSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 핸들
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.gray300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // 헤더
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '카테고리 수정',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded),
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // 이름 입력
                  const Text(
                    '카테고리 이름',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: '카테고리 이름',
                      filled: true,
                      fillColor: AppColors.gray100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // 색상 선택
                  const Text(
                    '색상',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(_colorPalette.length, (index) {
                      final isSelected = _selectedColorIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColorIndex = index),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(_colorPalette[index]),
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: AppColors.textPrimary, width: 3)
                                : null,
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, color: Colors.white, size: 24)
                              : null,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  
                  // 기본값으로 복원 버튼 (커스터마이징이 있을 때만)
                  if (_currentCustomization != null)
                    TextButton(
                      onPressed: _resetToDefault,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                      ),
                      child: const Text('기본값으로 복원'),
                    ),
                  const SizedBox(height: 8),
                  
                  // 저장 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
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
                ],
              ),
            ),
          ),
        ),
        // 에러 메시지 (스낵바) - 바텀시트 위에 표시
        if (_errorMessage != null)
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              color: AppColors.gray900,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 20),
                      onPressed: () {
                        setState(() {
                          _errorMessage = null;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================
// 거래 카테고리 관리 시트
// ============================================

/// 거래 카테고리 관리 시트
class _TransactionCategoryManageSheet extends ConsumerStatefulWidget {
  final TransactionType transactionType;

  const _TransactionCategoryManageSheet({
    required this.transactionType,
  });

  @override
  ConsumerState<_TransactionCategoryManageSheet> createState() => _TransactionCategoryManageSheetState();
}

class _TransactionCategoryManageSheetState extends ConsumerState<_TransactionCategoryManageSheet> {
  final _nameController = TextEditingController();
  int _selectedColorIndex = 0;
  String _selectedEmoji = '📁';
  String? _errorMessage;

  // 선택 가능한 색상 팔레트
  static const List<int> _colorPalette = [
    0xFF4CAF50, // 녹색
    0xFF2196F3, // 파랑
    0xFFFF9800, // 주황
    0xFFE91E63, // 분홍
    0xFF9C27B0, // 보라
    0xFF00BCD4, // 청록
    0xFFFF5722, // 깊은 주황
    0xFF795548, // 갈색
    0xFF607D8B, // 회색
    0xFFCDDC39, // 라임
  ];

  // 선택 가능한 이모지 리스트
  static const List<String> _emojiList = [
    '💼', '💰', '💵', '💳', '💸', '💴', '💶', '💷',
    '📊', '📈', '📉', '📁', '📂', '📋', '📝', '📌',
    '🏠', '🏡', '🏢', '🏬', '🏪', '🏫', '🏭', '🏨',
    '🚗', '🚕', '🚙', '🚌', '🚎', '🏎️', '🚓', '🚑',
    '🍔', '🍕', '🍖', '🍗', '🍝', '🍜', '🍲', '🍱',
    '☕', '🍵', '🍶', '🍷', '🍸', '🍹', '🍺', '🍻',
    '🎮', '🎯', '🎲', '🎨', '🎭', '🎪', '🎬', '🎤',
    '🏥', '💊', '💉', '🏃', '🚴', '🏋️', '⛹️', '🤸',
    '📚', '📖', '📕', '📗', '📘', '📙', '📓', '📔',
    '👕', '👔', '👗', '👘', '👙', '👚', '👛', '👜',
    '🎁', '🎀', '🎂', '🎃', '🎄', '🎅', '🎆', '🎇',
    '❤️', '💛', '💚', '💙', '💜', '🖤', '🤍', '🤎',
    '⭐', '🌟', '✨', '💫', '🔥', '💥', '⚡', '🌈',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _addCategory() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _errorMessage = '카테고리 이름을 입력해주세요';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    final category = CustomTransactionCategoryModel.create(
      name: name,
      transactionType: widget.transactionType,
      colorValue: _colorPalette[_selectedColorIndex],
      iconName: _selectedEmoji,
    );

    await ref.read(customTransactionCategoryNotifierProvider.notifier).addCategory(category);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  List<TransactionCategory> get _categories {
    switch (widget.transactionType) {
      case TransactionType.income:
        return TransactionCategoryExtension.incomeCategories;
      case TransactionType.expense:
        return TransactionCategoryExtension.expenseCategories;
      case TransactionType.transfer:
        return TransactionCategoryExtension.savingsCategories;
    }
  }

  void _showEditSheet(BuildContext context, TransactionCategory category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditTransactionCategorySheet(
        category: category,
        onSaved: () {
          Navigator.pop(context);
          setState(() {}); // UI 갱신
        },
      ),
    );
  }

  void _showEditCustomSheet(BuildContext context, CustomTransactionCategoryModel category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditCustomTransactionCategorySheet(
        category: category,
        onSaved: () {
          ref.invalidate(customTransactionCategoryNotifierProvider);
          Navigator.pop(context);
          setState(() {}); // UI 갱신
        },
      ),
    );
  }

  void _showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
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
                    '이모지 선택',
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
            // 이모지 그리드
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _emojiList.length,
                itemBuilder: (context, index) {
                  final emoji = _emojiList[index];
                  final isSelected = _selectedEmoji == emoji;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedEmoji = emoji;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.1)
                            : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(color: AppColors.primary, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteCustomCategory(
    BuildContext context,
    WidgetRef ref,
    CustomTransactionCategoryModel category,
  ) async {
    // 해당 카테고리를 사용하는 거래가 있는지 확인
    final transactions = await ref.read(transactionListProvider.future);
    final hasTransactions = transactions.any((t) => t.customCategoryId == category.uid);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('카테고리 삭제'),
        content: Text(
          hasTransactions
              ? "'${category.name}' 카테고리를 삭제하면 해당 카테고리를 사용하는 거래도 함께 삭제됩니다.\n정말 삭제하시겠습니까?"
              : "'${category.name}' 카테고리를 삭제하시겠습니까?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // 해당 카테고리를 사용하는 거래 삭제
      if (hasTransactions) {
        final transactionNotifier = ref.read(transactionNotifierProvider.notifier);
        for (final transaction in transactions) {
          if (transaction.customCategoryId == category.uid) {
            await transactionNotifier.deleteTransaction(transaction.id);
          }
        }
      }
      // 카테고리 삭제
      await ref.read(customTransactionCategoryNotifierProvider.notifier)
          .deleteCategory(category.uid);
      if (context.mounted) {
        setState(() {}); // UI 갱신
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
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
                Text(
                  widget.transactionType == TransactionType.income
                      ? '소득 카테고리 관리'
                      : widget.transactionType == TransactionType.transfer
                          ? '저축 카테고리 관리'
                          : '소비 카테고리 관리',
                  style: const TextStyle(
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

          // 새 카테고리 추가 섹션
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '새 카테고리 추가',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // 이모지 선택 버튼
                    GestureDetector(
                      onTap: () => _showEmojiPicker(context),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.gray300,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _selectedEmoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: '카테고리 이름',
                          filled: true,
                          fillColor: AppColors.surfaceVariant,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _addCategory,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('추가'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 색상 선택
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(_colorPalette.length, (index) {
                    final isSelected = _selectedColorIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColorIndex = index),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(_colorPalette[index]),
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: AppColors.textPrimary, width: 3)
                              : null,
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white, size: 18)
                            : null,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // 카테고리 목록 (기본 + 사용자 정의)
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final customCategoriesAsync = ref.watch(
                  customTransactionCategoriesByTypeProvider(widget.transactionType),
                );
                
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _categories.length + 
                      customCategoriesAsync.maybeWhen(
                        data: (list) => list.length,
                        orElse: () => 0,
                      ),
                  itemBuilder: (context, index) {
                    // 기본 카테고리 먼저 표시
                    if (index < _categories.length) {
                      final category = _categories[index];
                      return FutureBuilder<TransactionCategoryCustomization?>(
                        future: TransactionCategoryCustomizer.getCustomization(category),
                        builder: (context, snapshot) {
                          final customization = snapshot.data;
                          final displayName = customization?.name ?? category.displayName;
                          final colorValue = customization?.colorValue ?? 
                              (category.isIncome ? 0xFF4CAF50 : 
                               category.isExpense ? 0xFFF44336 : 0xFF2196F3);
                          
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Color(colorValue),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    displayName,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined),
                                  color: AppColors.primary,
                                  iconSize: 22,
                                  onPressed: () => _showEditSheet(context, category),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    
                    // 사용자 정의 카테고리 표시
                    return customCategoriesAsync.when(
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                      data: (customCategories) {
                        final customIndex = index - _categories.length;
                        if (customIndex >= customCategories.length) {
                          return const SizedBox.shrink();
                        }
                        final custom = customCategories[customIndex];
                        final isEmoji = custom.iconName.isNotEmpty && 
                            !custom.iconName.startsWith('Icons.') &&
                            custom.iconName.length <= 2;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              if (isEmoji)
                                Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  child: Text(
                                    custom.iconName,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                )
                              else
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Color(custom.colorValue),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  custom.name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                color: AppColors.primary,
                                iconSize: 22,
                                onPressed: () => _showEditCustomSheet(context, custom),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                color: AppColors.error,
                                iconSize: 22,
                                onPressed: () => _deleteCustomCategory(context, ref, custom),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),

              // 안전 영역
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
        // 에러 메시지 (스낵바) - 바텀시트 위에 표시
        if (_errorMessage != null)
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              color: AppColors.gray900,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 20),
                      onPressed: () {
                        setState(() {
                          _errorMessage = null;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================
// 사용자 정의 거래 카테고리 수정 시트
// ============================================

/// 사용자 정의 거래 카테고리 수정 시트
class _EditCustomTransactionCategorySheet extends ConsumerStatefulWidget {
  final CustomTransactionCategoryModel category;
  final VoidCallback onSaved;

  const _EditCustomTransactionCategorySheet({
    required this.category,
    required this.onSaved,
  });

  @override
  ConsumerState<_EditCustomTransactionCategorySheet> createState() => _EditCustomTransactionCategorySheetState();
}

class _EditCustomTransactionCategorySheetState extends ConsumerState<_EditCustomTransactionCategorySheet> {
  late TextEditingController _nameController;
  late int _selectedColorIndex;
  late String _selectedEmoji;
  String? _errorMessage;

  // 선택 가능한 색상 팔레트
  static const List<int> _colorPalette = [
    0xFF4CAF50, // 녹색
    0xFF2196F3, // 파랑
    0xFFFF9800, // 주황
    0xFFE91E63, // 분홍
    0xFF9C27B0, // 보라
    0xFF00BCD4, // 청록
    0xFFFF5722, // 깊은 주황
    0xFF795548, // 갈색
    0xFF607D8B, // 회색
    0xFFCDDC39, // 라임
  ];

  // 선택 가능한 이모지 리스트
  static const List<String> _emojiList = [
    '💼', '💰', '💵', '💳', '💸', '💴', '💶', '💷',
    '📊', '📈', '📉', '📁', '📂', '📋', '📝', '📌',
    '🏠', '🏡', '🏢', '🏬', '🏪', '🏫', '🏭', '🏨',
    '🚗', '🚕', '🚙', '🚌', '🚎', '🏎️', '🚓', '🚑',
    '🍔', '🍕', '🍖', '🍗', '🍝', '🍜', '🍲', '🍱',
    '☕', '🍵', '🍶', '🍷', '🍸', '🍹', '🍺', '🍻',
    '🎮', '🎯', '🎲', '🎨', '🎭', '🎪', '🎬', '🎤',
    '🏥', '💊', '💉', '🏃', '🚴', '🏋️', '⛹️', '🤸',
    '📚', '📖', '📕', '📗', '📘', '📙', '📓', '📔',
    '👕', '👔', '👗', '👘', '👙', '👚', '👛', '👜',
    '🎁', '🎀', '🎂', '🎃', '🎄', '🎅', '🎆', '🎇',
    '❤️', '💛', '💚', '💙', '💜', '🖤', '🤍', '🤎',
    '⭐', '🌟', '✨', '💫', '🔥', '💥', '⚡', '🌈',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category.name);
    _selectedColorIndex = _colorPalette.indexOf(widget.category.colorValue);
    if (_selectedColorIndex == -1) _selectedColorIndex = 0;
    // iconName이 이모지인지 확인 (길이가 1-2이고 Material Icons 이름이 아닌 경우)
    if (widget.category.iconName.isNotEmpty && 
        !widget.category.iconName.startsWith('Icons.') &&
        widget.category.iconName.length <= 2) {
      _selectedEmoji = widget.category.iconName;
    } else {
      _selectedEmoji = '📁';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _errorMessage = '카테고리 이름을 입력해주세요';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    final updated = widget.category;
    updated.name = name;
    updated.colorValue = _colorPalette[_selectedColorIndex];
    updated.iconName = _selectedEmoji;
    updated.updatedAt = DateTime.now();

    await ref.read(customTransactionCategoryNotifierProvider.notifier).updateCategory(updated);
    widget.onSaved();
  }

  void _showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
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
                    '이모지 선택',
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
            // 이모지 그리드
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _emojiList.length,
                itemBuilder: (context, index) {
                  final emoji = _emojiList[index];
                  final isSelected = _selectedEmoji == emoji;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedEmoji = emoji;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.1)
                            : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(color: AppColors.primary, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 핸들
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.gray300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // 헤더
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '카테고리 수정',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded),
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // 이모지 및 이름 입력
                  Row(
                    children: [
                      // 이모지 선택 버튼
                      GestureDetector(
                        onTap: () => _showEmojiPicker(context),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.gray300,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _selectedEmoji,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '카테고리 이름',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: '카테고리 이름',
                                filled: true,
                                fillColor: AppColors.gray100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // 색상 선택
                  const Text(
                    '색상',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(_colorPalette.length, (index) {
                      final isSelected = _selectedColorIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColorIndex = index),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(_colorPalette[index]),
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: AppColors.textPrimary, width: 3)
                                : null,
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, color: Colors.white, size: 24)
                              : null,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  
                  // 저장 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
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
                ],
              ),
            ),
          ),
        ),
        // 에러 메시지 (스낵바) - 바텀시트 위에 표시
        if (_errorMessage != null)
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              color: AppColors.gray900,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 20),
                      onPressed: () {
                        setState(() {
                          _errorMessage = null;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
