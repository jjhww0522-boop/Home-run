/// 카드 유형
enum CardType {
  credit,  // 신용카드
  check,   // 체크카드
  localCurrency,  // 지역화폐
}

/// 카드 유형 확장
extension CardTypeExtension on CardType {
  String get displayName {
    switch (this) {
      case CardType.credit:
        return '신용카드';
      case CardType.check:
        return '체크카드';
      case CardType.localCurrency:
        return '지역화폐';
    }
  }
}

/// 웹용 신용카드 모델
class CreditCardModel {
  int id = 0;

  late String uid;
  late String name;
  late CardType cardType;
  late String issuer;
  String? cardNumber;
  late int paymentDay;
  late int targetAmount;
  late int currentUsage;
  int? annualFee;
  int? billingCycleStartDay;
  String? linkedAccountId;
  String? memo;
  late int sortOrder;
  late bool isActive;
  late DateTime createdAt;
  late DateTime updatedAt;

  CreditCardModel();

  factory CreditCardModel.create({
    required String uid,
    required String name,
    required CardType cardType,
    required String issuer,
    String? cardNumber,
    required int paymentDay,
    int targetAmount = 0,
    int currentUsage = 0,
    int? annualFee,
    int? billingCycleStartDay,
    String? linkedAccountId,
    String? memo,
    int sortOrder = 0,
  }) {
    return CreditCardModel()
      ..uid = uid
      ..name = name
      ..cardType = cardType
      ..issuer = issuer
      ..cardNumber = cardNumber
      ..paymentDay = paymentDay
      ..targetAmount = targetAmount
      ..currentUsage = currentUsage
      ..annualFee = annualFee
      ..billingCycleStartDay = billingCycleStartDay
      ..linkedAccountId = linkedAccountId
      ..memo = memo
      ..sortOrder = sortOrder
      ..isActive = true
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }

  double get achievementRate {
    if (targetAmount <= 0) return 0.0;
    final rate = (currentUsage / targetAmount) * 100;
    return rate > 100 ? 100.0 : rate;
  }

  bool get isTargetAchieved {
    return currentUsage >= targetAmount;
  }

  int get remainingToTarget {
    final remaining = targetAmount - currentUsage;
    return remaining > 0 ? remaining : 0;
  }

  DateTime get nextPaymentDate {
    final now = DateTime.now();
    var nextDate = DateTime(now.year, now.month, paymentDay);
    if (now.day >= paymentDay) {
      nextDate = DateTime(now.year, now.month + 1, paymentDay);
    }
    return nextDate;
  }

  int get daysUntilPayment {
    final now = DateTime.now();
    final nextDate = nextPaymentDate;
    return nextDate.difference(now).inDays;
  }

  String get achievementStatus {
    final rate = achievementRate;
    if (rate >= 100) return '달성 완료';
    if (rate >= 80) return '거의 달성';
    if (rate >= 50) return '절반 달성';
    if (rate >= 30) return '진행 중';
    return '시작 단계';
  }

  int get achievementColorCode {
    final rate = achievementRate;
    if (rate >= 100) return 0xFF22C55E;
    if (rate >= 80) return 0xFF84CC16;
    if (rate >= 50) return 0xFFF59E0B;
    if (rate >= 30) return 0xFFF97316;
    return 0xFFEF4444;
  }
}

class CardIssuerColors {
  static const Map<String, int> brandColors = {
    '삼성': 0xFF0047BA,
    '현대': 0xFF003D7D,
    '롯데': 0xFFE60012,
    'BC': 0xFFE6007E,
    '비씨': 0xFFE6007E,
    '신한': 0xFF0046FF,
    '국민': 0xFF6B4F29,
    'KB': 0xFF6B4F29,
    '우리': 0xFF0066B3,
    '하나': 0xFF008C8C,
    '농협': 0xFF00923F,
    'NH': 0xFF00923F,
    '카카오뱅크': 0xFFFFE500,
    '토스뱅크': 0xFF0064FF,
  };

  static int getBrandColor(String issuer) {
    for (final entry in brandColors.entries) {
      if (issuer.contains(entry.key)) {
        return entry.value;
      }
    }
    return 0xFF6B7280;
  }
}
