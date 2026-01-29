/// 버전 정보 유틸리티
/// pubspec.yaml의 버전을 읽어서 표시
class VersionUtils {
  /// pubspec.yaml에 정의된 버전
  /// 버전 업데이트 시 이 값도 함께 업데이트해야 합니다
  static const String version = '1.3.1';
  static const int buildNumber = 23;
  
  /// 표시용 버전 문자열 (v1.1.0 형식)
  static String get displayVersion => 'v$version';
  
  /// 전체 버전 문자열 (1.1.0+2 형식)
  static String get fullVersion => '$version+$buildNumber';
  
  /// 버전 체크: pubspec.yaml의 버전과 일치하는지 확인
  /// 업데이트 시 이 메서드를 호출하여 버전이 동기화되었는지 확인
  static bool checkVersionSync(String pubspecVersion) {
    // pubspec.yaml의 버전 형식: "1.1.0+2" -> "1.1.0" 추출
    final pubspecVersionOnly = pubspecVersion.split('+').first;
    return version == pubspecVersionOnly;
  }
}
