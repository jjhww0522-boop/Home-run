import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/asset_model.dart';
import '../../models/debt_model.dart';
import '../../models/home_goal_model.dart';
import '../../models/transaction_model.dart';
import '../../models/payment_method_model.dart';
import '../../models/account_model.dart';
import '../../models/credit_card_model.dart';
import '../../models/fixed_expense_model.dart';

/// Isar 데이터베이스 초기화 및 관리
class IsarDatabase {
  static Isar? _instance;

  /// Isar 인스턴스 가져오기
  static Isar get instance {
    if (_instance == null) {
      throw Exception('Isar가 초기화되지 않았습니다. init()을 먼저 호출하세요.');
    }
    return _instance!;
  }

  /// Isar 초기화
  static Future<void> init() async {
    if (_instance != null) return;

    final dir = await getApplicationDocumentsDirectory();

    _instance = await Isar.open(
      [
        AssetModelSchema,
        DebtModelSchema,
        HomeGoalModelSchema,
        TransactionModelSchema,
        PaymentMethodModelSchema,
        AccountModelSchema,
        CreditCardModelSchema,
        FixedExpenseModelSchema,
      ],
      directory: dir.path,
      name: 'homerun_db',
    );
  }

  /// Isar 닫기
  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }

  /// 모든 데이터 삭제 (개발/테스트용)
  static Future<void> clearAll() async {
    await instance.writeTxn(() async {
      await instance.clear();
    });
  }
}
