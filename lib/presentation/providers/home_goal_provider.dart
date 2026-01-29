import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/home_goal.dart';
import '../../data/datasources/local/home_goal_local_datasource_stub.dart'
    if (dart.library.io) '../../data/datasources/local/home_goal_local_datasource.dart';
import '../../data/repositories/home_goal_repository_impl.dart';
import '../../domain/repositories/home_goal_repository.dart';
import '../../data/services/api_service.dart';
import '../../data/models/house_price_model.dart';

part 'home_goal_provider.g.dart';

/// 목표 로컬 데이터소스 Provider
@riverpod
HomeGoalLocalDataSource homeGoalLocalDataSource(Ref ref) {
  return HomeGoalLocalDataSourceImpl();
}

/// 목표 Repository Provider
@riverpod
HomeGoalRepository homeGoalRepository(Ref ref) {
  return HomeGoalRepositoryImpl(
    localDataSource: ref.watch(homeGoalLocalDataSourceProvider),
  );
}

/// API 서비스 Provider
@riverpod
ApiService apiService(Ref ref) {
  return ApiService();
}

/// 현재 목표 Provider
@riverpod
Future<HomeGoal?> currentGoal(Ref ref) async {
  final repository = ref.watch(homeGoalRepositoryProvider);
  final result = await repository.getGoal();
  return result.fold(
    (failure) => null,
    (goal) => goal,
  );
}

/// 목표 상태 관리 Notifier
@riverpod
class HomeGoalNotifier extends _$HomeGoalNotifier {
  @override
  Future<HomeGoal?> build() async {
    final repository = ref.watch(homeGoalRepositoryProvider);
    final result = await repository.getGoal();
    return result.fold(
      (failure) => null,
      (goal) => goal,
    );
  }

  /// 실거래가 정보로 목표 설정
  Future<void> setGoalFromTradeInfo({
    required HousePriceModel tradeInfo,
    required String regionCode,
    required String address,
  }) async {
    final repository = ref.read(homeGoalRepositoryProvider);
    final now = DateTime.now();

    final goal = HomeGoal(
      id: const Uuid().v4(),
      name: tradeInfo.apartmentName,
      regionCode: regionCode,
      address: address,
      apartmentName: tradeInfo.apartmentName,
      exclusiveArea: tradeInfo.exclusiveArea,
      targetPrice: tradeInfo.dealAmount * 10000, // 만원 -> 원
      createdAt: now,
      updatedAt: now,
    );

    final result = await repository.saveGoal(goal);
    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }

  /// 목표 직접 설정
  Future<void> setGoal(HomeGoal goal) async {
    final repository = ref.read(homeGoalRepositoryProvider);
    final result = await repository.saveGoal(goal);
    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }

  /// 목표 삭제
  Future<void> deleteGoal() async {
    final repository = ref.read(homeGoalRepositoryProvider);
    final result = await repository.deleteGoal();
    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }
}

/// 실거래가 조회 Provider
@riverpod
Future<List<HousePriceModel>> apartmentTrades(
  Ref ref, {
  required String lawdCd,
  required String dealYm,
}) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getApartmentTradeDetail(
    lawdCd: lawdCd,
    dealYm: dealYm,
  );
}
