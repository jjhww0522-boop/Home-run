import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';

/// 기본 카테고리 커스터마이징 정보
class DefaultCategoryCustomization {
  final String name;
  final int colorValue;

  DefaultCategoryCustomization({
    required this.name,
    required this.colorValue,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'colorValue': colorValue,
  };

  factory DefaultCategoryCustomization.fromJson(Map<String, dynamic> json) => DefaultCategoryCustomization(
    name: json['name'] as String,
    colorValue: json['colorValue'] as int,
  );
}

/// 기본 카테고리 커스터마이징 관리 유틸리티
class DefaultCategoryCustomizer {
  static const String _storageKey = 'default_category_customizations';
  static Map<String, DefaultCategoryCustomization>? _cache;

  static Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  static Future<void> _loadFromStorage() async {
    if (_cache != null) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _cache = jsonMap.map((key, value) => MapEntry(
        key,
        DefaultCategoryCustomization.fromJson(value as Map<String, dynamic>),
      ));
    } else {
      _cache = {};
    }
  }

  static Future<void> _saveToStorage() async {
    final prefs = await _prefs;
    final jsonMap = _cache!.map((key, value) => MapEntry(key, value.toJson()));
    await prefs.setString(_storageKey, json.encode(jsonMap));
  }

  /// 기본 카테고리 이름 가져오기
  static Future<String> getCategoryName(FixedExpenseCategory category) async {
    await _loadFromStorage();
    return _cache![category.name]?.name ?? category.displayName;
  }

  /// 기본 카테고리 색상 가져오기
  static Future<int> getCategoryColor(FixedExpenseCategory category) async {
    await _loadFromStorage();
    return _cache![category.name]?.colorValue ?? 0xFF4CAF50; // 기본 초록색
  }

  /// 기본 카테고리 커스터마이징 정보 가져오기
  static Future<DefaultCategoryCustomization?> getCustomization(FixedExpenseCategory category) async {
    await _loadFromStorage();
    return _cache![category.name];
  }

  /// 기본 카테고리 커스터마이징 저장
  static Future<void> setCustomization(
    FixedExpenseCategory category,
    String name,
    int colorValue,
  ) async {
    await _loadFromStorage();
    _cache![category.name] = DefaultCategoryCustomization(
      name: name,
      colorValue: colorValue,
    );
    await _saveToStorage();
  }

  /// 기본 카테고리 커스터마이징 삭제 (기본값으로 복원)
  static Future<void> removeCustomization(FixedExpenseCategory category) async {
    await _loadFromStorage();
    _cache!.remove(category.name);
    await _saveToStorage();
  }

  /// 모든 커스터마이징 정보 가져오기
  static Future<Map<String, DefaultCategoryCustomization>> getAllCustomizations() async {
    await _loadFromStorage();
    return Map.from(_cache!);
  }
}
