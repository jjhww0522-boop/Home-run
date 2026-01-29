import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/asset.dart';

/// 자산 Repository 인터페이스
/// Data Layer에서 구현합니다.
abstract class AssetRepository {
  /// 모든 자산 조회
  Future<Either<Failure, List<Asset>>> getAllAssets();

  /// 자산 유형별 조회
  Future<Either<Failure, List<Asset>>> getAssetsByType(AssetType type);

  /// 단일 자산 조회
  Future<Either<Failure, Asset>> getAssetById(String id);

  /// 자산 추가
  Future<Either<Failure, Asset>> addAsset(Asset asset);

  /// 자산 수정
  Future<Either<Failure, Asset>> updateAsset(Asset asset);

  /// 자산 삭제
  Future<Either<Failure, void>> deleteAsset(String id);

  /// 총 자산 계산
  Future<Either<Failure, int>> getTotalAssets();

  /// 세액공제 대상 자산 총액 (연금저축펀드 + IRP)
  Future<Either<Failure, int>> getTaxDeductibleAssets();
}
