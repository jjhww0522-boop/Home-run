import '../../../../domain/entities/home_goal.dart';

/// 목표 주택 로컬 데이터소스 인터페이스
abstract class HomeGoalLocalDataSource {
  Future<HomeGoal?> getGoal();
  Future<void> saveGoal(HomeGoal goal);
  Future<void> deleteGoal();
}
