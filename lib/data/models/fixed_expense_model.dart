import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'fixed_expense_model.g.dart';

/// 고정비 카테고리
enum FixedExpenseCategory {
  housing,        // 주거비 (대출이자/월세/관리비)
  communication,  // 통신비
  insurance,      // 보험료
  subscription,   // OTT/구독
  etc,            // 기타
}

/// FixedExpenseCategory 확장
extension FixedExpenseCategoryExtension on FixedExpenseCategory {
  String get displayName {
    switch (this) {
      case FixedExpenseCategory.housing:
        return '주거비';
      case FixedExpenseCategory.communication:
        return '통신비';
      case FixedExpenseCategory.insurance:
        return '보험료';
      case FixedExpenseCategory.subscription:
        return '구독';
      case FixedExpenseCategory.etc:
        return '기타';
    }
  }

  String get description {
    switch (this) {
      case FixedExpenseCategory.housing:
        return '대출이자, 월세, 관리비 등';
      case FixedExpenseCategory.communication:
        return '통신비';
      case FixedExpenseCategory.insurance:
        return '보험료';
      case FixedExpenseCategory.subscription:
        return 'OTT, 구독 서비스 등';
      case FixedExpenseCategory.etc:
        return '기타 고정비';
    }
  }
}

/// 고정비 모델
@collection
class FixedExpenseModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uid;

  /// 고정비 제목 (예: "관리비", "넷플릭스")
  late String title;

  /// 카테고리 (기본 카테고리 사용 시)
  @Enumerated(EnumType.name)
  late FixedExpenseCategory category;

  /// 사용자 정의 카테고리 ID (CustomFixedCategoryModel의 uid)
  /// 이 값이 있으면 사용자 정의 카테고리 사용, 없으면 기본 category 사용
  String? customCategoryId;

  /// 결제일 (매월 몇일, 1-31)
  @Index()
  late int dueDate;

  /// 변동 금액 여부 (true면 매달 금액이 달라짐)
  late bool isVariableAmount;

  /// 매월 해당일에 반복지불 여부 (체크 시 다음에 입력할 때 기존 내용 pre-fill)
  late bool isRecurringMonthly;

  /// 고정 금액 (isVariableAmount가 false일 때 사용)
  int? amount;

  /// 결제 계좌 연결 (AccountModel의 id)
  int? linkedAccountId;

  /// 결제 수단 연결 (PaymentMethodModel의 id)
  int? linkedPaymentMethodId;

  /// 활성화 여부
  @Index()
  late bool isActive;

  /// 생성일
  late DateTime createdAt;

  /// 수정일
  late DateTime updatedAt;

  FixedExpenseModel();

  /// 간편 생성자
  factory FixedExpenseModel.create({
    required String title,
    required FixedExpenseCategory category,
    String? customCategoryId,
    required int dueDate,
    bool isVariableAmount = false,
    bool isRecurringMonthly = false,
    int? amount,
    int? linkedAccountId,
    int? linkedPaymentMethodId,
    bool isActive = true,
  }) {
    return FixedExpenseModel()
      ..uid = const Uuid().v4()
      ..title = title
      ..category = category
      ..customCategoryId = customCategoryId
      ..dueDate = dueDate
      ..isVariableAmount = isVariableAmount
      ..isRecurringMonthly = isRecurringMonthly
      ..amount = amount
      ..linkedAccountId = linkedAccountId
      ..linkedPaymentMethodId = linkedPaymentMethodId
      ..isActive = isActive
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }

  /// 이번 달 결제일 계산
  DateTime get thisMonthDueDate {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;
    
    // 해당 월의 마지막 날짜 확인
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;
    final actualDay = dueDate > lastDayOfMonth ? lastDayOfMonth : dueDate;
    
    return DateTime(year, month, actualDay);
  }

  /// 다음 달 결제일 계산
  DateTime get nextMonthDueDate {
    final now = DateTime.now();
    final nextMonth = now.month == 12 
        ? DateTime(now.year + 1, 1, 1)
        : DateTime(now.year, now.month + 1, 1);
    
    final lastDayOfMonth = DateTime(nextMonth.year, nextMonth.month + 1, 0).day;
    final actualDay = dueDate > lastDayOfMonth ? lastDayOfMonth : dueDate;
    
    return DateTime(nextMonth.year, nextMonth.month, actualDay);
  }

  /// 결제일까지 남은 일수 (D-Day)
  int get daysUntilDue {
    final due = thisMonthDueDate;
    final now = DateTime.now();
    final difference = due.difference(now).inDays;
    
    // 이미 지난 경우 다음 달 결제일까지 계산
    if (difference < 0) {
      final nextDue = nextMonthDueDate;
      return nextDue.difference(now).inDays;
    }
    
    return difference;
  }

  /// 결제일이 지났는지 여부
  bool get isOverdue {
    final due = thisMonthDueDate;
    return DateTime.now().isAfter(due);
  }
}
