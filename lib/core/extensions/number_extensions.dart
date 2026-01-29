import '../utils/currency_formatter.dart';

/// 숫자 관련 확장 함수
extension IntExtensions on int {
  /// 원화 포맷 (예: 1,234,567원)
  String get toWon => CurrencyFormatter.formatWon(this);

  /// 숫자 포맷 (예: 1,234,567)
  String get toFormatted => CurrencyFormatter.formatNumber(this);

  /// 축약 포맷 (예: 1.2억원)
  String get toCompact => CurrencyFormatter.formatCompact(this);

  /// 만원 단위로 변환
  int get toManWon => this ~/ 10000;

  /// 억원 단위로 변환
  double get toEok => this / 100000000;
}

extension DoubleExtensions on double {
  /// 퍼센트 포맷 (예: 75.5%)
  String toPercent({int decimals = 1}) =>
      CurrencyFormatter.formatPercent(this, decimals: decimals);

  /// 소수점 자릿수 제한
  String toFixed(int fractionDigits) => toStringAsFixed(fractionDigits);
}
