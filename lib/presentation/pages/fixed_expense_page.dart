import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/utils/default_category_customizer.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';
import '../providers/fixed_expense_provider.dart';
import '../providers/ledger_provider.dart';

TransactionCategory _fixedCategoryToTransaction(FixedExpenseCategory c) {
  switch (c) {
    case FixedExpenseCategory.housing:
      return TransactionCategory.housing;
    case FixedExpenseCategory.communication:
      return TransactionCategory.housing;
    case FixedExpenseCategory.insurance:
      return TransactionCategory.insurance;
    case FixedExpenseCategory.subscription:
      return TransactionCategory.culture;
    case FixedExpenseCategory.etc:
      return TransactionCategory.otherExpense;
  }
}

/// 카테고리 그룹 정보
class CategoryGroup {
  final String name;
  final bool isCustom;
  final String? categoryKey; // 기본 카테고리일 때
  final FixedExpenseCategory? defaultCategory; // 기본 카테고리 enum
  final String? customCategoryId; // 사용자 정의 카테고리일 때
  final CustomFixedCategoryModel? customCategory; // 사용자 정의 카테고리 모델

  CategoryGroup({
    required this.name,
    required this.isCustom,
    this.categoryKey,
    this.defaultCategory,
    this.customCategoryId,
    this.customCategory,
  });
}

/// 고정비 관리 페이지
class FixedExpensePage extends ConsumerWidget {
  const FixedExpensePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fixedExpensesAsync = ref.watch(fixedExpenseNotifierProvider);
    final customCategoriesAsync = ref.watch(customFixedCategoryNotifierProvider);
    ref.watch(paymentMethodNotifierProvider); // 결제방법 미리 로드 (고정비 시트 연동용)

