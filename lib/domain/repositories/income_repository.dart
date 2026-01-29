import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/income.dart';

/// 수입 Repository 인터페이스
/// Data Layer에서 구현합니다.
abstract class IncomeRepository {
  /// 모든 수입 조회
  Future<Either<Failure, List<Income>>> getAllIncomes();

  /// 수입 유형별 조회
  Future<Either<Failure, List<Income>>> getIncomesByType(IncomeType type);

  /// 단일 수입 조회
  Future<Either<Failure, Income>> getIncomeById(String id);

  /// 수입 추가
  Future<Either<Failure, Income>> addIncome(Income income);

  /// 수입 수정
  Future<Either<Failure, Income>> updateIncome(Income income);

  /// 수입 삭제
  Future<Either<Failure, void>> deleteIncome(String id);

  /// 월 총 수입 계산 (월급 기준)
  Future<Either<Failure, int>> getMonthlyIncome();

  /// 연간 총 수입 계산 (월급 * 12 + 성과급)
  Future<Either<Failure, int>> getAnnualIncome();

  /// 성과급 총액
  Future<Either<Failure, int>> getTotalBonus();
}
