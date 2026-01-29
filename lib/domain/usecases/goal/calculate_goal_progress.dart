import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../repositories/asset_repository.dart';
import '../../repositories/debt_repository.dart';
import '../../repositories/home_goal_repository.dart';
import '../usecase.dart';

/// 목표 달성률 계산 결과
class GoalProgressResult extends Equatable {
  final double progressPercent;     // 달성률 (%)
  final int currentNetAssets;       // 현재 순자산
  final int targetPrice;            // 목표 금액
  final int remainingAmount;        // 남은 금액
  final DateTime? estimatedDate;    // 예상 달성일

  const GoalProgressResult({
    required this.progressPercent,
    required this.currentNetAssets,
    required this.targetPrice,
    required this.remainingAmount,
    this.estimatedDate,
  });

  @override
  List<Object?> get props => [
        progressPercent,
        currentNetAssets,
        targetPrice,
        remainingAmount,
        estimatedDate,
      ];
}

/// 목표 달성률 계산 UseCase
/// 현재 순자산과 목표 주택 가격을 비교하여 달성률을 계산합니다.
class CalculateGoalProgress implements UseCase<GoalProgressResult?, NoParams> {
  final AssetRepository assetRepository;
  final DebtRepository debtRepository;
  final HomeGoalRepository goalRepository;

  CalculateGoalProgress({
    required this.assetRepository,
    required this.debtRepository,
    required this.goalRepository,
  });

  @override
  Future<Either<Failure, GoalProgressResult?>> call(NoParams params) async {
    // 1. 현재 목표 조회
    final goalResult = await goalRepository.getCurrentGoal();

    return goalResult.fold(
      (failure) => Left(failure),
      (goal) async {
        if (goal == null) {
          return const Right(null); // 목표가 설정되지 않음
        }

        // 2. 총 자산 조회
        final assetsResult = await assetRepository.getTotalAssets();
        return assetsResult.fold(
          (failure) => Left(failure),
          (totalAssets) async {
            // 3. 총 부채 조회
            final debtsResult = await debtRepository.getTotalDebts();
            return debtsResult.fold(
              (failure) => Left(failure),
              (totalDebts) {
                // 4. 순자산 계산
                final netAssets = totalAssets - totalDebts;

                // 5. 달성률 계산
                final progress = goal.targetPrice > 0
                    ? (netAssets / goal.targetPrice) * 100
                    : 0.0;

                // 6. 남은 금액 계산
                final remaining = goal.targetPrice - netAssets;

                return Right(GoalProgressResult(
                  progressPercent: progress.clamp(0, 100),
                  currentNetAssets: netAssets,
                  targetPrice: goal.targetPrice,
                  remainingAmount: remaining > 0 ? remaining : 0,
                  estimatedDate: goal.targetDate,
                ));
              },
            );
          },
        );
      },
    );
  }
}