    return Scaffold(
      backgroundColor: AppColors.ledgerBackground,
      appBar: AppBar(
        title: const Text(
          '고정비 관리',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: fixedExpensesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류: $error')),
        data: (fixedExpenses) {
          if (fixedExpenses.isEmpty) {
            return _EmptyState(
              onAdd: () => _showAddSheet(context, ref),
            );
          }

          return customCategoriesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('오류: $error')),
            data: (customCategories) {
              // 카테고리별로 그룹화 (기본 카테고리 + 사용자 정의 카테고리)
              final categoryMap = <String, CategoryGroup>{};
              
              // 기본 카테고리 그룹
              for (final category in FixedExpenseCategory.values) {
                final expenses = fixedExpenses.where((e) => 
                  e.category == category && e.customCategoryId == null
                ).toList();
                if (expenses.isNotEmpty) {
                  categoryMap[category.name] = CategoryGroup(
                    name: category.displayName,
                    isCustom: false,
                    categoryKey: category.name,
                    defaultCategory: category,
                    customCategoryId: null,
                  );
                }
              }
              
              // 사용자 정의 카테고리 그룹
              for (final custom in customCategories) {
                final expenses = fixedExpenses.where((e) => 
                  e.customCategoryId == custom.uid
                ).toList();
                if (expenses.isNotEmpty) {
                  categoryMap[custom.uid] = CategoryGroup(
                    name: custom.name,
                    isCustom: true,
                    categoryKey: null,
                    customCategoryId: custom.uid,
                    customCategory: custom,
                  );
                }
              }

              // 카테고리 그룹 리스트 생성
              final categoryGroups = categoryMap.entries.map((entry) {
                final group = entry.value;
                final expenses = fixedExpenses.where((e) {
                  if (group.isCustom) {
                    return e.customCategoryId == group.customCategoryId;
                  } else {
                    return e.category.name == group.categoryKey && e.customCategoryId == null;
                  }
                }).toList();
                
                return MapEntry(group, expenses);
              }).toList();

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // 안내 문구
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.touch_app_rounded, color: AppColors.primary, size: 20),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            '카드를 탭하면 바로 가계부에 등록할 수 있어요',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 그리드 형태로 카테고리 박스 표시
                  ..._buildCategoryGrid(categoryGroups, context, ref),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context, ref),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(AppIcons.add),
        label: const Text('고정비 추가'),
      ),
    );
  }

  List<Widget> _buildCategoryGrid(
    List<MapEntry<CategoryGroup, List<FixedExpenseModel>>> categoryGroups,
    BuildContext context,
    WidgetRef ref,
  ) {
    final rows = <Widget>[];
    
    for (int i = 0; i < categoryGroups.length; i += 3) {
      final rowItems = <Widget>[];
      
      for (int j = i; j < i + 3 && j < categoryGroups.length; j++) {
        final entry = categoryGroups[j];
        final group = entry.key;
        final expenses = entry.value;
        
        rowItems.add(
          Expanded(
            child: _CategoryBox(
              categoryGroup: group,
              expenses: expenses,
              onQuickEntry: (expense) => _showQuickEntrySheet(context, ref, expense),
              onEdit: (expense) => _showEditSheet(context, ref, expense),
              onDelete: (expense) => _confirmDelete(context, ref, expense),
              onEditCategory: group.isCustom 
                  ? () => _showEditCategorySheet(context, ref, group.customCategory!)
                  : group.defaultCategory != null
                      ? () => _showEditDefaultCategorySheet(context, ref, group.defaultCategory!)
                      : null,
              onDeleteCategory: group.isCustom 
                  ? () => _confirmDeleteCategory(context, ref, group.customCategory!)
                  : group.defaultCategory != null
                      ? () => _confirmDeleteDefaultCategory(context, ref, group.defaultCategory!)
                      : null,
            ),
          ),
        );
        
        // 마지막 아이템이 아니면 간격 추가
        if (j < i + 3 - 1 && j < categoryGroups.length - 1) {
          rowItems.add(const SizedBox(width: 12));
        }
      }
      
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowItems,
        ),
      );
      
      // 마지막 행이 아니면 간격 추가
      if (i + 3 < categoryGroups.length) {
        rows.add(const SizedBox(height: 12));
      }
    }
    
    return rows;
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddEditFixedExpenseSheet(
        onSaved: (expense) async {
          await ref.read(fixedExpenseNotifierProvider.notifier).addFixedExpense(expense);
          final created = await ref.read(fixedExpenseServiceProvider).createTransactionForFixedExpense(expense);
          if (created) ref.invalidate(transactionNotifierProvider);
          if (context.mounted) Navigator.pop(context);
        },
      ),
    );
  }

  void _showEditSheet(BuildContext context, WidgetRef ref, FixedExpenseModel expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddEditFixedExpenseSheet(
        expense: expense,
        onSaved: (updated) async {
          await ref.read(fixedExpenseNotifierProvider.notifier).updateFixedExpense(updated);
          final created = await ref.read(fixedExpenseServiceProvider).createTransactionForFixedExpense(updated);
          if (created) ref.invalidate(transactionNotifierProvider);
          if (context.mounted) Navigator.pop(context);
        },
      ),
    );
  }

  void _showQuickEntrySheet(BuildContext context, WidgetRef ref, FixedExpenseModel expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _QuickEntrySheet(
        expense: expense,
        onSaved: () {
          ref.invalidate(transactionNotifierProvider);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${expense.title} 내역이 등록되었습니다')),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, FixedExpenseModel expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('${expense.title}을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(fixedExpenseNotifierProvider.notifier).deleteFixedExpense(expense.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showEditCategorySheet(BuildContext context, WidgetRef ref, CustomFixedCategoryModel category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditCategorySheet(
        category: category,
        onSaved: () {
          ref.invalidate(customFixedCategoryNotifierProvider);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _confirmDeleteCategory(BuildContext context, WidgetRef ref, CustomFixedCategoryModel category) {
    // 해당 카테고리를 사용하는 고정비가 있는지 확인
    final fixedExpenses = ref.read(fixedExpenseNotifierProvider).valueOrNull ?? [];
    final hasExpenses = fixedExpenses.any((e) => e.customCategoryId == category.uid);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('카테고리 삭제'),
        content: Text(
          hasExpenses
              ? "'${category.name}' 카테고리를 삭제하면 해당 카테고리를 사용하는 고정비도 함께 삭제됩니다.\n정말 삭제하시겠습니까?"
              : "'${category.name}' 카테고리를 삭제하시겠습니까?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              // 해당 카테고리를 사용하는 고정비 삭제
              if (hasExpenses) {
                for (final expense in fixedExpenses) {
                  if (expense.customCategoryId == category.uid) {
                    await ref.read(fixedExpenseNotifierProvider.notifier).deleteFixedExpense(expense.id);
                  }
                }
              }
              // 카테고리 삭제
              await ref.read(customFixedCategoryNotifierProvider.notifier).deleteCategory(category.uid);
              if (context.mounted) Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showEditDefaultCategorySheet(BuildContext context, WidgetRef ref, FixedExpenseCategory category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditDefaultCategorySheet(
        category: category,
        onSaved: () {
          ref.invalidate(fixedExpenseNotifierProvider);
          if (context.mounted) Navigator.pop(context);
        },
      ),
    );
  }

  void _confirmDeleteDefaultCategory(BuildContext context, WidgetRef ref, FixedExpenseCategory category) {
    // 해당 카테고리를 사용하는 고정비가 있는지 확인
    final fixedExpenses = ref.read(fixedExpenseNotifierProvider).valueOrNull ?? [];
    final hasExpenses = fixedExpenses.any((e) => 
      e.category == category && e.customCategoryId == null
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('카테고리 삭제'),
        content: Text(
          hasExpenses
              ? "'${category.displayName}' 카테고리를 삭제하면 해당 카테고리를 사용하는 고정비도 함께 삭제됩니다.\n정말 삭제하시겠습니까?"
              : "'${category.displayName}' 카테고리를 삭제하시겠습니까?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              // 해당 카테고리를 사용하는 고정비 삭제
              if (hasExpenses) {
                for (final expense in fixedExpenses) {
                  if (expense.category == category && expense.customCategoryId == null) {
                    await ref.read(fixedExpenseNotifierProvider.notifier).deleteFixedExpense(expense.id);
                  }
                }
              }
              if (context.mounted) Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}

/// 빈 상태 위젯
class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AppIcons.repeat,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            '등록된 고정비가 없습니다',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '매월 반복되는 지출을 등록해보세요',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(AppIcons.add),
            label: const Text('고정비 추가'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// 카테고리 박스 - 아이폰 홈 화면 스타일
class _CategoryBox extends StatefulWidget {
  final CategoryGroup categoryGroup;
  final List<FixedExpenseModel> expenses;
  final void Function(FixedExpenseModel) onQuickEntry;
  final void Function(FixedExpenseModel) onEdit;
  final void Function(FixedExpenseModel) onDelete;
  final VoidCallback? onEditCategory;
  final VoidCallback? onDeleteCategory;

  const _CategoryBox({
    required this.categoryGroup,
    required this.expenses,
    required this.onQuickEntry,
    required this.onEdit,
    required this.onDelete,
    this.onEditCategory,
    this.onDeleteCategory,
  });

  @override
  State<_CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<_CategoryBox> {
  String? _customizedName;
  int? _customizedColor;

  @override
  void initState() {
    super.initState();
    if (!widget.categoryGroup.isCustom && widget.categoryGroup.defaultCategory != null) {
      _loadCustomization();
    }
  }

  @override
  void didUpdateWidget(_CategoryBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.categoryGroup.isCustom && widget.categoryGroup.defaultCategory != null) {
      _loadCustomization();
    }
  }

  Future<void> _loadCustomization() async {
    if (widget.categoryGroup.defaultCategory == null) return;
    
    final customization = await DefaultCategoryCustomizer.getCustomization(
      widget.categoryGroup.defaultCategory!,
    );
    
    if (mounted) {
      setState(() {
        _customizedName = customization?.name;
        _customizedColor = customization?.colorValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.categoryGroup.isCustom
        ? widget.categoryGroup.name
        : (_customizedName ?? widget.categoryGroup.name);
    
    final displayColor = widget.categoryGroup.isCustom
        ? widget.categoryGroup.customCategory!.colorValue
        : (_customizedColor ?? 0xFF4CAF50);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더 - 카테고리 이름 + 수정/삭제 버튼
          Row(
            children: [
              // 카테고리 아이콘/색상
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Color(displayColor).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(
                  widget.categoryGroup.isCustom
                      ? Icons.category_rounded
                      : Icons.folder_rounded,
                  size: 16,
                  color: Color(displayColor),
                ),
              ),
              const SizedBox(width: 8),
              // 카테고리 이름
              Expanded(
                child: Text(
                  displayName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 수정/삭제 버튼 (모든 카테고리)
              if (widget.onEditCategory != null || widget.onDeleteCategory != null)
                PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    size: 18,
                    color: AppColors.textTertiary,
                  ),
                  itemBuilder: (context) => [
                    if (widget.onEditCategory != null)
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 18),
                            SizedBox(width: 8),
                            Text('카테고리 수정'),
                          ],
                        ),
                      ),
                    if (widget.onDeleteCategory != null)
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                            SizedBox(width: 8),
                            Text('카테고리 삭제', style: TextStyle(color: AppColors.error)),
                          ],
                        ),
                      ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit' && widget.onEditCategory != null) {
                      widget.onEditCategory!();
                    } else if (value == 'delete' && widget.onDeleteCategory != null) {
                      widget.onDeleteCategory!();
                    }
                  },
                ),
            ],
          ),
          const SizedBox(height: 12),
          // 그리드 형태로 카드 표시
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: widget.expenses.length,
            itemBuilder: (context, index) {
              final expense = widget.expenses[index];
              return _FixedExpenseGridCard(
                expense: expense,
                onQuickEntry: () => widget.onQuickEntry(expense),
                onEdit: () => widget.onEdit(expense),
                onDelete: () => widget.onDelete(expense),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// 고정비 카드 - 탭하면 바로 가계부에 등록
class _FixedExpenseCard extends StatelessWidget {
  final FixedExpenseModel expense;
  final VoidCallback onQuickEntry;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _FixedExpenseCard({
    required this.expense,
    required this.onQuickEntry,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.gray200),
      ),
      child: InkWell(
        onTap: onQuickEntry,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 아이콘 - 탭 유도
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              // 내용
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textTertiary),
                        const SizedBox(width: 4),
                        Text(
                          '매월 ${expense.dueDate}일',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        if (expense.amount != null && expense.amount! > 0) ...[
                          const SizedBox(width: 10),
                          Icon(Icons.attach_money_rounded, size: 14, color: AppColors.textTertiary),
                          Text(
                            '${numberFormat.format(expense.amount)}원',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              // 메뉴 버튼
              PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  size: 22,
                  color: AppColors.textTertiary,
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 18),
                        SizedBox(width: 8),
                        Text('수정'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                        SizedBox(width: 8),
                        Text('삭제', style: TextStyle(color: AppColors.error)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit();
                  } else if (value == 'delete') {
                    onDelete();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 고정비 그리드 카드 - 아이폰 앱 아이콘 스타일
class _FixedExpenseGridCard extends StatelessWidget {
  final FixedExpenseModel expense;
  final VoidCallback onQuickEntry;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _FixedExpenseGridCard({
    required this.expense,
    required this.onQuickEntry,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');

    return GestureDetector(
      onTap: onQuickEntry,
      onLongPress: () {
        // 롱프레스로 메뉴 표시
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => Container(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text('수정'),
                    onTap: () {
                      Navigator.pop(context);
                      onEdit();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete_outline, color: AppColors.error),
                    title: const Text('삭제', style: TextStyle(color: AppColors.error)),
                    onTap: () {
                      Navigator.pop(context);
                      onDelete();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 아이콘
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            // 제목
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                expense.title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            // 금액 (있는 경우)
            if (expense.amount != null && expense.amount! > 0) ...[
              const SizedBox(height: 2),
              Text(
                '${numberFormat.format(expense.amount)}원',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.9),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 고정비 추가/수정 바텀시트
class _AddEditFixedExpenseSheet extends ConsumerStatefulWidget {
  final FixedExpenseModel? expense;
  final FixedExpenseModel? templateForThisMonth;
  final Future<void> Function(FixedExpenseModel) onSaved;
  final Future<void> Function()? onSavedThisMonth;

  const _AddEditFixedExpenseSheet({
    this.expense,
    this.templateForThisMonth,
    required this.onSaved,
    this.onSavedThisMonth,
  });

  @override
  ConsumerState<_AddEditFixedExpenseSheet> createState() => _AddEditFixedExpenseSheetSheetState();
}

class _AddEditFixedExpenseSheetSheetState extends ConsumerState<_AddEditFixedExpenseSheet> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  FixedExpenseCategory _selectedCategory = FixedExpenseCategory.housing;
  String? _selectedCustomCategoryId; // 사용자 정의 카테고리 선택 시 사용
  late DateTime _selectedDate;
  int? _selectedPaymentMethodId;
  List<PaymentMethodModel> _paymentMethods = [];
  List<CustomFixedCategoryModel> _customCategories = [];
  Map<FixedExpenseCategory, DefaultCategoryCustomization> _defaultCategoryCustomizations = {};
  static final _dateFormat = DateFormat('yyyy년 M월 d일');

  bool get _isEditing => widget.expense != null;
  bool get _isTemplateMode => widget.templateForThisMonth != null;
  bool get _isCustomCategorySelected => _selectedCustomCategoryId != null;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    if (widget.templateForThisMonth != null) {
      final t = widget.templateForThisMonth!;
      _titleController = TextEditingController(text: t.title);
      _amountController = TextEditingController(text: t.amount != null && t.amount! > 0 ? t.amount.toString() : '');
      _selectedCategory = t.category;
      _selectedCustomCategoryId = t.customCategoryId;
      _selectedPaymentMethodId = t.linkedPaymentMethodId;
      final lastDay = DateTime(now.year, now.month + 1, 0).day;
      final day = t.dueDate > lastDay ? lastDay : t.dueDate;
      _selectedDate = DateTime(now.year, now.month, day);
    } else if (widget.expense != null) {
      final e = widget.expense!;
      _titleController = TextEditingController(text: e.title);
      _amountController = TextEditingController(
        text: e.amount != null && e.amount! > 0 ? e.amount.toString() : '',
      );
      _selectedCategory = e.category;
      _selectedCustomCategoryId = e.customCategoryId;
      _selectedPaymentMethodId = e.linkedPaymentMethodId;
      final lastDay = DateTime(now.year, now.month + 1, 0).day;
      final day = e.dueDate > lastDay ? lastDay : e.dueDate;
      _selectedDate = DateTime(now.year, now.month, day);
    } else {
      _titleController = TextEditingController();
      _amountController = TextEditingController();
      _selectedDate = DateTime(now.year, now.month, now.day);
    }
    _loadPaymentMethods();
    _loadCustomCategories();
    _loadDefaultCategoryCustomizations();
  }

  Future<void> _loadDefaultCategoryCustomizations() async {
    final customizations = await DefaultCategoryCustomizer.getAllCustomizations();
    if (mounted) {
      setState(() {
        _defaultCategoryCustomizations = {};
        for (final category in FixedExpenseCategory.values) {
          final customization = customizations[category.name];
          if (customization != null) {
            _defaultCategoryCustomizations[category] = customization;
          }
        }
      });
    }
  }

  void _loadPaymentMethods() {
    final paymentMethodsAsync = ref.read(paymentMethodNotifierProvider);
    paymentMethodsAsync.whenData((paymentMethods) {
      if (mounted) {
        setState(() {
          _paymentMethods = paymentMethods;
        });
      }
    });
  }

  void _syncPaymentMethodsFromProvider(AsyncValue<List<PaymentMethodModel>> value) {
    value.whenData((list) {
      if (mounted) setState(() => _paymentMethods = list);
    });
  }

  void _loadCustomCategories() {
    final customCategoriesAsync = ref.read(customFixedCategoryNotifierProvider);
    customCategoriesAsync.whenData((categories) {
      if (mounted) {
        setState(() {
          _customCategories = categories;
        });
      }
    });
  }

  void _syncCustomCategoriesFromProvider(AsyncValue<List<CustomFixedCategoryModel>> value) {
    value.whenData((list) {
      if (mounted) setState(() => _customCategories = list);
    });
  }

  void _showCategoryManageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CategoryManageSheet(
        onCategoryAdded: () {
          _loadCustomCategories();
        },
        onCategoryDeleted: (uid) {
          // 삭제된 카테고리가 현재 선택된 것이면 기본값으로 리셋
          if (_selectedCustomCategoryId == uid) {
            setState(() {
              _selectedCustomCategoryId = null;
              _selectedCategory = FixedExpenseCategory.etc;
            });
          }
          _loadCustomCategories();
        },
      ),
    );
  }

  void _showEditDefaultCategorySheet(BuildContext context, FixedExpenseCategory category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditDefaultCategorySheet(
        category: category,
        onSaved: () {
          _loadDefaultCategoryCustomizations();
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showEditCategorySheet(BuildContext context, WidgetRef ref, CustomFixedCategoryModel category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditCategorySheet(
        category: category,
        onSaved: () {
          ref.invalidate(customFixedCategoryNotifierProvider);
          _loadCustomCategories();
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      locale: const Locale('ko', 'KR'),
      helpText: '날짜를 선택해주세요',
      cancelText: '취소',
      confirmText: '확인',
      fieldLabelText: '날짜 입력',
      fieldHintText: 'yyyy/mm/dd',
    );
    if (picked != null && mounted) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목을 입력해주세요')),
      );
      return;
    }

    // 금액 파싱 (선택사항이므로 비어있어도 OK)
    int? parsedAmount;
    final amountText = _amountController.text.trim();
    if (amountText.isNotEmpty) {
      parsedAmount = int.tryParse(amountText.replaceAll(',', ''));
      if (parsedAmount != null && parsedAmount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('올바른 금액을 입력해주세요')),
        );
        return;
      }
    }

    if (_isTemplateMode) {
      final amount = parsedAmount ?? 0;
      if (amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('금액을 입력해주세요')),
        );
        return;
      }
      final pmId = _selectedPaymentMethodId ?? 0;
      if (pmId <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('결제방법을 선택해주세요')),
        );
        return;
      }
      final t = TransactionModel.expense(
        uid: const Uuid().v4(),
        date: _selectedDate,
        category: _fixedCategoryToTransaction(_selectedCategory),
        description: title,
        amount: amount,
        withdrawAccountId: pmId,
      );
      t.isRecurring = true;
      await ref.read(transactionNotifierProvider.notifier).addTransaction(t, emitIncomeEvent: false);
      if (widget.onSavedThisMonth != null) {
        await widget.onSavedThisMonth!();
      }
      return;
    }

    final expense = widget.expense ?? FixedExpenseModel.create(
      title: title,
      category: _selectedCategory,
      customCategoryId: _selectedCustomCategoryId,
      dueDate: _selectedDate.day,
      isVariableAmount: false,
      isRecurringMonthly: false,
      amount: parsedAmount,
      linkedPaymentMethodId: _selectedPaymentMethodId,
    );

    if (_isEditing) {
      expense.title = title;
      expense.category = _selectedCategory;
      expense.customCategoryId = _selectedCustomCategoryId;
      expense.dueDate = _selectedDate.day;
      expense.amount = parsedAmount;
      expense.linkedPaymentMethodId = _selectedPaymentMethodId;
    }

    await widget.onSaved(expense);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<PaymentMethodModel>>>(
      paymentMethodNotifierProvider,
      (prev, next) => _syncPaymentMethodsFromProvider(next),
    );
    ref.listen<AsyncValue<List<CustomFixedCategoryModel>>>(
      customFixedCategoryNotifierProvider,
      (prev, next) => _syncCustomCategoriesFromProvider(next),
    );
    return Container(
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
                  _isTemplateMode
                      ? '이번 달 입력 (${widget.templateForThisMonth!.title})'
                      : _isEditing
                          ? '고정비 수정'
                          : '고정비 추가',
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
          // 폼
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목 입력
                  const Text(
                    '제목',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: '예: 관리비, 넷플릭스',
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 카테고리 선택
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '카테고리',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showCategoryManageSheet(context),
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
                      ...FixedExpenseCategory.values.map((category) {
                        final isSelected = !_isCustomCategorySelected && _selectedCategory == category;
                        final customization = _defaultCategoryCustomizations[category];
                        final displayName = customization?.name ?? category.displayName;
                        final displayColor = customization?.colorValue ?? 0xFF4CAF50;
                        
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedCategory = category;
                            _selectedCustomCategoryId = null;
                          }),
                          onLongPress: () => _showEditDefaultCategorySheet(context, category),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(displayColor)
                                  : AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(20),
                              border: !isSelected && customization != null
                                  ? Border.all(
                                      color: Color(displayColor).withOpacity(0.5),
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Text(
                              displayName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        );
                      }),
                      // 사용자 정의 카테고리
                      ..._customCategories.map((custom) {
                        final isSelected = _selectedCustomCategoryId == custom.uid;
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedCustomCategoryId = custom.uid;
                            _selectedCategory = FixedExpenseCategory.etc;
                          }),
                          onLongPress: () => _showEditCategorySheet(context, ref, custom),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(custom.colorValue)
                                  : AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected ? null : Border.all(
                                color: Color(custom.colorValue).withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (custom.iconName.isNotEmpty && 
                                    !custom.iconName.startsWith('Icons.') &&
                                    custom.iconName.length <= 2)
                                  Text(
                                    custom.iconName,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                if (custom.iconName.isNotEmpty && 
                                    !custom.iconName.startsWith('Icons.') &&
                                    custom.iconName.length <= 2)
                                  const SizedBox(width: 6),
                                Text(
                                  custom.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 결제일 선택 (날짜 년월일)
                  const Text(
                    '결제일',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 22, color: AppColors.textSecondary),
                          const SizedBox(width: 12),
                          Text(
                            _dateFormat.format(_selectedDate),
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.chevron_right, size: 22, color: AppColors.textTertiary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 기본 금액 입력 (선택사항 - 빠른 입력시 기본값으로 사용)
                  const Text(
                    '기본 금액 (선택사항)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '빠른 입력시 기본값으로 사용됩니다',
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixText: '원',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 결제방법 (입출금·파킹·카드 모두)
                  const Text(
                    '결제방법 (선택)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int?>(
                        isExpanded: true,
                        value: _selectedPaymentMethodId,
                        hint: const Text('입출금·파킹·카드 등 결제방법 선택'),
                        items: [
                          const DropdownMenuItem<int?>(
                            value: null,
                            child: Text('선택 안 함'),
                          ),
                          ..._paymentMethods.map((method) => DropdownMenuItem<int?>(
                                value: method.id,
                                child: Text('${method.name} (${method.type.displayName})'),
                              )),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedPaymentMethodId = value);
                        },
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================
// 빠른 입력 시트 (고정비 → 가계부 등록)
// ============================================

/// 빠른 입력 시트 - 날짜와 금액만 입력하면 바로 가계부 등록
class _QuickEntrySheet extends ConsumerStatefulWidget {
  final FixedExpenseModel expense;
  final VoidCallback onSaved;

  const _QuickEntrySheet({
    required this.expense,
    required this.onSaved,
  });

  @override
  ConsumerState<_QuickEntrySheet> createState() => _QuickEntrySheetState();
}

class _QuickEntrySheetState extends ConsumerState<_QuickEntrySheet> {
  late TextEditingController _amountController;
  late DateTime _selectedDate;
  static final _dateFormat = DateFormat('yyyy년 M월 d일');

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    // 기본 금액이 있으면 미리 채움
    _amountController = TextEditingController(
      text: widget.expense.amount != null && widget.expense.amount! > 0
          ? widget.expense.amount.toString()
          : '',
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      locale: const Locale('ko', 'KR'),
      helpText: '날짜를 선택해주세요',
      cancelText: '취소',
      confirmText: '확인',
    );
    if (picked != null && mounted) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _save() async {
    final amountText = _amountController.text.trim().replaceAll(',', '');
    final amount = int.tryParse(amountText);
    
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('금액을 입력해주세요')),
      );
      return;
    }

    // 가계부 내역으로 바로 저장
    final transaction = TransactionModel.expense(
      uid: const Uuid().v4(),
      date: _selectedDate,
      category: _fixedCategoryToTransaction(widget.expense.category),
      description: widget.expense.title,
      amount: amount,
      withdrawAccountId: widget.expense.linkedPaymentMethodId ?? 0,
    );
    transaction.isRecurring = true;
    
    await ref.read(transactionNotifierProvider.notifier).addTransaction(
      transaction,
      emitIncomeEvent: false,
    );
    
    widget.onSaved();
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');
    
    return Container(
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
              
              // 헤더 - 고정비 이름
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      AppIcons.repeat,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.expense.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          widget.expense.category.displayName,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              
              // 날짜 선택
              const Text(
                '결제일',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.textSecondary),
                      const SizedBox(width: 12),
                      Text(
                        _dateFormat.format(_selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right_rounded, size: 22, color: AppColors.textTertiary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // 금액 입력
              const Text(
                '금액',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                autofocus: true,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: '0',
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray300,
                  ),
                  suffixText: '원',
                  suffixStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
              
              // 기본 금액 힌트
              if (widget.expense.amount != null && widget.expense.amount! > 0) ...[
                const SizedBox(height: 8),
                Text(
                  '기본 금액: ${numberFormat.format(widget.expense.amount)}원',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
              const SizedBox(height: 28),
              
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
                    '가계부에 등록',
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
    );
  }
}

// ============================================
// 카테고리 수정 시트
// ============================================

/// 카테고리 수정 시트
class _EditCategorySheet extends ConsumerStatefulWidget {
  final CustomFixedCategoryModel category;
  final VoidCallback onSaved;

  const _EditCategorySheet({
    required this.category,
    required this.onSaved,
  });

  @override
  ConsumerState<_EditCategorySheet> createState() => _EditCategorySheetState();
}

class _EditCategorySheetState extends ConsumerState<_EditCategorySheet> {
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

    await ref.read(customFixedCategoryNotifierProvider.notifier).updateCategory(updated);
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
                  const SizedBox(height: 32),
                  
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
// 기본 카테고리 수정 시트
// ============================================

/// 기본 카테고리 수정 시트
class _EditDefaultCategorySheet extends ConsumerStatefulWidget {
  final FixedExpenseCategory category;
  final VoidCallback onSaved;

  const _EditDefaultCategorySheet({
    required this.category,
    required this.onSaved,
  });

  @override
  ConsumerState<_EditDefaultCategorySheet> createState() => _EditDefaultCategorySheetState();
}

class _EditDefaultCategorySheetState extends ConsumerState<_EditDefaultCategorySheet> {
  late TextEditingController _nameController;
  late int _selectedColorIndex;
  DefaultCategoryCustomization? _currentCustomization;

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
    final customization = await DefaultCategoryCustomizer.getCustomization(widget.category);
    final defaultName = widget.category.displayName;
    final defaultColor = 0xFF4CAF50;
    
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

    await DefaultCategoryCustomizer.setCustomization(
      widget.category,
      name,
      _colorPalette[_selectedColorIndex],
    );
    
    widget.onSaved();
  }

  Future<void> _resetToDefault() async {
    await DefaultCategoryCustomizer.removeCustomization(widget.category);
    widget.onSaved();
  }

  Future<void> _deleteCategory() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('카테고리 삭제'),
        content: Text(
          "'${widget.category.displayName}' 카테고리를 삭제하면 해당 카테고리를 사용하는 고정비도 함께 삭제됩니다.\n정말 삭제하시겠습니까?",
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
      // 해당 카테고리를 사용하는 고정비 삭제
      final fixedExpenses = ref.read(fixedExpenseNotifierProvider).valueOrNull ?? [];
      for (final expense in fixedExpenses) {
        if (expense.category == widget.category && expense.customCategoryId == null) {
          await ref.read(fixedExpenseNotifierProvider.notifier).deleteFixedExpense(expense.id);
        }
      }
      // 커스터마이징 정보도 삭제
      await DefaultCategoryCustomizer.removeCustomization(widget.category);
      if (context.mounted) {
        widget.onSaved();
      }
    }
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
                  
                  // 삭제 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: _deleteCategory,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        '카테고리 삭제',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
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
// 카테고리 관리 바텀 시트
// ============================================

/// 카테고리 관리 바텀 시트
class _CategoryManageSheet extends ConsumerStatefulWidget {
  final VoidCallback onCategoryAdded;
  final void Function(String uid) onCategoryDeleted;

  const _CategoryManageSheet({
    required this.onCategoryAdded,
    required this.onCategoryDeleted,
  });

  @override
  ConsumerState<_CategoryManageSheet> createState() => _CategoryManageSheetState();
}

class _CategoryManageSheetState extends ConsumerState<_CategoryManageSheet> {
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

    final category = CustomFixedCategoryModel.create(
      name: name,
      colorValue: _colorPalette[_selectedColorIndex],
      iconName: _selectedEmoji,
    );

    await ref.read(customFixedCategoryNotifierProvider.notifier).addCategory(category);
    widget.onCategoryAdded();
    if (context.mounted) {
      Navigator.pop(context);
    }
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

  Future<void> _deleteCategory(CustomFixedCategoryModel category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('카테고리 삭제'),
        content: Text("'${category.name}' 카테고리를 삭제하면 해당 카테고리를 사용하는 고정비도 함께 삭제됩니다.\n정말 삭제하시겠습니까?"),
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
      // 해당 카테고리를 사용하는 고정비 삭제
      final fixedExpenses = ref.read(fixedExpenseNotifierProvider).valueOrNull ?? [];
      for (final expense in fixedExpenses) {
        if (expense.customCategoryId == category.uid) {
          await ref.read(fixedExpenseNotifierProvider.notifier).deleteFixedExpense(expense.id);
        }
      }
      await ref.read(customFixedCategoryNotifierProvider.notifier).deleteCategory(category.uid);
      widget.onCategoryDeleted(category.uid);
    }
  }

  Future<void> _deleteDefaultCategory(FixedExpenseCategory category) async {
    final customization = await DefaultCategoryCustomizer.getCustomization(category);
    final categoryName = customization?.name ?? category.displayName;
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('카테고리 삭제'),
        content: Text(
          "'$categoryName' 카테고리를 삭제하면 해당 카테고리를 사용하는 고정비도 함께 삭제됩니다.\n정말 삭제하시겠습니까?",
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
      // 해당 카테고리를 사용하는 고정비 삭제
      final fixedExpenses = ref.read(fixedExpenseNotifierProvider).valueOrNull ?? [];
      for (final expense in fixedExpenses) {
        if (expense.category == category && expense.customCategoryId == null) {
          await ref.read(fixedExpenseNotifierProvider.notifier).deleteFixedExpense(expense.id);
        }
      }
      // 커스터마이징 정보도 삭제
      await DefaultCategoryCustomizer.removeCustomization(category);
      if (mounted) {
        ref.invalidate(fixedExpenseNotifierProvider);
      }
    }
  }

  void _showEditDefaultCategorySheet(FixedExpenseCategory category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditDefaultCategorySheet(
        category: category,
        onSaved: () {
          ref.invalidate(fixedExpenseNotifierProvider);
          setState(() {}); // 기본 카테고리 목록 새로고침
          if (context.mounted) Navigator.pop(context);
        },
      ),
    );
  }

  void _showEditCategorySheet(CustomFixedCategoryModel category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditCategorySheet(
        category: category,
        onSaved: () {
          if (context.mounted) Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(customFixedCategoryNotifierProvider);

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
                const Text(
                  '카테고리 관리',
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
            child: categoriesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('오류: $error')),
              data: (customCategories) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: FixedExpenseCategory.values.length + customCategories.length,
                  itemBuilder: (context, index) {
                    // 기본 카테고리 먼저 표시
                    if (index < FixedExpenseCategory.values.length) {
                      final category = FixedExpenseCategory.values[index];
                      return FutureBuilder<DefaultCategoryCustomization?>(
                        future: DefaultCategoryCustomizer.getCustomization(category),
                        builder: (context, snapshot) {
                          final customization = snapshot.data;
                          final displayName = customization?.name ?? category.displayName;
                          final colorValue = customization?.colorValue ?? 0xFF4CAF50;
                          
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
                                  color: AppColors.textSecondary,
                                  iconSize: 22,
                                  onPressed: () => _showEditDefaultCategorySheet(category),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  color: AppColors.error,
                                  iconSize: 22,
                                  onPressed: () => _deleteDefaultCategory(category),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    
                    // 사용자 정의 카테고리 표시
                    final category = customCategories[index - FixedExpenseCategory.values.length];
                    final isEmoji = category.iconName.isNotEmpty && 
                        !category.iconName.startsWith('Icons.') &&
                        category.iconName.length <= 2;
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
                                category.iconName,
                                style: const TextStyle(fontSize: 20),
                              ),
                            )
                          else
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color(category.colorValue),
                                shape: BoxShape.circle,
                              ),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            color: AppColors.textSecondary,
                            iconSize: 22,
                            onPressed: () => _showEditCategorySheet(category),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            color: AppColors.error,
                            iconSize: 22,
                            onPressed: () => _deleteCategory(category),
                          ),
                        ],
                      ),
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
