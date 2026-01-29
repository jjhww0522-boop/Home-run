import 'package:isar/isar.dart';
import '../../models/fixed_expense_model.dart';
import 'isar_database.dart';
import 'interfaces/fixed_expense_local_datasource_interface.dart';

export 'interfaces/fixed_expense_local_datasource_interface.dart';
export '../../models/models.dart';

/// 고정비 로컬 데이터소스 구현체
class FixedExpenseLocalDataSourceImpl implements FixedExpenseLocalDataSource {
  Isar get _isar => IsarDatabase.instance;

  @override
  Future<List<FixedExpenseModel>> getAll() async {
    return await _isar.fixedExpenseModels
        .where()
        .sortByCreatedAtDesc()
        .findAll();
  }

  @override
  Future<List<FixedExpenseModel>> getActive() async {
    return await _isar.fixedExpenseModels
        .filter()
        .isActiveEqualTo(true)
        .sortByDueDate()
        .findAll();
  }

  @override
  Future<FixedExpenseModel?> getById(int id) async {
    return await _isar.fixedExpenseModels.get(id);
  }

  @override
  Future<FixedExpenseModel?> getByUid(String uid) async {
    return await _isar.fixedExpenseModels
        .filter()
        .uidEqualTo(uid)
        .findFirst();
  }

  @override
  Future<void> save(FixedExpenseModel fixedExpense) async {
    fixedExpense.updatedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.fixedExpenseModels.put(fixedExpense);
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.fixedExpenseModels.delete(id);
    });
  }

  @override
  Future<void> deleteByUid(String uid) async {
    await _isar.writeTxn(() async {
      await _isar.fixedExpenseModels
          .filter()
          .uidEqualTo(uid)
          .deleteFirst();
    });
  }
}
