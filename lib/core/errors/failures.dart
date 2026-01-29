import 'package:equatable/equatable.dart';

/// 앱 전체에서 사용하는 실패(Failure) 클래스들
/// UseCase에서 에러를 처리할 때 사용
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// 서버/네트워크 관련 실패
class ServerFailure extends Failure {
  const ServerFailure([super.message = '서버 오류가 발생했습니다.']);
}

/// 캐시/로컬 DB 관련 실패
class CacheFailure extends Failure {
  const CacheFailure([super.message = '로컬 데이터 오류가 발생했습니다.']);
}

/// 네트워크 연결 실패
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = '네트워크 연결을 확인해주세요.']);
}

/// 입력값 검증 실패
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = '입력값을 확인해주세요.']);
}

/// 데이터를 찾을 수 없음
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = '데이터를 찾을 수 없습니다.']);
}

/// 권한 없음
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = '권한이 없습니다.']);
}

/// 알 수 없는 오류
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = '알 수 없는 오류가 발생했습니다.']);
}
