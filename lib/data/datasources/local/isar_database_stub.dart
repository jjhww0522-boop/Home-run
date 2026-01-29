/// 웹 빌드용 IsarDatabase stub
/// 웹에서는 Isar를 사용할 수 없으므로 빈 구현체 제공
class IsarDatabase {
  static Future<void> init() async {
    // 웹에서는 아무것도 하지 않음
  }

  static Future<void> close() async {
    // 웹에서는 아무것도 하지 않음
  }
}
