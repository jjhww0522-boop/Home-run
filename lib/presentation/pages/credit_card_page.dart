import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';
import '../providers/ledger_provider.dart';
import '../widgets/account/credit_card_form.dart';
import 'ledger_page.dart';

/// 신용카드 관리 페이지
class CreditCardPage extends ConsumerStatefulWidget {
  const CreditCardPage({super.key});

  @override
  ConsumerState<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends ConsumerState<CreditCardPage> {
  bool _isModalOpen = false;

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(creditCardNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.ledgerBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          tooltip: '뒤로가기',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              // 이전 경로가 없으면 홈으로 이동
              context.go('/home');
            }
          },
        ),
        title: const Text(
          '카드 관리',
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
            icon: const Icon(Icons.account_balance_wallet),
            tooltip: '계좌 관리',
            onPressed: () {
              context.pushReplacement('/accounts');
            },
          ),
        ],
      ),
      body: cardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류: $error')),
        data: (cards) {
          if (cards.isEmpty) {
            return _EmptyState(
              onAdd: () => _showAddSheet(context, ref),
            );
          }

          // 타입별로 그룹화 (한 번만 계산)
          final groupedCards = _groupCardsByType(cards);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (groupedCards[CardType.credit]?.isNotEmpty ?? false)
                _CreditCardTypeSection(
                  title: '신용카드',
                  cards: groupedCards[CardType.credit]!,
                  onEdit: (c) => _showEditSheet(context, ref, c),
                  onDelete: (c) => _confirmDelete(context, ref, c),
                ),
              if (groupedCards[CardType.check]?.isNotEmpty ?? false)
                _CreditCardTypeSection(
                  title: '체크카드',
                  cards: groupedCards[CardType.check]!,
                  onEdit: (c) => _showEditSheet(context, ref, c),
                  onDelete: (c) => _confirmDelete(context, ref, c),
                ),
              if (groupedCards[CardType.localCurrency]?.isNotEmpty ?? false)
                _CreditCardTypeSection(
                  title: '지역화폐',
                  cards: groupedCards[CardType.localCurrency]!,
                  onEdit: (c) => _showEditSheet(context, ref, c),
                  onDelete: (c) => _confirmDelete(context, ref, c),
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
              label: const Text(
                '카드 추가',
                style: TextStyle(fontFamily: 'Pretendard'),
              ),
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
      builder: (context) => CreditCardForm(
        onSave: (card) async {
          await ref.read(creditCardNotifierProvider.notifier).addCreditCard(card);
          if (context.mounted) {
            Navigator.pop(context);
            setState(() => _isModalOpen = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('카드가 저장되었습니다')),
            );
          }
        },
        onCancel: () {
          Navigator.pop(context);
          if (mounted) {
            setState(() => _isModalOpen = false);
          }
        },
      ),
    ).whenComplete(() {
      if (mounted) {
        setState(() => _isModalOpen = false);
      }
    });
  }

  void _showEditSheet(BuildContext context, WidgetRef ref, CreditCardModel card) {
    setState(() => _isModalOpen = true);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (context) => CreditCardForm(
        initialCard: card,
        onSave: (updated) async {
          updated.id = card.id;
          updated.uid = card.uid; // 기존 uid 유지
          await ref.read(creditCardNotifierProvider.notifier).updateCreditCard(updated);
          if (context.mounted) {
            Navigator.pop(context);
            setState(() => _isModalOpen = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('카드가 수정되었습니다')),
            );
          }
        },
        onCancel: () {
          Navigator.pop(context);
          if (mounted) {
            setState(() => _isModalOpen = false);
          }
        },
      ),
    ).whenComplete(() {
      if (mounted) {
        setState(() => _isModalOpen = false);
      }
    });
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, CreditCardModel card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('${card.name} 카드를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(creditCardNotifierProvider.notifier).deleteCreditCard(card.id);
              Navigator.pop(context);
            },
            child: const Text('삭제', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  /// 카드를 타입별로 그룹화 (성능 최적화)
  Map<CardType, List<CreditCardModel>> _groupCardsByType(List<CreditCardModel> cards) {
    final grouped = <CardType, List<CreditCardModel>>{};
    for (final card in cards) {
      grouped.putIfAbsent(card.cardType, () => []).add(card);
    }
    return grouped;
  }
}

/// 신용카드 타입별 섹션 위젯 (재사용 및 성능 최적화)
class _CreditCardTypeSection extends StatelessWidget {
  final String title;
  final List<CreditCardModel> cards;
  final void Function(CreditCardModel) onEdit;
  final void Function(CreditCardModel) onDelete;

  const _CreditCardTypeSection({
    required this.title,
    required this.cards,
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
        ...cards.map((c) => _CreditCardCard(
              card: c,
              onEdit: () => onEdit(c),
              onDelete: () => onDelete(c),
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
            Icons.credit_card_outlined,
            size: 64,
            color: AppColors.gray400,
          ),
          const SizedBox(height: 16),
          const Text(
            '등록된 카드가 없습니다',
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
              '카드 추가하기',
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

/// 신용카드 카드 (성능 최적화: 계산된 값들을 미리 계산)
class _CreditCardCard extends StatelessWidget {
  final CreditCardModel card;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CreditCardCard({
    required this.card,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // 계산된 값들을 미리 계산 (성능 최적화)
    final achievementRate = card.achievementRate;
    final formattedTarget = CurrencyFormatter.format(card.targetAmount);
    final formattedUsage = CurrencyFormatter.format(card.currentUsage);
    final achievementRateStr = achievementRate.toStringAsFixed(1);
    final achievementColor = Color(card.achievementColorCode);

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
                      card.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: AppColors.error,
                    onPressed: onDelete,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                card.issuer,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.gray600,
                ),
              ),
              const SizedBox(height: 12),
              // 실적 달성률
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '목표 실적',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.gray600,
                    ),
                  ),
                  Text(
                    '$formattedTarget원',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '현재 사용액',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '$formattedUsage원',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 달성률 프로그레스 바
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: achievementRate / 100,
                  minHeight: 8,
                  backgroundColor: AppColors.gray200,
                  valueColor: AlwaysStoppedAnimation<Color>(achievementColor),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '달성률',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '$achievementRateStr%',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: achievementColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '결제일',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.gray600,
                    ),
                  ),
                  Text(
                    '매월 ${card.paymentDay}일',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
