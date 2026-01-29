import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/asset.dart';
import '../../data/datasources/local/asset_local_datasource_stub.dart'
    if (dart.library.io) '../../data/datasources/local/asset_local_datasource.dart';
import '../../data/repositories/asset_repository_impl.dart';
import '../../domain/repositories/asset_repository.dart';

part 'asset_provider.g.dart';

/// 자산 로컬 데이터소스 Provider
@riverpod
AssetLocalDataSource assetLocalDataSource(Ref ref) {
  return AssetLocalDataSourceImpl();
}

/// 자산 Repository Provider
@riverpod
AssetRepository assetRepository(Ref ref) {
  return AssetRepositoryImpl(
    localDataSource: ref.watch(assetLocalDataSourceProvider),
  );
}

/// 모든 자산 목록 Provider
@riverpod
Future<List<Asset>> assetList(Ref ref) async {
  final repository = ref.watch(assetRepositoryProvider);
  final result = await repository.getAllAssets();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (assets) => assets,
  );
}

/// 총 자산 Provider
@riverpod
Future<int> totalAssets(Ref ref) async {
  final repository = ref.watch(assetRepositoryProvider);
  final result = await repository.getTotalAssets();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (total) => total,
  );
}

/// 자산 상태 관리 Notifier
@riverpod
class AssetNotifier extends _$AssetNotifier {
  @override
  Future<List<Asset>> build() async {
    final repository = ref.watch(assetRepositoryProvider);
    final result = await repository.getAllAssets();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (assets) => assets,
    );
  }

  /// 자산 추가
  Future<void> addAsset(Asset asset) async {
    final repository = ref.read(assetRepositoryProvider);
    final result = await repository.addAsset(asset);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }

  /// 자산 수정
  Future<void> updateAsset(Asset asset) async {
    final repository = ref.read(assetRepositoryProvider);
    final result = await repository.updateAsset(asset);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }

  /// 자산 삭제
  Future<void> deleteAsset(String id) async {
    final repository = ref.read(assetRepositoryProvider);
    final result = await repository.deleteAsset(id);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }
}
