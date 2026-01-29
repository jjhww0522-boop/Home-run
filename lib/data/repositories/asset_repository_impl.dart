import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/asset.dart';
import '../../domain/repositories/asset_repository.dart';
import '../datasources/local/interfaces/asset_local_datasource_interface.dart';
import '../models/models_stub.dart'
    if (dart.library.io) '../models/models.dart';

/// 자산 Repository 구현체
class AssetRepositoryImpl implements AssetRepository {
  final AssetLocalDataSource localDataSource;

  AssetRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Asset>>> getAllAssets() async {
    try {
      final models = await localDataSource.getAllAssets();
      return Right(models.map((m) => m.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Asset>>> getAssetsByType(AssetType type) async {
    try {
      final models = await localDataSource.getAssetsByType(type);
      return Right(models.map((m) => m.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Asset>> getAssetById(String id) async {
    try {
      final model = await localDataSource.getAssetById(id);
      if (model == null) {
        return const Left(NotFoundFailure('자산을 찾을 수 없습니다.'));
      }
      return Right(model.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Asset>> addAsset(Asset asset) async {
    try {
      final model = AssetModel.fromEntity(asset);
      final result = await localDataSource.addAsset(model);
      return Right(result.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Asset>> updateAsset(Asset asset) async {
    try {
      final model = AssetModel.fromEntity(asset);
      final result = await localDataSource.updateAsset(model);
      return Right(result.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAsset(String id) async {
    try {
      await localDataSource.deleteAsset(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getTotalAssets() async {
    try {
      final total = await localDataSource.getTotalAssets();
      return Right(total);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getTaxDeductibleAssets() async {
    try {
      final pensionAssets =
          await localDataSource.getAssetsByType(AssetType.pensionSaving);
      final irpAssets =
          await localDataSource.getAssetsByType(AssetType.irp);

      final total = pensionAssets.fold(0, (sum, a) => sum + a.amount) +
          irpAssets.fold(0, (sum, a) => sum + a.amount);

      return Right(total);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
