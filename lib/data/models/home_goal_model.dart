import 'package:isar/isar.dart';
import '../../domain/entities/home_goal.dart';

part 'home_goal_model.g.dart';

/// Isar용 목표 주택 모델
@collection
class HomeGoalModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uid;

  late String name;
  String? regionCode;
  String? address;
  String? apartmentName;
  double? exclusiveArea;
  late int targetPrice;
  int? downPayment;
  int? intermediatePayment;
  int? balance;
  DateTime? targetDate;
  String? memo;
  late DateTime createdAt;
  late DateTime updatedAt;

  HomeGoalModel();

  /// Entity -> Model 변환
  factory HomeGoalModel.fromEntity(HomeGoal entity) {
    return HomeGoalModel()
      ..uid = entity.id
      ..name = entity.name
      ..regionCode = entity.regionCode
      ..address = entity.address
      ..apartmentName = entity.apartmentName
      ..exclusiveArea = entity.exclusiveArea
      ..targetPrice = entity.targetPrice
      ..downPayment = entity.downPayment
      ..intermediatePayment = entity.intermediatePayment
      ..balance = entity.balance
      ..targetDate = entity.targetDate
      ..memo = entity.memo
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt;
  }

  /// Model -> Entity 변환
  HomeGoal toEntity() {
    return HomeGoal(
      id: uid,
      name: name,
      regionCode: regionCode,
      address: address,
      apartmentName: apartmentName,
      exclusiveArea: exclusiveArea,
      targetPrice: targetPrice,
      downPayment: downPayment,
      intermediatePayment: intermediatePayment,
      balance: balance,
      targetDate: targetDate,
      memo: memo,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
