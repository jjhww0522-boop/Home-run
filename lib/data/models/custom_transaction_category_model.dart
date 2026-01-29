import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'transaction_model.dart';

part 'custom_transaction_category_model.g.dart';

/// 사용자 정의 거래 카테고리 모델
@collection
class CustomTransactionCategoryModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uid;

  /// 카테고리 이름
  late String name;

  /// 거래 타입 (소득/소비/저축)
  @Enumerated(EnumType.name)
  late TransactionType transactionType;

  /// 카테고리 설명 (선택)
  String? description;

  /// 카테고리 아이콘 (Material Icons 이름)
  late String iconName;

  /// 카테고리 색상 (hex 값, 예: 0xFF4CAF50)
  late int colorValue;

  /// 정렬 순서
  late int sortOrder;

  /// 활성화 여부
  @Index()
  late bool isActive;

  /// 생성일
  late DateTime createdAt;

  /// 수정일
  late DateTime updatedAt;

  CustomTransactionCategoryModel();

  /// 간편 생성자
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
