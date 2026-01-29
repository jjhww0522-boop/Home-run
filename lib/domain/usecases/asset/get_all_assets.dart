import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/asset.dart';
import '../../repositories/asset_repository.dart';
import '../usecase.dart';

/// 모든 자산 조회 UseCase
class GetAllAssets implements UseCase<List<Asset>, NoParams> {
  final AssetRepository repository;

  GetAllAssets(this.repository);

  @override
  Future<Either<Failure, List<Asset>>> call(NoParams params) {
    return repository.getAllAssets();
  }
}
