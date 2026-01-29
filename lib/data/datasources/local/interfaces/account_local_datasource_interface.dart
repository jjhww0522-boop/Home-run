import '../../../models/models_stub.dart'
    if (dart.library.io) '../../../models/models.dart';

/// 계좌 로컬 데이터소스 인터페이스
abstract class AccountLocalDataSource {
  Future<List<AccountModel>> getAll();
  Future<AccountModel?> getById(int id);
  Future<AccountModel?> getByUid(String uid);
  Future<void> save(AccountModel account);
  Future<void> delete(int id);
  Future<void> deleteAll();
}
