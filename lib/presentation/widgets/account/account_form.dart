import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/models_stub.dart'
    if (dart.library.io) '../../../data/models/models.dart';

/// 계좌 입력/수정 폼 위젯
/// Material 3 디자인, Pretendard 폰트 적용
class AccountForm extends StatefulWidget {
  final AccountModel? initialAccount;
  final void Function(AccountModel account) onSave;
  final VoidCallback? onCancel;

  const AccountForm({
    super.key,
    this.initialAccount,
    required this.onSave,
    this.onCancel,
  });

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();

  late AccountType _selectedType;
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  final _institutionController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _monthlyPaymentController = TextEditingController();
  final _memoController = TextEditingController();

  DateTime? _maturityDate;
  DateTime? _startDate;
  int? _totalPayments;
  bool _showExpectedInterest = true;

  @override
  void initState() {
    super.initState();
    final account = widget.initialAccount;
    if (account != null) {
      _selectedType = account.type;
      _nameController.text = account.name;
      _balanceController.text = account.balance.toString();
      _institutionController.text = account.institution ?? '';
      _interestRateController.text = account.interestRate?.toString() ?? '';
      _monthlyPaymentController.text = account.monthlyPayment?.toString() ?? '';
      _memoController.text = account.memo ?? '';
      _maturityDate = account.maturityDate;
      _startDate = account.startDate;
      _totalPayments = account.totalPayments;
    } else {
      _selectedType = AccountType.checking;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _institutionController.dispose();
    _interestRateController.dispose();
    _monthlyPaymentController.dispose();
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
                    widget.initialAccount == null ? '계좌 추가하기' : '계좌 수정하기',
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
                    // 계좌 유형 선택
                    _buildAccountTypeSelector(),
                    const SizedBox(height: 32),

                    // 기본 정보
                    _buildSectionTitle('기본 정보'),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _nameController,
                      label: '계좌명',
                      hint: '예: 카카오뱅크 입출금',
                      icon: Icons.label_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '계좌명을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _institutionController,
                      label: '금융기관',
                      hint: '예: 카카오뱅크',
                      icon: Icons.account_balance_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildAmountField(
                      controller: _balanceController,
                      label: _selectedType == AccountType.deposit ? '예치금액' : '현재 잔액',
                      hint: '0',
                    ),

                    // 예적금/청약 전용 필드 (조건부 표시)
                    if (_selectedType.requiresMaturityDate) ...[
                      const SizedBox(height: 32),
                      _buildSectionTitle('예적금 정보'),
                      const SizedBox(height: 16),
                      _buildInterestRateField(),
                      const SizedBox(height: 16),
                      _buildDatePickerField(
                        label: '시작일',
                        value: _startDate,
                        onChanged: (date) => setState(() => _startDate = date),
                      ),
                      const SizedBox(height: 16),
                      _buildDatePickerField(
                        label: '만기일',
                        value: _maturityDate,
                        onChanged: (date) => setState(() => _maturityDate = date),
                      ),

                      // 적금/청약 전용 필드
                      if (_selectedType == AccountType.savings ||
                          _selectedType == AccountType.subscription) ...[
                        const SizedBox(height: 16),
                        _buildAmountField(
                          controller: _monthlyPaymentController,
                          label: '월 납입금',
                          hint: '0',
                        ),
                        // 적금만 총 납입 회차 표시 (청약은 제외)
                        if (_selectedType == AccountType.savings) ...[
                          const SizedBox(height: 16),
                          _buildTotalPaymentsSelector(),
                        ],
                      ],
                    ],

                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _memoController,
                      label: '메모',
                      hint: '메모를 입력하세요 (선택)',
                      icon: Icons.note_outlined,
                      maxLines: 2,
                    ),

                    // 예상 이자 표시 (예적금/청약인 경우)
                    if (_selectedType.requiresMaturityDate) ...[
                      const SizedBox(height: 32),
                      _buildExpectedInterestCard(),
                    ],

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

  Widget _buildAccountTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '계좌 유형',
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
            children: AccountType.values.map((type) {
              final isSelected = _selectedType == type;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _AccountTypeCard(
                  type: type,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() => _selectedType = type);
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

  Widget _buildInterestRateField() {
    return TextFormField(
      controller: _interestRateController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: '연 이자율',
        hintText: '0.00',
        prefixIcon: const Icon(Icons.percent_outlined, size: 22),
        suffixText: '%',
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

  Widget _buildDatePickerField({
    required String label,
    required DateTime? value,
    required void Function(DateTime?) onChanged,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          locale: const Locale('ko', 'KR'),
          helpText: '날짜를 선택해주세요',
          cancelText: '취소',
          confirmText: '확인',
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today_outlined, size: 22),
          suffixIcon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        child: Text(
          value != null
              ? '${value.year}.${value.month.toString().padLeft(2, '0')}.${value.day.toString().padLeft(2, '0')}'
              : '날짜를 선택하세요',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: value != null ? AppColors.textPrimary : AppColors.textTertiary,
          ),
        ),
      ),
    );
  }

  Widget _buildTotalPaymentsSelector() {
    final options = [6, 12, 24, 36, 60];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '총 납입 회차',
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
          children: options.map((months) {
            final isSelected = _totalPayments == months;
            return ChoiceChip(
              selected: isSelected,
              label: Text('$months개월'),
              labelStyle: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              selectedColor: AppColors.primary.withOpacity(0.12),
              backgroundColor: AppColors.surfaceVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 1.5,
                ),
              ),
              onSelected: (selected) {
                if (selected) {
                  setState(() => _totalPayments = months);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  /// 예상 이자 계산 (메모이제이션을 위해 별도 메서드로 분리)
  ({double? interest, double? total}) _calculateExpectedInterest() {
    final interestRate = double.tryParse(_interestRateController.text) ?? 0;
    if (interestRate <= 0) return (interest: null, total: null);

    final rate = interestRate / 100;
    final balance = int.tryParse(_balanceController.text.replaceAll(',', '')) ?? 0;
    final monthlyPayment = int.tryParse(
        _monthlyPaymentController.text.replaceAll(',', '')) ?? 0;

    if (_selectedType == AccountType.deposit &&
        _startDate != null &&
        _maturityDate != null &&
        balance > 0) {
      final months = _maturityDate!.difference(_startDate!).inDays / 30;
      final expectedInterest = balance * rate * (months / 12);
      final expectedTotal = balance + (expectedInterest * 0.846);
      return (interest: expectedInterest, total: expectedTotal);
    } else if (_selectedType == AccountType.savings &&
               _totalPayments != null &&
               monthlyPayment > 0) {
      final n = _totalPayments!;
      final expectedInterest = monthlyPayment * rate * (n * (n + 1) / 2) / 12;
      final totalPrincipal = monthlyPayment * n;
      final expectedTotal = totalPrincipal + (expectedInterest * 0.846);
      return (interest: expectedInterest, total: expectedTotal);
    } else if (_selectedType == AccountType.subscription &&
               monthlyPayment > 0 &&
               _startDate != null &&
               _maturityDate != null) {
      final months = _maturityDate!.difference(_startDate!).inDays / 30;
      final totalPrincipal = monthlyPayment * months;
      final expectedInterest = monthlyPayment * rate * (months * (months + 1) / 2) / 12;
      final expectedTotal = totalPrincipal + (expectedInterest * 0.846);
      return (interest: expectedInterest, total: expectedTotal);
    }

    return (interest: null, total: null);
  }

  Widget _buildExpectedInterestCard() {
    final calculation = _calculateExpectedInterest();
    final expectedInterest = calculation.interest;
    final expectedTotal = calculation.total;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // 헤더 (항상 표시)
          InkWell(
            onTap: () {
              setState(() => _showExpectedInterest = !_showExpectedInterest);
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.calculate_outlined,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      '예상 이자 계산',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Icon(
                    _showExpectedInterest
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          
          // 내용 (접기/펼치기)
          if (_showExpectedInterest) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (expectedInterest != null && expectedTotal != null) ...[
                    _buildInterestRow(
                      '예상 세전 이자',
                      CurrencyFormatter.format(expectedInterest.round()),
                    ),
                    const SizedBox(height: 12),
                    _buildInterestRow(
                      '예상 세후 이자 (15.4%)',
                      CurrencyFormatter.format((expectedInterest * 0.846).round()),
                    ),
                    const Divider(height: 24),
                    _buildInterestRow(
                      '만기 예상 총액',
                      CurrencyFormatter.format(expectedTotal.round()),
                      isBold: true,
                    ),
                  ] else
                    const Text(
                      '이자율과 기간을 입력하면 예상 이자가 계산됩니다.',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                        color: AppColors.textSecondary,
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

  Widget _buildInterestRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          '$value원',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: isBold ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (widget.onCancel != null) ...[
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
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _handleSave,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              '저장',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final account = AccountModel.create(
      uid: widget.initialAccount?.uid ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      type: _selectedType,
      balance: int.tryParse(_balanceController.text.replaceAll(',', '')) ?? 0,
      institution: _institutionController.text.isEmpty
          ? null
          : _institutionController.text,
      interestRate: double.tryParse(_interestRateController.text),
      maturityDate: _maturityDate,
      monthlyPayment: int.tryParse(
          _monthlyPaymentController.text.replaceAll(',', '')),
      startDate: _startDate,
      totalPayments: _totalPayments,
      memo: _memoController.text.isEmpty ? null : _memoController.text,
    );

    // 수정 시 기존 ID와 생성일 유지
    if (widget.initialAccount != null) {
      account.id = widget.initialAccount!.id;
      account.createdAt = widget.initialAccount!.createdAt;
    }

    widget.onSave(account);
  }
}

/// 계좌 유형 카드 위젯
class _AccountTypeCard extends StatelessWidget {
  final AccountType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _AccountTypeCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  IconData get _icon {
    switch (type) {
      case AccountType.checking:
        return Icons.account_balance_wallet_outlined;
      case AccountType.parking:
        return Icons.savings_outlined;
      case AccountType.deposit:
        return Icons.lock_clock_outlined;
      case AccountType.savings:
        return Icons.trending_up_outlined;
      case AccountType.subscription:
        return Icons.home_work_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.16)
                    : AppColors.gray200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _icon,
                size: 28,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
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
