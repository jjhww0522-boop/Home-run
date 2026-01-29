import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/local/asset_local_datasource.dart';
import '../data/repositories/asset_repository_impl.dart';
import '../domain/repositories/asset_repository.dart';
import '../domain/usecases/asset/get_all_assets.dart';
import '../domain/usecases/asset/calculate_net_assets.dart';

/// 의존성 주입 컨테이너
/// Riverpod Provider들을 한 곳에서 관리합니다.

// ==================== DataSources ====================

final assetLocalDataSourceProvider = Provider<AssetLocalDataSource>((ref) {
  return AssetLocalDataSourceImpl();
});

// ==================== Repositories ====================

final assetRepositoryProvider = Provider<AssetRepository>((ref) {
  return AssetRepositoryImpl(
    localDataSource: ref.watch(assetLocalDataSourceProvider),
  );
});

// ==================== UseCases ====================

final getAllAssetsUseCaseProvider = Provider<GetAllAssets>((ref) {
  return GetAllAssets(ref.watch(assetRepositoryProvider));
});

// TODO: 나머지 Repository와 UseCase Provider 추가
// - DebtRepository, DebtLocalDataSource
// - IncomeRepository, IncomeLocalDataSource
// - HomeGoalRepository, HomeGoalLocalDataSource
// - SummaryRepository, SummaryLocalDataSource
// - CalculateNetAssets UseCase
// - CalculateGoalProgress UseCase
