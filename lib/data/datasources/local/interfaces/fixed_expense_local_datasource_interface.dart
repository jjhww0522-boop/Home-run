import '../../../models/models_stub.dart'
    if (dart.library.io) '../../../models/models.dart';

/// 고정비 로컬 데이터소스 인터페이스
abstract class FixedExpenseLocalDataSource {
  Future<List<FixedExpenseModel>> getAll();
  Future<List<FixedExpenseModel>> getActive();
  Future<FixedExpenseModel?> getById(int id);
  Future<FixedExpenseModel?> getByUid(String uid);
  Future<void> save(FixedExpenseModel fixedExpense);
  Future<void> delete(int id);
  Future<void> deleteByUid(String uid);
}
