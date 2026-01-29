import 'package:isar/isar.dart';
import '../../models/payment_method_model.dart';
import 'isar_database.dart';
import 'interfaces/payment_method_local_datasource_interface.dart';

export 'interfaces/payment_method_local_datasource_interface.dart';
export '../../models/models.dart';

/// 결제 수단 로컬 데이터소스 구현체
class PaymentMethodLocalDataSourceImpl implements PaymentMethodLocalDataSource {
  Isar get _isar => IsarDatabase.instance;

  @override
  Future<List<PaymentMethodModel>> getAll() async {
    return await _isar.paymentMethodModels
        .where()
        .filter()
        .isActiveEqualTo(true)
        .sortBySortOrder()
        .findAll();
  }

  @override
  Future<PaymentMethodModel?> getById(int id) async {
    return await _isar.paymentMethodModels.get(id);
  }

  @override
  Future<void> save(PaymentMethodModel method) async {
    await _isar.writeTxn(() async {
      await _isar.paymentMethodModels.put(method);
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      final method = await _isar.paymentMethodModels.get(id);
      if (method != null) {
        method.isActive = false;
        method.updatedAt = DateTime.now();
        await _isar.paymentMethodModels.put(method);
      }
    });
  }

  @override
  Future<void> deleteAll() async {
    await _isar.writeTxn(() async {
      await _isar.paymentMethodModels.clear();
    });
  }

  @override
  Future<bool> hasAnyMethods() async {
    final count = await _isar.paymentMethodModels.count();
    return count > 0;
  }

  @override
  Future<void> initializeDefaultMethods() async {
    // 사용자가 직접 결제 수단을 추가하도록 기본 초기화 제거
  }
}
