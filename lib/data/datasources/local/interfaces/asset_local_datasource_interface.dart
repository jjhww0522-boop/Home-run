import '../../../../domain/entities/asset.dart';
import '../../../models/models_stub.dart'
    if (dart.library.io) '../../../models/models.dart';

/// 자산 로컬 데이터소스 인터페이스
abstract class AssetLocalDataSource {
  Future<List<AssetModel>> getAllAssets();
  Future<List<AssetModel>> getAssetsByType(AssetType type);
  Future<AssetModel?> getAssetById(String id);
  Future<AssetModel> addAsset(AssetModel asset);
  Future<AssetModel> updateAsset(AssetModel asset);
  Future<void> deleteAsset(String id);
  Future<int> getTotalAssets();
}
