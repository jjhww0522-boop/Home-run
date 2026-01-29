/// 문자열 관련 확장 함수
extension StringExtensions on String {
  /// 첫 글자 대문자
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// 빈 문자열 체크
  bool get isBlank => trim().isEmpty;

  /// 빈 문자열이 아닌지 체크
  bool get isNotBlank => trim().isNotEmpty;

  /// 숫자만 추출
  String get digitsOnly => replaceAll(RegExp(r'[^\d]'), '');

  /// 숫자로 변환 (콤마 등 제거)
  int? toInt() {
    final digits = digitsOnly;
    return digits.isEmpty ? null : int.tryParse(digits);
  }

  /// 금액 문자열을 int로 변환
  int? toAmount() => toInt();

  /// 말줄임 처리
  String ellipsis(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

extension NullableStringExtensions on String? {
  /// null이거나 빈 문자열인지 체크
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  /// null이 아니고 빈 문자열이 아닌지 체크
  bool get isNotNullOrBlank => this != null && this!.trim().isNotEmpty;

  /// null이면 기본값 반환
  String orDefault([String defaultValue = '']) => this ?? defaultValue;
}
