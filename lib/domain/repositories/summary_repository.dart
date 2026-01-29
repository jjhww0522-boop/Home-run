import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/monthly_summary.dart';

/// 월별 요약 Repository 인터페이스
/// Data Layer에서 구현합니다.
abstract class SummaryRepository {
  /// 특정 월 요약 조회
  Future<Either<Failure, MonthlySummary?>> getSummary(int year, int month);

  /// 최근 N개월 요약 조회
  Future<Either<Failure, List<MonthlySummary>>> getRecentSummaries(int months);

  /// 연간 요약 조회
  Future<Either<Failure, List<MonthlySummary>>> getYearlySummaries(int year);

  /// 월별 요약 저장
  Future<Either<Failure, MonthlySummary>> saveSummary(MonthlySummary summary);

  /// 현재 월 요약 생성/갱신
  Future<Either<Failure, MonthlySummary>> generateCurrentSummary();
}
