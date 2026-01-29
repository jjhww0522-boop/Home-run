import 'package:uuid/uuid.dart';

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

/// 고정비 모델 (웹용)
class FixedExpenseModel {
  int id = 0;
  late String uid;
  late String title;
  late FixedExpenseCategory category;
  String? customCategoryId;
  late int dueDate;
  late bool isVariableAmount;
  late bool isRecurringMonthly;
  int? amount;
  int? linkedAccountId;
  int? linkedPaymentMethodId;
  late bool isActive;
  late DateTime createdAt;
  late DateTime updatedAt;

  FixedExpenseModel();

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

  DateTime get thisMonthDueDate {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;
    final actualDay = dueDate > lastDayOfMonth ? lastDayOfMonth : dueDate;
    return DateTime(year, month, actualDay);
  }

  DateTime get nextMonthDueDate {
    final now = DateTime.now();
    final nextMonth = now.month == 12 
        ? DateTime(now.year + 1, 1, 1)
        : DateTime(now.year, now.month + 1, 1);
    final lastDayOfMonth = DateTime(nextMonth.year, nextMonth.month + 1, 0).day;
    final actualDay = dueDate > lastDayOfMonth ? lastDayOfMonth : dueDate;
    return DateTime(nextMonth.year, nextMonth.month, actualDay);
  }

  int get daysUntilDue {
    final due = thisMonthDueDate;
    final now = DateTime.now();
    final difference = due.difference(now).inDays;
    if (difference < 0) {
      final nextDue = nextMonthDueDate;
      return nextDue.difference(now).inDays;
    }
    return difference;
  }

  bool get isOverdue {
    final due = thisMonthDueDate;
    return DateTime.now().isAfter(due);
  }
}
