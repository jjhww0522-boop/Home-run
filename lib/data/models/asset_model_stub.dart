import '../../domain/entities/asset.dart';

/// 웹용 자산 모델
class AssetModel {
  int id = 0;

  late String uid;            // UUID

  late String name;
  late AssetType type;
  late int amount;
  double? interestRate;
  DateTime? maturityDate;
  String? institution;
  String? memo;
  late DateTime createdAt;
  late DateTime updatedAt;

  AssetModel();

  /// Entity -> Model 변환
  factory AssetModel.fromEntity(Asset entity) {
    return AssetModel()
      ..uid = entity.id
      ..name = entity.name
      ..type = entity.type
      ..amount = entity.amount
      ..interestRate = entity.interestRate
      ..maturityDate = entity.maturityDate
      ..institution = entity.institution
      ..memo = entity.memo
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt;
  }

  /// Model -> Entity 변환
  Asset toEntity() {
    return Asset(
      id: uid,
      name: name,
      type: type,
      amount: amount,
      interestRate: interestRate,
      maturityDate: maturityDate,
      institution: institution,
      memo: memo,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
