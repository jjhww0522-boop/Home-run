import '../../domain/entities/debt.dart';

/// 웹용 부채 모델
class DebtModel {
  int id = 0;

  late String uid;

  late String name;
  late DebtType type;
  late int principalAmount;
  late int remainingAmount;
  late double interestRate;
  late InterestRateType interestType;
  late int monthlyPayment;
  late DateTime startDate;
  DateTime? endDate;
  String? institution;
  String? memo;
  late DateTime createdAt;
  late DateTime updatedAt;

  DebtModel();

  /// Entity -> Model 변환
  factory DebtModel.fromEntity(Debt entity) {
    return DebtModel()
      ..uid = entity.id
      ..name = entity.name
      ..type = entity.type
      ..principalAmount = entity.principalAmount
      ..remainingAmount = entity.remainingAmount
      ..interestRate = entity.interestRate
      ..interestType = entity.interestType
      ..monthlyPayment = entity.monthlyPayment
      ..startDate = entity.startDate
      ..endDate = entity.endDate
      ..institution = entity.institution
      ..memo = entity.memo
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt;
  }

  /// Model -> Entity 변환
  Debt toEntity() {
    return Debt(
      id: uid,
      name: name,
      type: type,
      principalAmount: principalAmount,
      remainingAmount: remainingAmount,
      interestRate: interestRate,
      interestType: interestType,
      monthlyPayment: monthlyPayment,
      startDate: startDate,
      endDate: endDate,
      institution: institution,
      memo: memo,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
