import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/local/fixed_expense_local_datasource_stub.dart'
    if (dart.library.io) '../../data/datasources/local/fixed_expense_local_datasource.dart';
import '../../data/datasources/local/custom_fixed_category_local_datasource_stub.dart';
import '../../data/services/fixed_expense_service.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';
import '../../data/datasources/local/interfaces/transaction_local_datasource_interface.dart';
import '../../data/datasources/local/transaction_local_datasource_stub.dart'
    if (dart.library.io) '../../data/datasources/local/transaction_local_datasource.dart';
import 'ledger_provider.dart';

part 'fixed_expense_provider.g.dart';

// ============================================
// 사용자 정의 고정비 카테고리 Provider
// ============================================

/// 사용자 정의 카테고리 데이터소스 Provider
@riverpod
CustomFixedCategoryLocalDataSource customFixedCategoryLocalDataSource(Ref ref) {
  return CustomFixedCategoryLocalDataSource();
}

/// 사용자 정의 카테고리 상태 관리 Notifier
@riverpod
class CustomFixedCategoryNotifier extends _$CustomFixedCategoryNotifier {
  @override
  Future<List<CustomFixedCategoryModel>> build() async {
    final dataSource = ref.watch(customFixedCategoryLocalDataSourceProvider);
    return dataSource.getActive();
  }

  /// 카테고리 추가
  Future<void> addCategory(CustomFixedCategoryModel category) async {
    final dataSource = ref.watch(customFixedCategoryLocalDataSourceProvider);
    // sortOrder 자동 설정
    final existing = await dataSource.getAll();
    category.sortOrder = existing.length;
    await dataSource.save(category);
    state = AsyncValue.data(await dataSource.getActive());
  }

  /// 카테고리 수정
  Future<void> updateCategory(CustomFixedCategoryModel category) async {
    final dataSource = ref.watch(customFixedCategoryLocalDataSourceProvider);
    await dataSource.save(category);
    state = AsyncValue.data(await dataSource.getActive());
  }

  /// 카테고리 삭제
  Future<void> deleteCategory(String uid) async {
    final dataSource = ref.watch(customFixedCategoryLocalDataSourceProvider);
    await dataSource.deleteByUid(uid);
    state = AsyncValue.data(await dataSource.getActive());
  }
}

/// 카테고리 uid로 이름 조회 Provider
@riverpod
Future<String?> customCategoryName(Ref ref, String uid) async {
  final categories = await ref.watch(customFixedCategoryNotifierProvider.future);
  try {
    final category = categories.firstWhere((c) => c.uid == uid);
    return category.name;
  } catch (e) {
    return null;
  }
}

/// 고정비 데이터소스 Provider
@riverpod
FixedExpenseLocalDataSource fixedExpenseLocalDataSource(Ref ref) {
  return FixedExpenseLocalDataSourceImpl();
}

/// 고정비 서비스 Provider
@riverpod
FixedExpenseService fixedExpenseService(Ref ref) {
  final fixedExpenseDataSource = ref.watch(fixedExpenseLocalDataSourceProvider);
  final transactionDataSource = ref.watch(transactionLocalDataSourceProvider);
  return FixedExpenseService(fixedExpenseDataSource, transactionDataSource);
}

/// 전체 고정비 목록 Provider
@riverpod
Future<List<FixedExpenseModel>> fixedExpenseList(Ref ref) async {
  ref.watch(fixedExpenseNotifierProvider);
  final dataSource = ref.watch(fixedExpenseLocalDataSourceProvider);
  return dataSource.getAll();
}

/// 활성 고정비 목록 Provider
@riverpod
Future<List<FixedExpenseModel>> activeFixedExpenseList(Ref ref) async {
  ref.watch(fixedExpenseNotifierProvider);
  final dataSource = ref.watch(fixedExpenseLocalDataSourceProvider);
  return dataSource.getActive();
}

/// 고정비 상태 관리 Notifier
@riverpod
class FixedExpenseNotifier extends _$FixedExpenseNotifier {
  @override
  Future<List<FixedExpenseModel>> build() async {
    final dataSource = ref.watch(fixedExpenseLocalDataSourceProvider);
    return dataSource.getAll();
  }

  /// 고정비 추가
  Future<void> addFixedExpense(FixedExpenseModel fixedExpense) async {
    final dataSource = ref.watch(fixedExpenseLocalDataSourceProvider);
    await dataSource.save(fixedExpense);
    state = AsyncValue.data(await dataSource.getAll());
  }

  /// 고정비 수정
  Future<void> updateFixedExpense(FixedExpenseModel fixedExpense) async {
    final dataSource = ref.watch(fixedExpenseLocalDataSourceProvider);
    await dataSource.save(fixedExpense);
    state = AsyncValue.data(await dataSource.getAll());
  }

  /// 고정비 삭제
  Future<void> deleteFixedExpense(int id) async {
    final dataSource = ref.watch(fixedExpenseLocalDataSourceProvider);
    await dataSource.delete(id);
    state = AsyncValue.data(await dataSource.getAll());
  }

  /// 고정비 삭제 (UID로)
  Future<void> deleteFixedExpenseByUid(String uid) async {
    final dataSource = ref.watch(fixedExpenseLocalDataSourceProvider);
    await dataSource.deleteByUid(uid);
    state = AsyncValue.data(await dataSource.getAll());
  }
}

/// 이번 달 결제일인 변동 고정비 목록 (내역 불러오기용)
@riverpod
Future<List<FixedExpenseModel>> variableFixedExpensesDueThisMonth(Ref ref) async {
  ref.watch(fixedExpenseNotifierProvider);
  final list = await ref.watch(activeFixedExpenseListProvider.future);
  final now = DateTime.now();
  final thisMonth = DateTime(now.year, now.month, 1);
  final nextMonth = DateTime(now.year, now.month + 1, 1);
  return list.where((e) {
    if (!e.isVariableAmount) return false;
    final due = e.thisMonthDueDate;
    return !due.isBefore(thisMonth) && due.isBefore(nextMonth);
  }).toList();
}

/// 이번 달 총 고정비 예상 금액 Provider
@riverpod
Future<int> totalExpectedFixedExpenseAmount(Ref ref) async {
  final service = ref.watch(fixedExpenseServiceProvider);
  return service.getTotalExpectedAmount();
}
