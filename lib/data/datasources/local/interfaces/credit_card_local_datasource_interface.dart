import '../../../models/models_stub.dart'
    if (dart.library.io) '../../../models/models.dart';

/// 신용카드 로컬 데이터소스 인터페이스
abstract class CreditCardLocalDataSource {
  Future<List<CreditCardModel>> getAll();
  Future<CreditCardModel?> getById(int id);
  Future<CreditCardModel?> getByUid(String uid);
  Future<void> save(CreditCardModel card);
  Future<void> delete(int id);
  Future<void> deleteAll();
}
