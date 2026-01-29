import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../repositories/asset_repository.dart';
import '../../repositories/debt_repository.dart';
import '../usecase.dart';

/// 순자산 계산 UseCase
/// 순자산 = 총 자산 - 총 부채
class CalculateNetAssets implements UseCase<int, NoParams> {
  final AssetRepository assetRepository;
  final DebtRepository debtRepository;

  CalculateNetAssets({
    required this.assetRepository,
    required this.debtRepository,
  });

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    final assetsResult = await assetRepository.getTotalAssets();
    final debtsResult = await debtRepository.getTotalDebts();

    return assetsResult.fold(
      (failure) => Left(failure),
      (totalAssets) => debtsResult.fold(
        (failure) => Left(failure),
        (totalDebts) => Right(totalAssets - totalDebts),
      ),
    );
  }
}
