import 'package:isar/isar.dart';
import '../../models/account_model.dart';
import 'isar_database.dart';
import 'interfaces/account_local_datasource_interface.dart';

export 'interfaces/account_local_datasource_interface.dart';
export '../../models/models.dart';

/// 계좌 로컬 데이터소스 구현체
class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  Isar get _isar => IsarDatabase.instance;

  @override
  Future<List<AccountModel>> getAll() async {
    return await _isar.accountModels
        .where()
        .filter()
        .isActiveEqualTo(true)
        .sortBySortOrder()
        .findAll();
  }

  @override
  Future<AccountModel?> getById(int id) async {
    return await _isar.accountModels.get(id);
  }

  @override
  Future<AccountModel?> getByUid(String uid) async {
    return await _isar.accountModels.filter().uidEqualTo(uid).findFirst();
  }

  @override
  Future<void> save(AccountModel account) async {
    await _isar.writeTxn(() async {
      await _isar.accountModels.put(account);
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      final account = await _isar.accountModels.get(id);
      if (account != null) {
        account.isActive = false;
        account.updatedAt = DateTime.now();
        await _isar.accountModels.put(account);
      }
    });
  }

  @override
  Future<void> deleteAll() async {
    await _isar.writeTxn(() async {
      await _isar.accountModels.clear();
    });
  }
}
