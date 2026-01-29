/// 앱 전체에서 사용하는 예외(Exception) 클래스들
/// DataSource에서 에러를 throw할 때 사용

/// 서버 관련 예외
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({
    this.message = '서버 오류가 발생했습니다.',
    this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (statusCode: $statusCode)';
}

/// 캐시/로컬 DB 관련 예외
class CacheException implements Exception {
  final String message;

  const CacheException({this.message = '캐시 오류가 발생했습니다.'});

  @override
  String toString() => 'CacheException: $message';
}

/// 네트워크 연결 예외
class NetworkException implements Exception {
  final String message;

  const NetworkException({this.message = '네트워크 연결을 확인해주세요.'});

  @override
  String toString() => 'NetworkException: $message';
}

/// 데이터를 찾을 수 없음 예외
class NotFoundException implements Exception {
  final String message;

  const NotFoundException({this.message = '데이터를 찾을 수 없습니다.'});

  @override
  String toString() => 'NotFoundException: $message';
}

/// 입력값 검증 예외
class ValidationException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;

  const ValidationException({
    this.message = '입력값을 확인해주세요.',
    this.fieldErrors,
  });

  @override
  String toString() => 'ValidationException: $message';
}
