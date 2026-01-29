import 'package:isar/isar.dart';
import '../../models/credit_card_model.dart';
import 'isar_database.dart';
import 'interfaces/credit_card_local_datasource_interface.dart';

export 'interfaces/credit_card_local_datasource_interface.dart';
export '../../models/models.dart';

/// 신용카드 로컬 데이터소스 구현체
class CreditCardLocalDataSourceImpl implements CreditCardLocalDataSource {
  Isar get _isar => IsarDatabase.instance;

  @override
  Future<List<CreditCardModel>> getAll() async {
    return await _isar.creditCardModels
        .where()
        .filter()
        .isActiveEqualTo(true)
        .sortBySortOrder()
        .findAll();
  }

  @override
  Future<CreditCardModel?> getById(int id) async {
    return await _isar.creditCardModels.get(id);
  }

  @override
  Future<CreditCardModel?> getByUid(String uid) async {
    return await _isar.creditCardModels.filter().uidEqualTo(uid).findFirst();
  }

  @override
  Future<void> save(CreditCardModel card) async {
    await _isar.writeTxn(() async {
      await _isar.creditCardModels.put(card);
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      final card = await _isar.creditCardModels.get(id);
      if (card != null) {
        card.isActive = false;
        card.updatedAt = DateTime.now();
        await _isar.creditCardModels.put(card);
      }
    });
  }

  @override
  Future<void> deleteAll() async {
    await _isar.writeTxn(() async {
      await _isar.creditCardModels.clear();
    });
  }
}
