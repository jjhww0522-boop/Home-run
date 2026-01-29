/// 입력값 검증 유틸리티
class Validators {
  Validators._();

  /// 필수 입력값 검증
  static String? required(String? value, [String fieldName = '값']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName을(를) 입력해주세요.';
    }
    return null;
  }

  /// 금액 검증 (0보다 커야 함)
  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '금액을 입력해주세요.';
    }

    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
    final amount = int.tryParse(cleaned);

    if (amount == null) {
      return '올바른 금액을 입력해주세요.';
    }

    if (amount <= 0) {
      return '금액은 0보다 커야 합니다.';
    }

    return null;
  }

  /// 이자율 검증 (0~100 사이)
  static String? interestRate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '이자율을 입력해주세요.';
    }

    final rate = double.tryParse(value);

    if (rate == null) {
      return '올바른 이자율을 입력해주세요.';
    }

    if (rate < 0 || rate > 100) {
      return '이자율은 0~100 사이여야 합니다.';
    }

    return null;
  }

  /// 퍼센트 검증 (0~100 사이)
  static String? percentage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '퍼센트를 입력해주세요.';
    }

    final percent = double.tryParse(value);

    if (percent == null) {
      return '올바른 값을 입력해주세요.';
    }

    if (percent < 0 || percent > 100) {
      return '0~100 사이의 값을 입력해주세요.';
    }

    return null;
  }

  /// 이름 검증 (2자 이상)
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '이름을 입력해주세요.';
    }

    if (value.trim().length < 2) {
      return '이름은 2자 이상이어야 합니다.';
    }

    return null;
  }

  /// 날짜 검증 (미래 날짜)
  static String? futureDate(DateTime? date) {
    if (date == null) {
      return '날짜를 선택해주세요.';
    }

    if (date.isBefore(DateTime.now())) {
      return '미래 날짜를 선택해주세요.';
    }

    return null;
  }
}
