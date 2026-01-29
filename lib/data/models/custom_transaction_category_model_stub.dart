import 'package:uuid/uuid.dart';
import 'transaction_model_stub.dart';

/// 사용자 정의 거래 카테고리 모델 (웹용)
class CustomTransactionCategoryModel {
  int id = 0;
  late String uid;
  late String name;
  late TransactionType transactionType;
  String? description;
  late String iconName;
  late int colorValue;
  late int sortOrder;
  late bool isActive;
  late DateTime createdAt;
  late DateTime updatedAt;

  CustomTransactionCategoryModel();

  factory CustomTransactionCategoryModel.create({
    required String name,
    required TransactionType transactionType,
    String? description,
    String iconName = 'category',
    int colorValue = 0xFF9E9E9E,
    int sortOrder = 0,
    bool isActive = true,
  }) {
    return CustomTransactionCategoryModel()
      ..uid = const Uuid().v4()
      ..name = name
      ..transactionType = transactionType
      ..description = description
      ..iconName = iconName
      ..colorValue = colorValue
      ..sortOrder = sortOrder
      ..isActive = isActive
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }
}
