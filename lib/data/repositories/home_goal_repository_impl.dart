import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/home_goal.dart';
import '../../domain/repositories/home_goal_repository.dart';
import '../datasources/local/interfaces/home_goal_local_datasource_interface.dart';
import '../models/models_stub.dart'
    if (dart.library.io) '../models/models.dart';

/// 목표 주택 Repository 구현체
class HomeGoalRepositoryImpl implements HomeGoalRepository {
  final HomeGoalLocalDataSource localDataSource;

  HomeGoalRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, HomeGoal?>> getGoal() async {
    try {
      final goal = await localDataSource.getGoal();
      return Right(goal);
    } catch (e) {
      return Left(CacheFailure('목표를 불러오는데 실패했습니다: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveGoal(HomeGoal goal) async {
    try {
      await localDataSource.saveGoal(goal);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('목표 저장에 실패했습니다: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGoal() async {
    try {
      await localDataSource.deleteGoal();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('목표 삭제에 실패했습니다: $e'));
    }
  }
}
