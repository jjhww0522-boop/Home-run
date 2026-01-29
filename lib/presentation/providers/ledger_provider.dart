import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../data/datasources/local/transaction_local_datasource_stub.dart'
    if (dart.library.io) '../../data/datasources/local/transaction_local_datasource.dart';
import '../../data/datasources/local/payment_method_local_datasource_stub.dart'
    if (dart.library.io) '../../data/datasources/local/payment_method_local_datasource.dart';
import '../../data/datasources/local/account_local_datasource_stub.dart'
    if (dart.library.io) '../../data/datasources/local/account_local_datasource.dart';
import '../../data/datasources/local/credit_card_local_datasource_stub.dart'
    if (dart.library.io) '../../data/datasources/local/credit_card_local_datasource.dart';
import '../../data/datasources/local/custom_transaction_category_local_datasource_stub.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';
import '../../data/services/recurring_transaction_service.dart';

part 'ledger_provider.g.dart';

/// 소득 추가 이벤트 상태 (통장 쪼개기 유도용)
class IncomeAddedEvent {
  final int amount;
  final DateTime date;
  final int? depositAccountId;
  final DateTime timestamp;

  IncomeAddedEvent({
    required this.amount,
    required this.date,
    this.depositAccountId,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// 소득 추가 이벤트 Provider - 통장 쪼개기 연계용
@riverpod
class IncomeAddedNotifier extends _$IncomeAddedNotifier {
  @override
  IncomeAddedEvent? build() => null;

  /// 소득 추가 이벤트 발행
  void emitIncomeAdded({
    required int amount,
    required DateTime date,
    int? depositAccountId,
  }) {
    state = IncomeAddedEvent(
      amount: amount,
      date: date,
      depositAccountId: depositAccountId,
    );
  }

  /// 이벤트 소비 (SnackBar 표시 후 호출)
  void clearEvent() {
    state = null;
  }
}

/// 거래 데이터소스 Provider
@riverpod
TransactionLocalDataSource transactionLocalDataSource(Ref ref) {
  return TransactionLocalDataSourceImpl();
}

/// 결제 수단 데이터소스 Provider
@riverpod
PaymentMethodLocalDataSource paymentMethodLocalDataSource(Ref ref) {
  return PaymentMethodLocalDataSourceImpl();
}

/// 계좌 데이터소스 Provider
@riverpod
AccountLocalDataSource accountLocalDataSource(Ref ref) {
  return AccountLocalDataSourceImpl();
}

/// 신용카드 데이터소스 Provider
@riverpod
CreditCardLocalDataSource creditCardLocalDataSource(Ref ref) {
  return CreditCardLocalDataSourceImpl();
}

/// 반복 거래 서비스 Provider
@riverpod
RecurringTransactionService recurringTransactionService(Ref ref) {
  final dataSource = ref.watch(transactionLocalDataSourceProvider);
  return RecurringTransactionService(dataSource);
}

/// 전체 거래 목록 Provider
@riverpod
Future<List<TransactionModel>> transactionList(Ref ref) async {
  // transactionNotifierProvider를 watch하여 변경 시 자동 갱신
  ref.watch(transactionNotifierProvider);
  final dataSource = ref.watch(transactionLocalDataSourceProvider);
  return dataSource.getAll();
}

/// 타입별 거래 목록 Provider
@riverpod
Future<List<TransactionModel>> transactionsByType(
  Ref ref,
  TransactionType type,
) async {
  // transactionNotifierProvider를 watch하여 변경 시 자동 갱신
  ref.watch(transactionNotifierProvider);
  final dataSource = ref.watch(transactionLocalDataSourceProvider);
  return dataSource.getByType(type);
}

/// 월별 거래 목록 Provider
@riverpod
Future<List<TransactionModel>> transactionsByMonth(
  Ref ref, {
  required int year,
  required int month,
}) async {
  final dataSource = ref.watch(transactionLocalDataSourceProvider);
  return dataSource.getByMonth(year, month);
}

/// 결제 수단 목록 Provider
@riverpod
Future<List<PaymentMethodModel>> paymentMethodList(Ref ref) async {
  final dataSource = ref.watch(paymentMethodLocalDataSourceProvider);
  return dataSource.getAll();
}

/// 지난달 고정 지출 카테고리 (주거/통신, 금융)
const _fixedExpenseCategories = [
  TransactionCategory.housing,
  TransactionCategory.financial,
];

/// 지난달 고정 지출 Provider
@riverpod
Future<List<TransactionModel>> lastMonthFixedExpenses(Ref ref) async {
  final dataSource = ref.watch(transactionLocalDataSourceProvider);
  final now = DateTime.now();
  final lastMonth = now.month == 1
      ? DateTime(now.year - 1, 12)
      : DateTime(now.year, now.month - 1);

  final transactions = await dataSource.getByMonth(lastMonth.year, lastMonth.month);

  return transactions
      .where((t) =>
          t.type == TransactionType.expense &&
          _fixedExpenseCategories.contains(t.category))
      .toList();
}

/// 결제 수단별 필터 상태 Provider
@riverpod
class PaymentMethodFilter extends _$PaymentMethodFilter {
  @override
  int? build() => null; // null = 전체 보기

  void setFilter(int? paymentMethodId) {
    state = paymentMethodId;
  }

  void clearFilter() {
    state = null;
  }
}

// ============================================
// 사용자 정의 거래 카테고리 Provider
// ============================================

/// 사용자 정의 거래 카테고리 데이터소스 Provider
@riverpod
CustomTransactionCategoryLocalDataSource customTransactionCategoryLocalDataSource(Ref ref) {
  return CustomTransactionCategoryLocalDataSource();
}

/// 사용자 정의 거래 카테고리 상태 관리 Notifier
@riverpod
class CustomTransactionCategoryNotifier extends _$CustomTransactionCategoryNotifier {
  @override
  Future<List<CustomTransactionCategoryModel>> build() async {
    final dataSource = ref.watch(customTransactionCategoryLocalDataSourceProvider);
    return dataSource.getActive();
  }

  /// 카테고리 추가
  Future<void> addCategory(CustomTransactionCategoryModel category) async {
    final dataSource = ref.watch(customTransactionCategoryLocalDataSourceProvider);
    // sortOrder 자동 설정
    final existing = await dataSource.getByType(category.transactionType);
    category.sortOrder = existing.length;
    await dataSource.save(category);
    state = AsyncValue.data(await dataSource.getActive());
  }

  /// 카테고리 수정
  Future<void> updateCategory(CustomTransactionCategoryModel category) async {
    final dataSource = ref.watch(customTransactionCategoryLocalDataSourceProvider);
    await dataSource.save(category);
    state = AsyncValue.data(await dataSource.getActive());
  }

  /// 카테고리 삭제
  Future<void> deleteCategory(String uid) async {
    final dataSource = ref.watch(customTransactionCategoryLocalDataSourceProvider);
    await dataSource.deleteByUid(uid);
    state = AsyncValue.data(await dataSource.getActive());
  }
}

/// 타입별 사용자 정의 카테고리 목록 Provider
@riverpod
Future<List<CustomTransactionCategoryModel>> customTransactionCategoriesByType(
  Ref ref,
  TransactionType type,
) async {
  final dataSource = ref.watch(customTransactionCategoryLocalDataSourceProvider);
  return dataSource.getByType(type);
}

// ============================================
// 가계부 연월 선택 Provider
// ============================================

/// 선택된 연월 상태 클래스
class SelectedYearMonth {
  final int year;
  final int month;

  SelectedYearMonth({required this.year, required this.month});

  /// 현재 연월로 생성
  factory SelectedYearMonth.now() {
    final now = DateTime.now();
    return SelectedYearMonth(year: now.year, month: now.month);
  }

  /// 이전 달
  SelectedYearMonth get previousMonth {
    if (month == 1) {
      return SelectedYearMonth(year: year - 1, month: 12);
    }
    return SelectedYearMonth(year: year, month: month - 1);
  }

  /// 다음 달
  SelectedYearMonth get nextMonth {
    if (month == 12) {
      return SelectedYearMonth(year: year + 1, month: 1);
    }
    return SelectedYearMonth(year: year, month: month + 1);
  }

  /// 현재 달인지 확인
  bool get isCurrentMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// 미래 달인지 확인
  bool get isFutureMonth {
    final now = DateTime.now();
    if (year > now.year) return true;
    if (year == now.year && month > now.month) return true;
    return false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedYearMonth &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          month == other.month;

  @override
  int get hashCode => year.hashCode ^ month.hashCode;
}

/// 가계부 연월 선택 Notifier
@riverpod
class SelectedYearMonthNotifier extends _$SelectedYearMonthNotifier {
  @override
  SelectedYearMonth build() => SelectedYearMonth.now();

  /// 이전 달로 이동
  void previousMonth() {
    state = state.previousMonth;
  }

  /// 다음 달로 이동
  void nextMonth() {
    // 미래 달로는 이동하지 않음
    if (!state.nextMonth.isFutureMonth) {
      state = state.nextMonth;
    }
  }

  /// 특정 연월로 설정
  void setYearMonth(int year, int month) {
    final newState = SelectedYearMonth(year: year, month: month);
    // 미래 달로는 설정하지 않음
    if (!newState.isFutureMonth) {
      state = newState;
    }
  }

  /// 현재 달로 리셋
  void resetToNow() {
    state = SelectedYearMonth.now();
  }
}

/// 필터링된 거래 목록 Provider (선택된 연월 + 결제수단 필터)
@riverpod
Future<List<TransactionModel>> filteredTransactionsByType(
  Ref ref,
  TransactionType type,
) async {
  final transactions = await ref.watch(transactionsByTypeProvider(type).future);
  final filterId = ref.watch(paymentMethodFilterProvider);
  final selectedYearMonth = ref.watch(selectedYearMonthNotifierProvider);

  // 먼저 선택된 연월로 필터링
  var filtered = transactions.where((t) =>
      t.date.year == selectedYearMonth.year &&
      t.date.month == selectedYearMonth.month).toList();

  // 결제수단 필터 적용
  if (filterId != null) {
    filtered = filtered.where((t) {
      if (type == TransactionType.income) {
        return t.depositAccountId == filterId;
      } else {
        return t.withdrawAccountId == filterId;
      }
    }).toList();
  }

  return filtered;
}

/// 결제 수단별 이번 달 사용금액 Provider
@riverpod
Future<Map<int, int>> paymentMethodMonthlyUsage(Ref ref) async {
  // transactionNotifierProvider를 watch하여 변경 시 자동 갱신
  ref.watch(transactionNotifierProvider);
  final dataSource = ref.watch(transactionLocalDataSourceProvider);
  final now = DateTime.now();
  final transactions = await dataSource.getByMonth(now.year, now.month);

  final usage = <int, int>{};
  for (final t in transactions) {
    if (t.type == TransactionType.expense && t.withdrawAccountId != null) {
      usage[t.withdrawAccountId!] = (usage[t.withdrawAccountId!] ?? 0) + t.amount;
    }
  }

  return usage;
}

/// 거래 관리 Notifier
@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  @override
  Future<List<TransactionModel>> build() async {
    final dataSource = ref.watch(transactionLocalDataSourceProvider);
    final recurringService = ref.watch(recurringTransactionServiceProvider);

    // 반복 거래 자동 생성 체크
    await recurringService.generateRecurringTransactions();

    return dataSource.getAll();
  }

  /// 거래 추가
  /// [emitIncomeEvent] - 소득 추가 시 통장 쪼개기 유도 이벤트 발행 여부
  Future<void> addTransaction(
    TransactionModel transaction, {
    bool emitIncomeEvent = true,
  }) async {
    final dataSource = ref.read(transactionLocalDataSourceProvider);
    transaction.uid = const Uuid().v4();
    transaction.createdAt = DateTime.now();
    transaction.updatedAt = DateTime.now();
    await dataSource.save(transaction);

    // 소득 추가 시 통장 쪼개기 유도 이벤트 발행
    if (emitIncomeEvent && transaction.type == TransactionType.income) {
      ref.read(incomeAddedNotifierProvider.notifier).emitIncomeAdded(
            amount: transaction.amount,
            date: transaction.date,
            depositAccountId: transaction.depositAccountId,
          );
    }

    ref.invalidateSelf();
  }

  /// 거래 수정
  Future<void> updateTransaction(TransactionModel transaction) async {
    final dataSource = ref.read(transactionLocalDataSourceProvider);
    transaction.updatedAt = DateTime.now();
    await dataSource.save(transaction);
    ref.invalidateSelf();
  }

  /// 거래 삭제
  Future<void> deleteTransaction(int id) async {
    final dataSource = ref.read(transactionLocalDataSourceProvider);
    await dataSource.delete(id);
    ref.invalidateSelf();
  }

  /// 거래 복사 (즐겨찾기/템플릿 용도)
  Future<void> copyTransaction(TransactionModel original, DateTime newDate) async {
    final dataSource = ref.read(transactionLocalDataSourceProvider);

    final newTransaction = TransactionModel()
      ..uid = const Uuid().v4()
      ..date = newDate
      ..type = original.type
      ..category = original.category
      ..subcategory = original.subcategory
      ..description = original.description
      ..amount = original.amount
      ..depositAccountId = original.depositAccountId
      ..withdrawAccountId = original.withdrawAccountId
      ..isRecurring = false
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await dataSource.save(newTransaction);
    ref.invalidateSelf();
  }
}

/// 결제 수단 관리 Notifier
@riverpod
class PaymentMethodNotifier extends _$PaymentMethodNotifier {
  @override
  Future<List<PaymentMethodModel>> build() async {
    final dataSource = ref.watch(paymentMethodLocalDataSourceProvider);
    // 기본 결제 수단 초기화
    await dataSource.initializeDefaultMethods();
    return dataSource.getAll();
  }

  /// 결제 수단 추가
  Future<void> addPaymentMethod(PaymentMethodModel method) async {
    final dataSource = ref.read(paymentMethodLocalDataSourceProvider);
    method.uid = const Uuid().v4();
    method.createdAt = DateTime.now();
    method.updatedAt = DateTime.now();
    await dataSource.save(method);
    ref.invalidateSelf();
  }

  /// 결제 수단 수정
  Future<void> updatePaymentMethod(PaymentMethodModel method) async {
    final dataSource = ref.read(paymentMethodLocalDataSourceProvider);
    method.updatedAt = DateTime.now();
    await dataSource.save(method);
    ref.invalidateSelf();
  }

  /// 결제 수단 삭제
  Future<void> deletePaymentMethod(int id) async {
    final dataSource = ref.read(paymentMethodLocalDataSourceProvider);
    await dataSource.delete(id);
    ref.invalidateSelf();
  }

  /// 모든 결제 수단 삭제
  Future<void> deleteAllPaymentMethods() async {
    final dataSource = ref.read(paymentMethodLocalDataSourceProvider);
    await dataSource.deleteAll();
    ref.invalidateSelf();
  }
}

/// 계좌 관리 Notifier
@riverpod
class AccountNotifier extends _$AccountNotifier {
  @override
  Future<List<AccountModel>> build() async {
    final dataSource = ref.watch(accountLocalDataSourceProvider);
    return dataSource.getAll();
  }

  /// 계좌 추가
  Future<void> addAccount(AccountModel account) async {
    final accountDataSource = ref.read(accountLocalDataSourceProvider);
    final paymentMethodDataSource = ref.read(paymentMethodLocalDataSourceProvider);
    final now = DateTime.now();
    account.uid = const Uuid().v4();
    account.createdAt = now;
    account.updatedAt = now;
    await accountDataSource.save(account);

    // PaymentMethod로도 자동 연동 (입출금 계좌만)
    // Account의 uid를 참조하여 연결
    if (account.type == AccountType.checking || account.type == AccountType.parking) {
      final paymentMethod = PaymentMethodModel.create(
        uid: account.uid, // Account의 uid를 사용하여 연결
        name: account.name,
        type: PaymentMethodType.bankAccount,
        balance: account.balance,
        memo: account.memo,
      );
      await paymentMethodDataSource.save(paymentMethod);
      ref.invalidate(paymentMethodNotifierProvider);
    }

    ref.invalidateSelf();
  }

  /// 계좌 수정
  Future<void> updateAccount(AccountModel account) async {
    final dataSource = ref.read(accountLocalDataSourceProvider);
    account.updatedAt = DateTime.now();
    await dataSource.save(account);
    ref.invalidateSelf();
  }

  /// 계좌 삭제
  Future<void> deleteAccount(int id) async {
    final accountDataSource = ref.read(accountLocalDataSourceProvider);
    final paymentMethodDataSource = ref.read(paymentMethodLocalDataSourceProvider);
    
    // 계좌 정보 가져오기
    final account = await accountDataSource.getById(id);
    if (account == null) return;

    // 계좌 삭제
    await accountDataSource.delete(id);

    // 연관된 PaymentMethod도 삭제 (uid로 찾아서 삭제)
    if (account.type == AccountType.checking || account.type == AccountType.parking) {
      final paymentMethods = await paymentMethodDataSource.getAll();
      try {
        final linkedPaymentMethod = paymentMethods.firstWhere(
          (pm) => pm.uid == account.uid,
        );
        if (linkedPaymentMethod.id != 0) {
          await paymentMethodDataSource.delete(linkedPaymentMethod.id);
          ref.invalidate(paymentMethodNotifierProvider);
        }
      } catch (e) {
        // PaymentMethod가 없을 수도 있음
      }
    }

    ref.invalidateSelf();
  }

  /// 모든 계좌 삭제
  Future<void> deleteAllAccounts() async {
    final dataSource = ref.read(accountLocalDataSourceProvider);
    await dataSource.deleteAll();
    ref.invalidateSelf();
  }
}

/// 신용카드 관리 Notifier
@riverpod
class CreditCardNotifier extends _$CreditCardNotifier {
  @override
  Future<List<CreditCardModel>> build() async {
    final dataSource = ref.watch(creditCardLocalDataSourceProvider);
    return dataSource.getAll();
  }

  /// 신용카드 추가
  Future<void> addCreditCard(CreditCardModel card) async {
    final cardDataSource = ref.read(creditCardLocalDataSourceProvider);
    final paymentMethodDataSource = ref.read(paymentMethodLocalDataSourceProvider);
    final now = DateTime.now();
    card.uid = const Uuid().v4();
    card.createdAt = now;
    card.updatedAt = now;
    await cardDataSource.save(card);

    // PaymentMethod로도 자동 연동
    PaymentMethodType? paymentMethodType;
    if (card.cardType == CardType.credit) {
      paymentMethodType = PaymentMethodType.creditCard;
    } else if (card.cardType == CardType.check) {
      paymentMethodType = PaymentMethodType.debitCard;
    }
    // 지역화폐는 PaymentMethod에 연동하지 않음

    if (paymentMethodType != null) {
      final paymentMethod = PaymentMethodModel.create(
        uid: card.uid, // CreditCard의 uid를 사용하여 연결
        name: card.name,
        type: paymentMethodType,
        balance: card.currentUsage,
        memo: card.memo,
        linkedAccountId: card.linkedAccountId,
      );
      await paymentMethodDataSource.save(paymentMethod);
      ref.invalidate(paymentMethodNotifierProvider);
    }

    ref.invalidateSelf();
  }

  /// 신용카드 수정
  Future<void> updateCreditCard(CreditCardModel card) async {
    final dataSource = ref.read(creditCardLocalDataSourceProvider);
    card.updatedAt = DateTime.now();
    await dataSource.save(card);
    ref.invalidateSelf();
  }

  /// 신용카드 삭제
  Future<void> deleteCreditCard(int id) async {
    final cardDataSource = ref.read(creditCardLocalDataSourceProvider);
    final paymentMethodDataSource = ref.read(paymentMethodLocalDataSourceProvider);
    
    // 카드 정보 가져오기
    final card = await cardDataSource.getById(id);
    if (card == null) return;

    // 카드 삭제
    await cardDataSource.delete(id);

    // 연관된 PaymentMethod도 삭제 (uid로 찾아서 삭제)
    if (card.cardType == CardType.credit || card.cardType == CardType.check) {
      final paymentMethods = await paymentMethodDataSource.getAll();
      try {
        final linkedPaymentMethod = paymentMethods.firstWhere(
          (pm) => pm.uid == card.uid,
        );
        if (linkedPaymentMethod.id != 0) {
          await paymentMethodDataSource.delete(linkedPaymentMethod.id);
          ref.invalidate(paymentMethodNotifierProvider);
        }
      } catch (e) {
        // PaymentMethod가 없을 수도 있음 (지역화폐 등)
      }
    }

    ref.invalidateSelf();
  }

  /// 모든 신용카드 삭제
  Future<void> deleteAllCreditCards() async {
    final dataSource = ref.read(creditCardLocalDataSourceProvider);
    await dataSource.deleteAll();
    ref.invalidateSelf();
  }
}
