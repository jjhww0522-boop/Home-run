import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';

/// UseCase 기본 인터페이스
/// 모든 UseCase는 이 인터페이스를 구현합니다.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// 파라미터가 없는 UseCase용
class NoParams {
  const NoParams();
}
