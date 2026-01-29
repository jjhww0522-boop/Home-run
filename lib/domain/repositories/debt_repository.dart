import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/debt.dart';

/// 부채 Repository 인터페이스
/// Data Layer에서 구현합니다.
abstract class DebtRepository {
  /// 모든 부채 조회
  Future<Either<Failure, List<Debt>>> getAllDebts();

  /// 부채 유형별 조회
  Future<Either<Failure, List<Debt>>> getDebtsByType(DebtType type);

  /// 단일 부채 조회
  Future<Either<Failure, Debt>> getDebtById(String id);

  /// 부채 추가
  Future<Either<Failure, Debt>> addDebt(Debt debt);

  /// 부채 수정
  Future<Either<Failure, Debt>> updateDebt(Debt debt);

  /// 부채 삭제
  Future<Either<Failure, void>> deleteDebt(String id);

  /// 총 부채 계산 (남은 금액 기준)
  Future<Either<Failure, int>> getTotalDebts();

  /// 은행 대출 총액
  Future<Either<Failure, int>> getTotalBankLoans();

  /// 사내 대출 총액
  Future<Either<Failure, int>> getTotalCompanyLoans();

  /// 월 총 상환액
  Future<Either<Failure, int>> getMonthlyPayments();
}
