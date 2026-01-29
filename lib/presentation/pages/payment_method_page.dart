import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';
import '../providers/ledger_provider.dart';

/// 결제 수단 관리 페이지
class PaymentMethodPage extends ConsumerWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethodsAsync = ref.watch(paymentMethodNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.ledgerBackground,
      appBar: AppBar(
        title: const Text(
          '계좌/카드 관리',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          paymentMethodsAsync.whenOrNull(
            data: (methods) => methods.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_sweep, color: AppColors.error),
                    tooltip: '전체 삭제',
                    onPressed: () => _confirmDeleteAll(context, ref),
                  )
                : null,
          ) ?? const SizedBox.shrink(),
        ],
      ),
      body: paymentMethodsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류: $error')),
        data: (paymentMethods) {
          if (paymentMethods.isEmpty) {
            return _EmptyState(
              onAdd: () => _showAddSheet(context, ref),
            );
          }

          // 타입별로 그룹화
          final bankAccounts = paymentMethods
              .where((m) => m.type == PaymentMethodType.bankAccount)
              .toList();
          final creditCards = paymentMethods
              .where((m) => m.type == PaymentMethodType.creditCard)
              .toList();
          final debitCards = paymentMethods
              .where((m) => m.type == PaymentMethodType.debitCard)
              .toList();
          final cash = paymentMethods
              .where((m) => m.type == PaymentMethodType.cash)
              .toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (bankAccounts.isNotEmpty) ...[
                _SectionHeader(title: '은행 계좌'),
                const SizedBox(height: 8),
                ...bankAccounts.map((m) => _PaymentMethodCard(
                      method: m,
                      onEdit: () => _showEditSheet(context, ref, m),
                      onDelete: () => _confirmDelete(context, ref, m),
                    )),
                const SizedBox(height: 16),
              ],
              if (creditCards.isNotEmpty) ...[
                _SectionHeader(title: '신용카드'),
                const SizedBox(height: 8),
                ...creditCards.map((m) => _PaymentMethodCard(
                      method: m,
                      onEdit: () => _showEditSheet(context, ref, m),
                      onDelete: () => _confirmDelete(context, ref, m),
                    )),
                const SizedBox(height: 16),
              ],
              if (debitCards.isNotEmpty) ...[
                _SectionHeader(title: '체크카드'),
                const SizedBox(height: 8),
                ...debitCards.map((m) => _PaymentMethodCard(
                      method: m,
                      onEdit: () => _showEditSheet(context, ref, m),
                      onDelete: () => _confirmDelete(context, ref, m),
                    )),
                const SizedBox(height: 16),
              ],
              if (cash.isNotEmpty) ...[
                _SectionHeader(title: '현금'),
                const SizedBox(height: 8),
                ...cash.map((m) => _PaymentMethodCard(
                      method: m,
                      onEdit: () => _showEditSheet(context, ref, m),
                      onDelete: () => _confirmDelete(context, ref, m),
                    )),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context, ref),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('계좌/카드 추가'),
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddEditPaymentMethodSheet(
        onSaved: (method) {
          ref.read(paymentMethodNotifierProvider.notifier).addPaymentMethod(method);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showEditSheet(BuildContext context, WidgetRef ref, PaymentMethodModel method) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddEditPaymentMethodSheet(
        method: method,
        onSaved: (updated) {
          ref.read(paymentMethodNotifierProvider.notifier).updatePaymentMethod(updated);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, PaymentMethodModel method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('${method.name}을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(paymentMethodNotifierProvider.notifier).deletePaymentMethod(method.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAll(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.error),
            SizedBox(width: 8),
            Text('전체 삭제'),
          ],
        ),
        content: const Text(
          '등록된 모든 결제 수단을 삭제하시겠습니까?\n\n삭제 후 직접 통장과 카드를 다시 등록해주세요.',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(paymentMethodNotifierProvider.notifier).deleteAllPaymentMethods();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('모든 결제 수단이 삭제되었습니다'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('전체 삭제'),
          ),
        ],
      ),
    );
  }
}

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
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          const Text(
            '등록된 계좌/카드가 없습니다',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '계좌나 카드를 추가해주세요',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('계좌/카드 추가'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class _PaymentMethodCard extends ConsumerWidget {
  final PaymentMethodModel method;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _PaymentMethodCard({
    required this.method,
    required this.onEdit,
    required this.onDelete,
  });

  IconData get _icon {
    switch (method.type) {
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

  Color get _iconColor {
    switch (method.type) {
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

  /// 연결된 계좌 이름 가져오기
  String? _getLinkedAccountName(List<PaymentMethodModel> allMethods) {
    if (method.linkedAccountId == null) return null;
    final account = allMethods.where((m) => m.uid == method.linkedAccountId).firstOrNull;
    return account?.name;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethodsAsync = ref.watch(paymentMethodNotifierProvider);
    final linkedAccountName = paymentMethodsAsync.whenOrNull(
      data: (methods) => _getLinkedAccountName(methods),
    );

    // 서브타이틀 구성
    String? subtitle;
    if (method.linkedAccountId != null && linkedAccountName != null) {
      subtitle = '출금: $linkedAccountName${method.memo != null ? ' · ${method.memo}' : ''}';
    } else {
      subtitle = method.memo;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(_icon, color: _iconColor, size: 22),
        ),
        title: Text(
          method.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              )
            : null,
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: AppColors.textTertiary),
          onSelected: (value) {
            if (value == 'edit') onEdit();
            if (value == 'delete') onDelete();
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text('수정'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20, color: AppColors.error),
                  SizedBox(width: 8),
                  Text('삭제', style: TextStyle(color: AppColors.error)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 결제 수단 추가/수정 바텀시트
class _AddEditPaymentMethodSheet extends ConsumerStatefulWidget {
  final PaymentMethodModel? method;
  final ValueChanged<PaymentMethodModel> onSaved;

  const _AddEditPaymentMethodSheet({
    this.method,
    required this.onSaved,
  });

  @override
  ConsumerState<_AddEditPaymentMethodSheet> createState() => _AddEditPaymentMethodSheetState();
}

class _AddEditPaymentMethodSheetState extends ConsumerState<_AddEditPaymentMethodSheet> {
  late TextEditingController _nameController;
  late TextEditingController _memoController;
  PaymentMethodType _selectedType = PaymentMethodType.bankAccount;
  String? _selectedAccountId;
  List<PaymentMethodModel> _bankAccounts = [];

  bool get _isEditing => widget.method != null;

  /// 카드 타입인지 확인 (출금계좌 필요)
  bool get _needsLinkedAccount =>
      _selectedType == PaymentMethodType.creditCard ||
      _selectedType == PaymentMethodType.debitCard;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.method?.name ?? '');
    _memoController = TextEditingController(text: widget.method?.memo ?? '');
    if (widget.method != null) {
      _selectedType = widget.method!.type;
      _selectedAccountId = widget.method!.linkedAccountId;
    }
    _loadBankAccounts();
  }

  void _loadBankAccounts() {
    final paymentMethodsAsync = ref.read(paymentMethodNotifierProvider);
    paymentMethodsAsync.whenData((methods) {
      setState(() {
        _bankAccounts = methods
            .where((m) => m.type == PaymentMethodType.bankAccount)
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이름을 입력해주세요')),
      );
      return;
    }

    final now = DateTime.now();
    final method = widget.method ?? PaymentMethodModel();

    if (!_isEditing) {
      method.uid = DateTime.now().millisecondsSinceEpoch.toString();
      method.createdAt = now;
      method.sortOrder = 0;
      method.balance = 0;
      method.isActive = true;
    }

    method.name = name;
    method.type = _selectedType;
    method.memo = _memoController.text.trim().isEmpty ? null : _memoController.text.trim();
    method.linkedAccountId = _needsLinkedAccount ? _selectedAccountId : null;
    method.updatedAt = now;

    widget.onSaved(method);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  _isEditing ? '계좌/카드 수정' : '계좌/카드 추가',
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
                  // 타입 선택
                  const Text(
                    '유형',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: PaymentMethodType.values.map((type) {
                      final isSelected = _selectedType == type;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedType = type),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getTypeIcon(type),
                                size: 18,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textSecondary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _getTypeName(type),
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
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // 이름 입력
                  const Text(
                    '이름',
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
                      hintText: _getHintText(),
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 메모 입력
                  const Text(
                    '메모 (선택)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _memoController,
                    decoration: InputDecoration(
                      hintText: '예: 급여통장, 생활비 카드',
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  // 출금계좌 선택 (신용카드/체크카드 전용)
                  if (_needsLinkedAccount) ...[
                    const SizedBox(height: 24),
                    const Text(
                      '출금계좌',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_bankAccounts.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.textTertiary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '연결할 은행 계좌가 없습니다.\n먼저 은행 계좌를 등록해주세요.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String?>(
                            isExpanded: true,
                            value: _selectedAccountId,
                            hint: const Text('출금계좌 선택'),
                            items: [
                              const DropdownMenuItem<String?>(
                                value: null,
                                child: Text('선택 안함'),
                              ),
                              ..._bankAccounts.map((account) => DropdownMenuItem(
                                    value: account.uid,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.account_balance,
                                          size: 18,
                                          color: AppColors.info,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(account.name),
                                      ],
                                    ),
                                  )),
                            ],
                            onChanged: (value) {
                              setState(() => _selectedAccountId = value);
                            },
                          ),
                        ),
                      ),
                  ],
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
                      child: Text(
                        _isEditing ? '수정' : '추가',
                        style: const TextStyle(
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

  String _getTypeName(PaymentMethodType type) {
    switch (type) {
      case PaymentMethodType.bankAccount:
        return '은행 계좌';
      case PaymentMethodType.creditCard:
        return '신용카드';
      case PaymentMethodType.debitCard:
        return '체크카드';
      case PaymentMethodType.cash:
        return '현금';
    }
  }

  String _getHintText() {
    switch (_selectedType) {
      case PaymentMethodType.bankAccount:
        return '예: 우리은행, KB국민은행';
      case PaymentMethodType.creditCard:
        return '예: 삼성카드, 현대카드';
      case PaymentMethodType.debitCard:
        return '예: 카카오뱅크 체크카드';
      case PaymentMethodType.cash:
        return '예: 지갑, 비상금';
    }
  }
}
