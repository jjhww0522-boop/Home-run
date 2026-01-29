import 'package:intl/intl.dart';

/// 금액 포맷팅 유틸리티
class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _wonFormat = NumberFormat('#,###', 'ko_KR');
  static final NumberFormat _compactFormat = NumberFormat.compact(locale: 'ko_KR');

  /// 원화 포맷 (예: 1,234,567원)
  static String formatWon(int amount) {
    return '${_wonFormat.format(amount)}원';
  }

  /// 원화 포맷 (단위 없이, 예: 1,234,567)
  static String formatNumber(int amount) {
    return _wonFormat.format(amount);
  }

  /// 원화 포맷 (단위 없이, 예: 1,234,567) - formatNumber의 alias
  static String format(int amount) {
    return _wonFormat.format(amount);
  }

  /// 축약 포맷 (예: 1.2억, 5,000만)
  static String formatCompact(int amount) {
    if (amount >= 100000000) {
      // 1억 이상
      double billions = amount / 100000000;
      if (billions == billions.truncate()) {
        return '${billions.truncate()}억원';
      }
      return '${billions.toStringAsFixed(1)}억원';
    } else if (amount >= 10000000) {
      // 1000만 이상
      double tenMillions = amount / 10000000;
      if (tenMillions == tenMillions.truncate()) {
        return '${tenMillions.truncate()},000만원';
      }
      return '${(amount / 10000).truncate().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}만원';
    } else if (amount >= 10000) {
      // 1만 이상
      return '${_wonFormat.format(amount ~/ 10000)}만원';
    }
    return formatWon(amount);
  }

  /// 퍼센트 포맷 (예: 75.5%)
  static String formatPercent(double value, {int decimals = 1}) {
    return '${value.toStringAsFixed(decimals)}%';
  }

  /// 문자열을 숫자로 변환 (콤마 제거)
  static int? parseWon(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(cleaned);
  }
}
