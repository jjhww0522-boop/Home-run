import 'package:uuid/uuid.dart';

/// 사용자 정의 고정비 카테고리 모델 (웹용)
class CustomFixedCategoryModel {
  int id = 0;
  late String uid;
  late String name;
  String? description;
  late String iconName;
  late int colorValue;
  late int sortOrder;
  late bool isActive;
  late DateTime createdAt;
  late DateTime updatedAt;

  CustomFixedCategoryModel();

  factory CustomFixedCategoryModel.create({
    required String name,
    String? description,
    String iconName = 'category',
    int colorValue = 0xFF9E9E9E,
    int sortOrder = 0,
    bool isActive = true,
  }) {
    return CustomFixedCategoryModel()
      ..uid = const Uuid().v4()
      ..name = name
      ..description = description
      ..iconName = iconName
      ..colorValue = colorValue
      ..sortOrder = sortOrder
      ..isActive = isActive
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }
}
