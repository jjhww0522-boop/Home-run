import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';

/// 금액 입력 필드 위젯
class AmountInputField extends StatefulWidget {
  final int? initialValue;
  final ValueChanged<int> onChanged;
  final String? label;
  final Color? accentColor;

  const AmountInputField({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.label,
    this.accentColor,
  });

  @override
  State<AmountInputField> createState() => _AmountInputFieldState();
}

class _AmountInputFieldState extends State<AmountInputField> {
  late TextEditingController _controller;
  final _numberFormat = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue != null
          ? _numberFormat.format(widget.initialValue)
          : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    final cleanValue = value.replaceAll(',', '');
    final intValue = int.tryParse(cleanValue) ?? 0;

    // 포맷팅된 값으로 업데이트
    final formattedValue = intValue > 0 ? _numberFormat.format(intValue) : '';

    if (formattedValue != value) {
      _controller.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }

    widget.onChanged(intValue);
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.accentColor ?? AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: AppColors.ledgerSurfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: _onChanged,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: accentColor,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.textTertiary,
              ),
              suffixText: '원',
              suffixStyle: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: accentColor,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
