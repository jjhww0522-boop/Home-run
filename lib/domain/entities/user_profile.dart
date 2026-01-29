import 'package:equatable/equatable.dart';

/// 사용자 프로필 Entity
class UserProfile extends Equatable {
  final String id;
  final String? name;             // 사용자 이름
  final int? monthlySavingGoal;   // 월 저축 목표액
  final DateTime? birthDate;      // 생년월일 (은퇴 시점 계산용)
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    this.name,
    this.monthlySavingGoal,
    this.birthDate,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        monthlySavingGoal,
        birthDate,
        createdAt,
        updatedAt,
      ];
}
