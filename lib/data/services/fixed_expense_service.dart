import 'package:uuid/uuid.dart';
import '../models/models_stub.dart'
    if (dart.library.io) '../models/models.dart';
import '../datasources/local/interfaces/fixed_expense_local_datasource_interface.dart';
import '../datasources/local/interfaces/transaction_local_datasource_interface.dart';

/// 고정비 자동 등록 서비스
class FixedExpenseService {
  final FixedExpenseLocalDataSource _fixedExpenseDataSource;
  final TransactionLocalDataSource _transactionDataSource;

  FixedExpenseService(
    this._fixedExpenseDataSource,
    this._transactionDataSource,
  );

  /// 이번 달 미등록 고정비 체크 및 자동 등록
  /// 앱 실행 시 호출
  Future<FixedExpenseRegistrationResult> registerMonthlyFixedExpenses() async {
    final activeFixedExpenses = await _fixedExpenseDataSource.getActive();
    final now = DateTime.now();
    final thisMonth = DateTime(now.year, now.month, 1);
    final nextMonth = DateTime(now.year, now.month + 1, 1);

    int autoRegisteredCount = 0;
    int pendingCount = 0;
    final pendingExpenses = <FixedExpenseModel>[];

    for (final fixedExpense in activeFixedExpenses) {
      // 결제일이 이번 달인지 확인
      final dueDate = fixedExpense.thisMonthDueDate;
      if (dueDate.isBefore(thisMonth) || dueDate.isAfter(nextMonth)) {
        continue;
      }

      // 이미 이번 달에 등록되었는지 확인
      final existingTransactions = await _transactionDataSource.getByMonth(
        now.year,
        now.month,
      );

      final alreadyRegistered = existingTransactions.any((t) =>
          t.type == TransactionType.expense &&
          t.description?.contains(fixedExpense.title) == true &&
          t.date.year == now.year &&
          t.date.month == now.month);

      if (alreadyRegistered) {
        continue;
      }

      final paymentMethodId = fixedExpense.linkedPaymentMethodId;

      // 변동 금액이면서 금액 미입력: 가계부에 넣지 않음
      if (fixedExpense.isVariableAmount &&
          (fixedExpense.amount == null || fixedExpense.amount! <= 0)) {
        pendingExpenses.add(fixedExpense);
        pendingCount++;
        continue;
      }

      // 고정/변동 모두 금액 있으면 즉시 가계부(소비) 반영
      if (fixedExpense.amount == null || fixedExpense.amount! <= 0) continue;

      final transaction = TransactionModel.expense(
        uid: const Uuid().v4(),
        date: dueDate,
        category: _mapCategoryToTransactionCategory(fixedExpense.category),
        description: fixedExpense.title,
        amount: fixedExpense.amount!,
        withdrawAccountId: paymentMethodId ?? 0,
      );
      transaction.isRecurring = true;

      await _transactionDataSource.save(transaction);
      autoRegisteredCount++;
    }

    return FixedExpenseRegistrationResult(
      autoRegisteredCount: autoRegisteredCount,
      pendingCount: pendingCount,
      pendingExpenses: pendingExpenses,
    );
  }

  /// 고정비 카테고리를 TransactionCategory로 매핑
  TransactionCategory _mapCategoryToTransactionCategory(
    FixedExpenseCategory category,
  ) {
    switch (category) {
      case FixedExpenseCategory.housing:
        return TransactionCategory.housing;
      case FixedExpenseCategory.communication:
        return TransactionCategory.housing; // 주거/통신
      case FixedExpenseCategory.insurance:
        return TransactionCategory.insurance;
      case FixedExpenseCategory.subscription:
        return TransactionCategory.culture; // 문화/여가
      case FixedExpenseCategory.etc:
        return TransactionCategory.otherExpense;
    }
  }

  /// 지난달 금액 가져오기 (Placeholder용)
  Future<int?> getLastMonthAmount(FixedExpenseModel fixedExpense) async {
    final t = await getLastMonthTransactionForVariable(fixedExpense);
    return t?.amount;
  }

  /// 변동 고정비용: 지난달 같은 내역(거래) 반환. 내역 불러오기 prefill용.
  Future<TransactionModel?> getLastMonthTransactionForVariable(
    FixedExpenseModel fixedExpense,
  ) async {
    final now = DateTime.now();
    final lastMonth = now.month == 1
        ? DateTime(now.year - 1, 12)
        : DateTime(now.year, now.month - 1);

    final transactions = await _transactionDataSource.getByMonth(
      lastMonth.year,
      lastMonth.month,
    );

    for (final t in transactions) {
      if (t.type != TransactionType.expense) continue;
      if (t.description == fixedExpense.title ||
          (t.description?.contains(fixedExpense.title) == true)) {
        return t;
      }
    }
    return null;
  }

  /// 고정비 저장 시 가계부 반영: 금액 있으면(고정/변동 무관) 이번 달 결제일일 때 소비 내역 1건 생성
  Future<bool> createTransactionForFixedExpense(
    FixedExpenseModel fixedExpense,
  ) async {
    if (fixedExpense.amount == null || fixedExpense.amount! <= 0) return false;

    final now = DateTime.now();
    final thisMonth = DateTime(now.year, now.month, 1);
    final nextMonth = DateTime(now.year, now.month + 1, 1);
    final dueDate = fixedExpense.thisMonthDueDate;
    if (dueDate.isBefore(thisMonth) || dueDate.isAfter(nextMonth)) {
      return false;
    }

    final existing = await _transactionDataSource.getByMonth(now.year, now.month);
    if (existing.any((t) =>
        t.type == TransactionType.expense &&
        t.description?.contains(fixedExpense.title) == true &&
        t.date.year == now.year &&
        t.date.month == now.month)) {
      return false;
    }

    final t = TransactionModel.expense(
      uid: const Uuid().v4(),
      date: dueDate,
      category: _mapCategoryToTransactionCategory(fixedExpense.category),
      description: fixedExpense.title,
      amount: fixedExpense.amount!,
      withdrawAccountId: fixedExpense.linkedPaymentMethodId ?? 0,
    );
    t.isRecurring = true;
    await _transactionDataSource.save(t);
    return true;
  }

  /// 이번 달 총 고정비 예상 금액 계산
  Future<int> getTotalExpectedAmount() async {
    final activeFixedExpenses = await _fixedExpenseDataSource.getActive();
    final now = DateTime.now();
    int total = 0;

    for (final fixedExpense in activeFixedExpenses) {
      final dueDate = fixedExpense.thisMonthDueDate;
      final thisMonth = DateTime(now.year, now.month, 1);
      final nextMonth = DateTime(now.year, now.month + 1, 1);

      // 이번 달 결제일인지 확인
      if (dueDate.isBefore(thisMonth) || dueDate.isAfter(nextMonth)) {
        continue;
      }

      if (fixedExpense.amount != null && fixedExpense.amount! > 0) {
        total += fixedExpense.amount!;
      } else if (fixedExpense.isVariableAmount) {
        final lastMonthAmount = await getLastMonthAmount(fixedExpense);
        if (lastMonthAmount != null) {
          total += lastMonthAmount;
        }
      }
    }

    return total;
  }
}

/// 고정비 등록 결과
class FixedExpenseRegistrationResult {
  final int autoRegisteredCount;
  final int pendingCount;
  final List<FixedExpenseModel> pendingExpenses;

  FixedExpenseRegistrationResult({
    required this.autoRegisteredCount,
    required this.pendingCount,
    required this.pendingExpenses,
  });
}
