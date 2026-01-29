import 'package:isar/isar.dart';

part 'credit_card_model.g.dart';

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

/// 신용카드 모델 (Isar)
@collection
class CreditCardModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uid;

  /// 카드명 (예: "네이버 현대카드")
  late String name;

  /// 카드 유형
  @Enumerated(EnumType.name)
  late CardType cardType;

  /// 카드사
  late String issuer;

  /// 카드 번호 (마스킹: **** **** **** 1234)
  String? cardNumber;

  /// 결제일 (1~31)
  late int paymentDay;

  /// 목표 실적 금액
  late int targetAmount;

  /// 현재 사용액
  late int currentUsage;

  /// 연회비
  int? annualFee;

  /// 전월 실적 기준일 (예: 1이면 매월 1일~말일)
  int? billingCycleStartDay;

  /// 연결된 출금계좌 ID
  String? linkedAccountId;

  /// 메모
  String? memo;

  /// 정렬 순서
  late int sortOrder;

  /// 활성화 여부
  late bool isActive;

  /// 생성일
  late DateTime createdAt;

  /// 수정일
  late DateTime updatedAt;

  CreditCardModel();

  /// 간편 생성자
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

  // ========== Getters ==========

  /// 실적 달성률 (%)
  double get achievementRate {
    if (targetAmount <= 0) return 0.0;
    final rate = (currentUsage / targetAmount) * 100;
    return rate > 100 ? 100.0 : rate;
  }

  /// 목표 달성 여부
  bool get isTargetAchieved {
    return currentUsage >= targetAmount;
  }

  /// 목표까지 남은 금액
  int get remainingToTarget {
    final remaining = targetAmount - currentUsage;
    return remaining > 0 ? remaining : 0;
  }

  /// 다음 결제일
  DateTime get nextPaymentDate {
    final now = DateTime.now();
    var nextDate = DateTime(now.year, now.month, paymentDay);

    // 결제일이 이미 지났으면 다음 달로
    if (now.day >= paymentDay) {
      nextDate = DateTime(now.year, now.month + 1, paymentDay);
    }

    return nextDate;
  }

  /// 결제일까지 남은 일수
  int get daysUntilPayment {
    final now = DateTime.now();
    final nextDate = nextPaymentDate;
    return nextDate.difference(now).inDays;
  }

  /// 실적 달성 상태 텍스트
  String get achievementStatus {
    final rate = achievementRate;
    if (rate >= 100) return '달성 완료';
    if (rate >= 80) return '거의 달성';
    if (rate >= 50) return '절반 달성';
    if (rate >= 30) return '진행 중';
    return '시작 단계';
  }

  /// 실적 달성 상태 색상 코드
  int get achievementColorCode {
    final rate = achievementRate;
    if (rate >= 100) return 0xFF22C55E; // green
    if (rate >= 80) return 0xFF84CC16;  // lime
    if (rate >= 50) return 0xFFF59E0B;  // amber
    if (rate >= 30) return 0xFFF97316;  // orange
    return 0xFFEF4444; // red
  }
}

/// 카드사 브랜드 컬러
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
    return 0xFF6B7280; // 기본 회색
  }
}
