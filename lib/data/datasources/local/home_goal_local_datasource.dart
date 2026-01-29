import 'package:isar/isar.dart';
import '../../models/home_goal_model.dart';
import '../../../domain/entities/home_goal.dart';
import 'isar_database.dart';
import 'interfaces/home_goal_local_datasource_interface.dart';

export 'interfaces/home_goal_local_datasource_interface.dart';
export '../../models/models.dart';

/// 목표 주택 로컬 데이터소스 구현체
class HomeGoalLocalDataSourceImpl implements HomeGoalLocalDataSource {
  Isar get _isar => IsarDatabase.instance;

  @override
  Future<HomeGoal?> getGoal() async {
    final model = await _isar.homeGoalModels.where().findFirst();
    return model?.toEntity();
  }

  @override
  Future<void> saveGoal(HomeGoal goal) async {
    final model = HomeGoalModel.fromEntity(goal);

    await _isar.writeTxn(() async {
      // 기존 목표가 있으면 삭제 후 저장 (단일 목표만 유지)
      await _isar.homeGoalModels.clear();
      await _isar.homeGoalModels.put(model);
    });
  }

  @override
  Future<void> deleteGoal() async {
    await _isar.writeTxn(() async {
      await _isar.homeGoalModels.clear();
    });
  }
}
