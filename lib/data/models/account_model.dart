import 'package:isar/isar.dart';

part 'account_model.g.dart';

/// 계좌 유형
enum AccountType {
  checking,   // 입출금
  parking,    // 파킹
  deposit,    // 예금
  savings,    // 적금
  subscription, // 청약
}

/// 계좌 유형 확장
extension AccountTypeExtension on AccountType {
  String get displayName {
    switch (this) {
      case AccountType.checking:
        return '입출금';
      case AccountType.parking:
        return '파킹';
      case AccountType.deposit:
        return '예금';
      case AccountType.savings:
        return '적금';
      case AccountType.subscription:
        return '청약';
    }
  }

  String get description {
    switch (this) {
      case AccountType.checking:
        return '자유롭게 입출금이 가능한 계좌';
      case AccountType.parking:
        return '수시입출금 + 이자 혜택';
      case AccountType.deposit:
        return '목돈을 일정 기간 예치';
      case AccountType.savings:
        return '매월 일정 금액을 저축';
      case AccountType.subscription:
        return '주택청약종합저축';
    }
  }

  String get iconName {
    switch (this) {
      case AccountType.checking:
        return 'account_balance_wallet';
      case AccountType.parking:
        return 'savings';
      case AccountType.deposit:
        return 'lock_clock';
      case AccountType.savings:
        return 'trending_up';
      case AccountType.subscription:
        return 'home_work';
    }
  }

  /// 만기일이 필요한 유형인지 확인
  bool get requiresMaturityDate {
    return this == AccountType.deposit ||
           this == AccountType.savings ||
           this == AccountType.subscription;
  }
}

/// 계좌 모델 (Isar)
@collection
class AccountModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uid;

  /// 계좌명 (예: "카카오뱅크 입출금")
  late String name;

  /// 계좌 유형
  @Enumerated(EnumType.name)
  late AccountType type;

  /// 현재 잔액
  late int balance;

  /// 금융기관명
  String? institution;

  /// 계좌번호 (마스킹 처리)
  String? accountNumber;

  /// 이자율 (예적금/청약의 경우)
  double? interestRate;

  /// 만기일 (예적금/청약의 경우)
  DateTime? maturityDate;

  /// 월 납입금 (적금/청약의 경우)
  int? monthlyPayment;

  /// 시작일 (적금/청약의 경우)
  DateTime? startDate;

  /// 총 납입 회차 (적금/청약의 경우)
  int? totalPayments;

  /// 현재 납입 회차 (적금/청약의 경우)
  int? currentPayments;

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

  AccountModel();

  /// 간편 생성자
  factory AccountModel.create({
    required String uid,
    required String name,
    required AccountType type,
    int balance = 0,
    String? institution,
    String? accountNumber,
    double? interestRate,
    DateTime? maturityDate,
    int? monthlyPayment,
    DateTime? startDate,
    int? totalPayments,
    int? currentPayments,
    String? memo,
    int sortOrder = 0,
  }) {
    return AccountModel()
      ..uid = uid
      ..name = name
      ..type = type
      ..balance = balance
      ..institution = institution
      ..accountNumber = accountNumber
      ..interestRate = interestRate
      ..maturityDate = maturityDate
      ..monthlyPayment = monthlyPayment
      ..startDate = startDate
      ..totalPayments = totalPayments
      ..currentPayments = currentPayments
      ..memo = memo
      ..sortOrder = sortOrder
      ..isActive = true
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }

  // ========== Getters ==========

  /// 만기까지 남은 일수
  int? get daysUntilMaturity {
    if (maturityDate == null) return null;
    final now = DateTime.now();
    final difference = maturityDate!.difference(now).inDays;
    return difference > 0 ? difference : 0;
  }

  /// 만기 여부
  bool get isMatured {
    if (maturityDate == null) return false;
    return DateTime.now().isAfter(maturityDate!);
  }

  /// 예상 이자 (단리 기준)
  /// 예금: 원금 × 이자율 × (예치기간/12)
  /// 적금: 월납입금 × 이자율 × (n × (n+1) / 2) / 12 (단리 계산)
  double? get expectedInterest {
    if (interestRate == null || interestRate == 0) return null;

    final rate = interestRate! / 100; // 퍼센트를 소수로 변환

    switch (type) {
      case AccountType.deposit:
        // 예금: 단리 계산
        if (startDate == null || maturityDate == null) return null;
        final months = maturityDate!.difference(startDate!).inDays / 30;
        return balance * rate * (months / 12);

      case AccountType.savings:
      case AccountType.subscription:
        // 적금: 단리 계산 (월복리 아님)
        if (monthlyPayment == null || totalPayments == null) return null;
        final n = totalPayments!;
        // 적금 이자 = 월납입액 × 연이율 × (n × (n+1) / 2) / 12
        return monthlyPayment! * rate * (n * (n + 1) / 2) / 12;

      default:
        return null;
    }
  }

  /// 세후 예상 이자 (이자소득세 15.4% 적용)
  double? get expectedInterestAfterTax {
    final interest = expectedInterest;
    if (interest == null) return null;
    return interest * (1 - 0.154); // 15.4% 세금 공제
  }

  /// 만기 시 예상 총액
  double? get expectedTotalAtMaturity {
    final interest = expectedInterestAfterTax;
    if (interest == null) return null;

    switch (type) {
      case AccountType.deposit:
        return balance + interest;
      case AccountType.savings:
      case AccountType.subscription:
        if (monthlyPayment == null || totalPayments == null) return null;
        final totalPrincipal = monthlyPayment! * totalPayments!;
        return totalPrincipal + interest;
      default:
        return balance.toDouble();
    }
  }

  /// 진행률 (적금/청약의 경우)
  double? get progressRate {
    if (currentPayments == null || totalPayments == null || totalPayments == 0) {
      return null;
    }
    return (currentPayments! / totalPayments!) * 100;
  }
}
