import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/home_goal.dart';

/// 목표 주택 Repository 인터페이스
/// Data Layer에서 구현합니다.
abstract class HomeGoalRepository {
  /// 현재 목표 조회
  Future<Either<Failure, HomeGoal?>> getGoal();

  /// 목표 설정/수정
  Future<Either<Failure, void>> saveGoal(HomeGoal goal);

  /// 목표 삭제
  Future<Either<Failure, void>> deleteGoal();
}
