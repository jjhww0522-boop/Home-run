/// 결제 수단 유형
enum PaymentMethodType {
  bankAccount, // 은행 계좌
  creditCard, // 신용카드
  debitCard, // 체크카드
  cash, // 현금
}

/// 결제 수단 모델 (웹용)
class PaymentMethodModel {
  int id = 0;

  late String uid;

  /// 이름 (예: 우리은행, 네이버 현대카드)
  late String name;

  /// 유형 (계좌/신용카드/체크카드)
  late PaymentMethodType type;

  /// 잔액 (계좌/체크카드) 또는 사용액 (신용카드)
  late int balance;

  /// 메모 (예: 급여통장, 대출통장)
  String? memo;

  /// 연결된 출금계좌 ID (신용카드/체크카드의 경우)
  String? linkedAccountId;

  /// 정렬 순서
  late int sortOrder;

  /// 활성화 여부
  late bool isActive;

  /// 생성일
  late DateTime createdAt;

  /// 수정일
  late DateTime updatedAt;

  PaymentMethodModel();

  /// 간편 생성자
  factory PaymentMethodModel.create({
    required String uid,
    required String name,
    required PaymentMethodType type,
    int balance = 0,
    String? memo,
    String? linkedAccountId,
    int sortOrder = 0,
  }) {
    return PaymentMethodModel()
      ..uid = uid
      ..name = name
      ..type = type
      ..balance = balance
      ..memo = memo
      ..linkedAccountId = linkedAccountId
      ..sortOrder = sortOrder
      ..isActive = true
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }
}

/// PaymentMethodType 확장
extension PaymentMethodTypeExtension on PaymentMethodType {
  String get displayName {
    switch (this) {
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

  String get iconName {
    switch (this) {
      case PaymentMethodType.bankAccount:
        return 'account_balance';
      case PaymentMethodType.creditCard:
        return 'credit_card';
      case PaymentMethodType.debitCard:
        return 'payment';
      case PaymentMethodType.cash:
        return 'payments';
    }
  }
}

/// 브랜드 컬러 매핑 (은행/카드사)
class PaymentMethodColors {
  static const Map<String, int> brandColors = {
    // 은행
    '우리': 0xFF0066B3,
    '국민': 0xFF6B4F29,
    'KB': 0xFF6B4F29,
    '신한': 0xFF0046FF,
    '하나': 0xFF008C8C,
    '농협': 0xFF00923F,
    'NH': 0xFF00923F,
    '기업': 0xFF005BAC,
    'IBK': 0xFF005BAC,
    '카카오': 0xFFFFE500,
    '토스': 0xFF0064FF,
    '케이': 0xFFFF6600,
    '새마을': 0xFF005BAC,
    'MG': 0xFF005BAC,
    '수협': 0xFF0072CE,
    // 카드사
    '삼성': 0xFF0047BA,
    '현대': 0xFF003D7D,
    '롯데': 0xFFE60012,
    'BC': 0xFFE6007E,
    '비씨': 0xFFE6007E,
    '네이버': 0xFF03C75A,
    '카카오페이': 0xFFFFE500,
    '페이코': 0xFFE8001C,
    '토스페이': 0xFF0064FF,
  };

  static int getBrandColor(String name) {
    for (final entry in brandColors.entries) {
      if (name.contains(entry.key)) {
        return entry.value;
      }
    }
    // 기본 색상
    return 0xFF6B7280;
  }

  static bool isLightColor(int colorValue) {
    final r = (colorValue >> 16) & 0xFF;
    final g = (colorValue >> 8) & 0xFF;
    final b = colorValue & 0xFF;
    final luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255;
    return luminance > 0.5;
  }
}
