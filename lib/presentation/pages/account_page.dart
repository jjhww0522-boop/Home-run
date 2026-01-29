import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';
import '../providers/ledger_provider.dart';
import '../widgets/account/account_form.dart';
import 'ledger_page.dart';

/// 계좌 관리 페이지
class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  bool _isModalOpen = false;

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.ledgerBackground,
      appBar: AppBar(
        title: const Text(
          '계좌 관리',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined),
            tooltip: '홈으로',
            onPressed: () {
              context.go('/home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined),
            tooltip: '가계부',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LedgerPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.credit_card),
            tooltip: '카드 관리',
            onPressed: () {
              context.pushReplacement('/credit-cards');
            },
          ),
        ],
      ),
      body: accountsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류: $error')),
        data: (accounts) {
          if (accounts.isEmpty) {
            return _EmptyState(
              onAdd: () => _showAddSheet(context, ref),
            );
          }

          // 타입별로 그룹화 (한 번만 계산)
          final groupedAccounts = _groupAccountsByType(accounts);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (groupedAccounts[AccountType.checking]?.isNotEmpty ?? false)
                _AccountTypeSection(
                  title: '입출금 계좌',
                  accounts: groupedAccounts[AccountType.checking]!,
                  onEdit: (a) => _showEditSheet(context, ref, a),
                  onDelete: (a) => _confirmDelete(context, ref, a),
                ),
              if (groupedAccounts[AccountType.parking]?.isNotEmpty ?? false)
                _AccountTypeSection(
                  title: '파킹 통장',
                  accounts: groupedAccounts[AccountType.parking]!,
                  onEdit: (a) => _showEditSheet(context, ref, a),
                  onDelete: (a) => _confirmDelete(context, ref, a),
                ),
              if (groupedAccounts[AccountType.deposit]?.isNotEmpty ?? false)
                _AccountTypeSection(
                  title: '예금',
                  accounts: groupedAccounts[AccountType.deposit]!,
                  onEdit: (a) => _showEditSheet(context, ref, a),
                  onDelete: (a) => _confirmDelete(context, ref, a),
                ),
              if (groupedAccounts[AccountType.savings]?.isNotEmpty ?? false)
                _AccountTypeSection(
                  title: '적금',
                  accounts: groupedAccounts[AccountType.savings]!,
                  onEdit: (a) => _showEditSheet(context, ref, a),
                  onDelete: (a) => _confirmDelete(context, ref, a),
                ),
              if (groupedAccounts[AccountType.subscription]?.isNotEmpty ?? false)
                _AccountTypeSection(
                  title: '청약',
                  accounts: groupedAccounts[AccountType.subscription]!,
                  onEdit: (a) => _showEditSheet(context, ref, a),
                  onDelete: (a) => _confirmDelete(context, ref, a),
                ),
            ],
          );
        },
      ),
      floatingActionButton: _isModalOpen
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _showAddSheet(context, ref),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('계좌 추가'),
            ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    setState(() => _isModalOpen = true);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => AccountForm(
        onSave: (account) async {
          await ref.read(accountNotifierProvider.notifier).addAccount(account);
          if (context.mounted) {
            Navigator.pop(context);
            setState(() => _isModalOpen = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('계좌가 저장되었습니다')),
            );
          }
        },
        onCancel: () {
          Navigator.pop(context);
          setState(() => _isModalOpen = false);
        },
      ),
    ).whenComplete(() {
      if (mounted) {
        setState(() => _isModalOpen = false);
      }
    });
  }

  void _showEditSheet(BuildContext context, WidgetRef ref, AccountModel account) {
    setState(() => _isModalOpen = true);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => AccountForm(
        initialAccount: account,
        onSave: (updated) async {
          // AccountForm에서 이미 id와 createdAt이 설정됨
          await ref.read(accountNotifierProvider.notifier).updateAccount(updated);
          if (context.mounted) {
            Navigator.pop(context);
            setState(() => _isModalOpen = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('계좌가 수정되었습니다')),
            );
          }
        },
        onCancel: () {
          Navigator.pop(context);
          setState(() => _isModalOpen = false);
        },
      ),
    ).whenComplete(() {
      if (mounted) {
        setState(() => _isModalOpen = false);
      }
    });
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, AccountModel account) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('${account.name} 계좌를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(accountNotifierProvider.notifier).deleteAccount(account.id);
              Navigator.pop(context);
            },
            child: const Text('삭제', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  /// 계좌를 타입별로 그룹화 (성능 최적화)
  Map<AccountType, List<AccountModel>> _groupAccountsByType(List<AccountModel> accounts) {
    final grouped = <AccountType, List<AccountModel>>{};
    for (final account in accounts) {
      grouped.putIfAbsent(account.type, () => []).add(account);
    }
    return grouped;
  }
}

/// 계좌 타입별 섹션 위젯 (재사용 및 성능 최적화)
class _AccountTypeSection extends StatelessWidget {
  final String title;
  final List<AccountModel> accounts;
  final void Function(AccountModel) onEdit;
  final void Function(AccountModel) onDelete;

  const _AccountTypeSection({
    required this.title,
    required this.accounts,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: title),
        const SizedBox(height: 8),
        ...accounts.map((a) => _AccountCard(
              account: a,
              onEdit: () => onEdit(a),
              onDelete: () => onDelete(a),
            )),
        const SizedBox(height: 16),
      ],
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
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: AppColors.gray400,
          ),
          const SizedBox(height: 16),
          const Text(
            '등록된 계좌가 없습니다',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onAdd,
            child: const Text(
              '계좌 추가하기',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 섹션 헤더
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.gray700,
      ),
    );
  }
}

/// 계좌 카드 (성능 최적화: 계산된 값들을 미리 계산)
class _AccountCard extends StatelessWidget {
  final AccountModel account;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AccountCard({
    required this.account,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // 계산된 값들을 미리 계산 (성능 최적화)
    final formattedBalance = CurrencyFormatter.format(account.balance);
    final maturityDateStr = account.maturityDate != null
        ? '${account.maturityDate!.year}.${account.maturityDate!.month.toString().padLeft(2, '0')}.${account.maturityDate!.day.toString().padLeft(2, '0')}'
        : null;
    final daysUntilMaturity = account.daysUntilMaturity;
    final formattedInterest = account.expectedInterestAfterTax != null
        ? CurrencyFormatter.format(account.expectedInterestAfterTax!.round())
        : null;
    final showMaturityInfo = account.type.requiresMaturityDate && account.maturityDate != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      account.name,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: AppColors.error,
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              if (account.institution != null) ...[
                const SizedBox(height: 4),
                Text(
                  account.institution!,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '잔액',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '$formattedBalance원',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              // 예적금 정보 표시
              if (showMaturityInfo) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '만기일',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      maturityDateStr!,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (daysUntilMaturity != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '만기까지',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${daysUntilMaturity}일',
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 13,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
                if (formattedInterest != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '예상 이자',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '$formattedInterest원',
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 13,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
