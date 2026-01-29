import 'package:isar/isar.dart';
import '../../../core/errors/exceptions.dart';
import '../../../domain/entities/asset.dart';
import '../../models/asset_model.dart';
import 'isar_database.dart';
import 'interfaces/asset_local_datasource_interface.dart';

export 'interfaces/asset_local_datasource_interface.dart';
export '../../models/models.dart';

/// 자산 로컬 데이터소스 구현체
class AssetLocalDataSourceImpl implements AssetLocalDataSource {
  Isar get _isar => IsarDatabase.instance;

  @override
  Future<List<AssetModel>> getAllAssets() async {
    try {
      return await _isar.assetModels.where().findAll();
    } catch (e) {
      throw CacheException(message: '자산 목록을 불러오는데 실패했습니다: $e');
    }
  }

  @override
  Future<List<AssetModel>> getAssetsByType(AssetType type) async {
    try {
      return await _isar.assetModels.filter().typeEqualTo(type).findAll();
    } catch (e) {
      throw CacheException(message: '자산을 불러오는데 실패했습니다: $e');
    }
  }

  @override
  Future<AssetModel?> getAssetById(String id) async {
    try {
      return await _isar.assetModels.filter().uidEqualTo(id).findFirst();
    } catch (e) {
      throw CacheException(message: '자산을 불러오는데 실패했습니다: $e');
    }
  }

  @override
  Future<AssetModel> addAsset(AssetModel asset) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.assetModels.put(asset);
      });
      return asset;
    } catch (e) {
      throw CacheException(message: '자산 저장에 실패했습니다: $e');
    }
  }

  @override
  Future<AssetModel> updateAsset(AssetModel asset) async {
    try {
      final existing =
          await _isar.assetModels.filter().uidEqualTo(asset.uid).findFirst();

      if (existing == null) {
        throw const NotFoundException(message: '수정할 자산을 찾을 수 없습니다.');
      }

      asset.id = existing.id; // 기존 ID 유지

      await _isar.writeTxn(() async {
        await _isar.assetModels.put(asset);
      });
      return asset;
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw CacheException(message: '자산 수정에 실패했습니다: $e');
    }
  }

  @override
  Future<void> deleteAsset(String id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.assetModels.filter().uidEqualTo(id).deleteAll();
      });
    } catch (e) {
      throw CacheException(message: '자산 삭제에 실패했습니다: $e');
    }
  }

  @override
  Future<int> getTotalAssets() async {
    try {
      final assets = await getAllAssets();
      return assets.fold(0, (sum, asset) => sum + asset.amount);
    } catch (e) {
      throw CacheException(message: '총 자산 계산에 실패했습니다: $e');
    }
  }
}
