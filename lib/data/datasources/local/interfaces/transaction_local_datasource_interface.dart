import '../../../models/models_stub.dart'
    if (dart.library.io) '../../../models/models.dart';

/// 거래 로컬 데이터소스 인터페이스
abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getAll();
  Future<List<TransactionModel>> getByType(TransactionType type);
  Future<List<TransactionModel>> getByDateRange(DateTime start, DateTime end);
  Future<List<TransactionModel>> getByMonth(int year, int month);
  Future<TransactionModel?> getById(int id);
  Future<void> save(TransactionModel transaction);
  Future<void> delete(int id);
  Future<int> getTotalByType(TransactionType type, int year, int month);
  Future<List<TransactionModel>> getRecurringTransactions();
}
