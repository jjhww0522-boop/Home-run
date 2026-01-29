import '../../../models/models_stub.dart'
    if (dart.library.io) '../../../models/models.dart';

/// 결제 수단 로컬 데이터소스 인터페이스
abstract class PaymentMethodLocalDataSource {
  Future<List<PaymentMethodModel>> getAll();
  Future<PaymentMethodModel?> getById(int id);
  Future<void> save(PaymentMethodModel method);
  Future<void> delete(int id);
  Future<void> deleteAll();
  Future<void> initializeDefaultMethods();
  Future<bool> hasAnyMethods();
}
