import 'package:isar/isar.dart';
import '../../models/transaction_model.dart';
import 'isar_database.dart';
import 'interfaces/transaction_local_datasource_interface.dart';

export 'interfaces/transaction_local_datasource_interface.dart';
export '../../models/models.dart';

/// 거래 로컬 데이터소스 구현체
class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  Isar get _isar => IsarDatabase.instance;

  @override
  Future<List<TransactionModel>> getAll() async {
    return await _isar.transactionModels
        .where()
        .sortByDateDesc()
        .findAll();
  }

  @override
  Future<List<TransactionModel>> getByType(TransactionType type) async {
    return await _isar.transactionModels
        .filter()
        .typeEqualTo(type)
        .sortByDateDesc()
        .findAll();
  }

  @override
  Future<List<TransactionModel>> getByDateRange(DateTime start, DateTime end) async {
    return await _isar.transactionModels
        .filter()
        .dateBetween(start, end)
        .sortByDateDesc()
        .findAll();
  }

  @override
  Future<List<TransactionModel>> getByMonth(int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);
    return await getByDateRange(start, end);
  }

  @override
  Future<TransactionModel?> getById(int id) async {
    return await _isar.transactionModels.get(id);
  }

  @override
  Future<void> save(TransactionModel transaction) async {
    await _isar.writeTxn(() async {
      await _isar.transactionModels.put(transaction);
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.transactionModels.delete(id);
    });
  }

  @override
  Future<int> getTotalByType(TransactionType type, int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);

    final transactions = await _isar.transactionModels
        .filter()
        .typeEqualTo(type)
        .dateBetween(start, end)
        .findAll();

    return transactions.fold<int>(0, (sum, t) => sum + t.amount);
  }

  @override
  Future<List<TransactionModel>> getRecurringTransactions() async {
    return await _isar.transactionModels
        .filter()
        .isRecurringEqualTo(true)
        .findAll();
  }
}
