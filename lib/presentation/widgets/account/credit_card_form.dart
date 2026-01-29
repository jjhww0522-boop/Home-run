import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/models_stub.dart'
    if (dart.library.io) '../../../data/models/models.dart';
import '../../providers/ledger_provider.dart';

/// 신용카드 입력/수정 폼 위젯
/// Material 3 디자인, Pretendard 폰트 적용
class CreditCardForm extends ConsumerStatefulWidget {
  final CreditCardModel? initialCard;
  final void Function(CreditCardModel card) onSave;
  final VoidCallback? onCancel;

  const CreditCardForm({
    super.key,
    this.initialCard,
    required this.onSave,
    this.onCancel,
  });

  @override
  ConsumerState<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends ConsumerState<CreditCardForm> {
  final _formKey = GlobalKey<FormState>();

  late CardType _selectedCardType;
  final _nameController = TextEditingController();
  final _issuerController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _currentUsageController = TextEditingController();
  final _memoController = TextEditingController();

  int _paymentDay = 15;
  String? _selectedLinkedAccountId;

  @override
  void initState() {
    super.initState();
    final card = widget.initialCard;
    if (card != null) {
      _selectedCardType = card.cardType;
      _nameController.text = card.name;
      _issuerController.text = card.issuer;
      _targetAmountController.text = card.targetAmount.toString();
      _currentUsageController.text = card.currentUsage.toString();
      _memoController.text = card.memo ?? '';
      _paymentDay = card.paymentDay;
      _selectedLinkedAccountId = card.linkedAccountId;
    } else {
      _selectedCardType = CardType.credit;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _issuerController.dispose();
    _targetAmountController.dispose();
    _currentUsageController.dispose();
    _memoController.dispose();
    super.dispose();
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
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.gray300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // 헤더
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.initialCard == null ? '카드 추가하기' : '카드 수정하기',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                  ),
                ),
                if (widget.onCancel != null)
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 24),
                    color: AppColors.gray600,
                    onPressed: widget.onCancel,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ),

          // 폼 내용
          Flexible(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 카드 유형 선택
                    _buildCardTypeSelector(),
                    const SizedBox(height: 32),

                    // 기본 정보
                    _buildSectionTitle('기본 정보'),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _nameController,
                      label: '카드명',
                      hint: '예: 네이버 현대카드',
                      icon: Icons.label_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '카드명을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _issuerController,
                      label: '카드사',
                      hint: '예: 현대카드',
                      icon: Icons.account_balance_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '카드사를 입력해주세요';
                        }
                        return null;
                      },
                    ),

                    // 결제 정보 (신용카드만)
                    if (_selectedCardType == CardType.credit) ...[
                      const SizedBox(height: 32),
                      _buildSectionTitle('결제 정보'),
                      const SizedBox(height: 16),
                      _buildPaymentDaySelector(),
                    ],

                    // 결제계좌 설정 (신용카드/체크카드만)
                    if (_selectedCardType == CardType.credit || _selectedCardType == CardType.check) ...[
                      const SizedBox(height: 32),
                      _buildSectionTitle('결제계좌'),
                      const SizedBox(height: 16),
                      _buildLinkedAccountSelector(),
                    ],

                    const SizedBox(height: 32),
                    // 실적 관리
                    _buildSectionTitle('실적 관리'),
                    const SizedBox(height: 16),
                    _buildAmountField(
                      controller: _targetAmountController,
                      label: '목표 실적',
                      hint: '0',
                    ),
                    const SizedBox(height: 16),
                    _buildAmountField(
                      controller: _currentUsageController,
                      label: '현재 사용액',
                      hint: '0',
                    ),

                    // 실적 달성률 표시
                    const SizedBox(height: 16),
                    _buildAchievementCard(),

                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _memoController,
                      label: '메모',
                      hint: '메모를 입력하세요 (선택)',
                      icon: Icons.note_outlined,
                      maxLines: 2,
                    ),

                    const SizedBox(height: 24),
                    _buildActionButtons(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildCardTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '카드 유형',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: CardType.values.map((type) {
              final isSelected = _selectedCardType == type;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _CardTypeCard(
                  type: type,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() => _selectedCardType = type);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, size: 22) : null,
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    required String label,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _CurrencyInputFormatter(),
      ],
      onChanged: (_) => setState(() {}),
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.attach_money_rounded, size: 22),
        suffixText: '원',
        suffixStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildLinkedAccountSelector() {
    final accountsAsync = ref.watch(accountNotifierProvider);

    return accountsAsync.when(
      loading: () => const SizedBox(
        height: 56,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '계좌 목록을 불러올 수 없습니다',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            color: AppColors.error,
          ),
        ),
      ),
      data: (accounts) {
        // 입출금 계좌와 파킹 통장만 필터링
        final availableAccounts = accounts
            .where((a) => a.type == AccountType.checking || a.type == AccountType.parking)
            .toList();

        if (availableAccounts.isEmpty) {
          return Container(
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
                    '연결할 입출금 계좌가 없습니다.\n먼저 계좌를 등록해주세요.',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              isExpanded: true,
              value: _selectedLinkedAccountId,
              hint: const Text(
                '결제계좌 선택 (선택사항)',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  color: AppColors.textTertiary,
                ),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text(
                    '선택 안함',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                    ),
                  ),
                ),
                ...availableAccounts.map((account) => DropdownMenuItem(
                      value: account.uid,
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  account.name,
                                  style: const TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                if (account.institution != null)
                                  Text(
                                    account.institution!,
                                    style: const TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
              onChanged: (value) {
                setState(() => _selectedLinkedAccountId = value);
              },
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentDaySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '결제일',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [1, 5, 10, 12, 14, 15, 20, 25, 27].map((day) {
            final isSelected = _paymentDay == day;
            return ChoiceChip(
              selected: isSelected,
              label: Text('$day일'),
              labelStyle: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              selectedColor: AppColors.primary.withOpacity(0.12),
              backgroundColor: AppColors.surfaceVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (selected) {
                if (selected) {
                  setState(() => _paymentDay = day);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAchievementCard() {
    final targetAmount = int.tryParse(
        _targetAmountController.text.replaceAll(',', '')) ?? 0;
    final currentUsage = int.tryParse(
        _currentUsageController.text.replaceAll(',', '')) ?? 0;

    double achievementRate = 0;
    if (targetAmount > 0) {
      achievementRate = (currentUsage / targetAmount) * 100;
      if (achievementRate > 100) achievementRate = 100;
    }

    final remaining = targetAmount - currentUsage;
    final remainingText = remaining > 0
        ? '${CurrencyFormatter.format(remaining)}원 더 사용하면 달성!'
        : '목표 실적 달성 완료!';

    Color statusColor;
    String statusText;
    if (achievementRate >= 100) {
      statusColor = const Color(0xFF22C55E);
      statusText = '달성 완료';
    } else if (achievementRate >= 80) {
      statusColor = const Color(0xFF84CC16);
      statusText = '거의 달성';
    } else if (achievementRate >= 50) {
      statusColor = const Color(0xFFF59E0B);
      statusText = '절반 달성';
    } else if (achievementRate >= 30) {
      statusColor = const Color(0xFFF97316);
      statusText = '진행 중';
    } else {
      statusColor = const Color(0xFFEF4444);
      statusText = '시작 단계';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 20,
                    color: statusColor,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '실적 달성률',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: achievementRate / 100,
                    minHeight: 12,
                    backgroundColor: AppColors.gray200,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${achievementRate.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            remainingText,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (widget.onCancel != null)
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: widget.onCancel,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '취소',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        if (widget.onCancel != null) const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _handleSave,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '저장',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final card = CreditCardModel.create(
      uid: widget.initialCard?.uid ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      cardType: _selectedCardType,
      issuer: _issuerController.text,
      paymentDay: _selectedCardType == CardType.credit ? _paymentDay : 0,
      targetAmount: int.tryParse(
          _targetAmountController.text.replaceAll(',', '')) ?? 0,
      currentUsage: int.tryParse(
          _currentUsageController.text.replaceAll(',', '')) ?? 0,
      memo: _memoController.text.isEmpty ? null : _memoController.text,
      linkedAccountId: _selectedLinkedAccountId,
    );

    // 수정 시 기존 ID와 생성일 유지
    if (widget.initialCard != null) {
      card.id = widget.initialCard!.id;
      card.createdAt = widget.initialCard!.createdAt;
    }

    widget.onSave(card);
  }
}

/// 카드 유형 카드 위젯
class _CardTypeCard extends StatelessWidget {
  final CardType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _CardTypeCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  IconData _getIcon() {
    switch (type) {
      case CardType.credit:
        return Icons.credit_card;
      case CardType.check:
        return Icons.payment;
      case CardType.localCurrency:
        return Icons.local_atm;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.12)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIcon(),
              size: 32,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 8),
            Text(
              type.displayName,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 통화 형식 입력 포매터
class _CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final number = int.tryParse(newValue.text.replaceAll(',', ''));
    if (number == null) {
      return oldValue;
    }

    final formatted = CurrencyFormatter.format(number);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
