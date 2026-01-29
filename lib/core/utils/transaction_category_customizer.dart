import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';

/// 거래 카테고리 커스터마이징 정보
class TransactionCategoryCustomization {
  final String name;
  final int colorValue;

  TransactionCategoryCustomization({
    required this.name,
    required this.colorValue,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'colorValue': colorValue,
  };

  factory TransactionCategoryCustomization.fromJson(Map<String, dynamic> json) => TransactionCategoryCustomization(
    name: json['name'] as String,
    colorValue: json['colorValue'] as int,
  );
}

/// 거래 카테고리 커스터마이징 관리 유틸리티
class TransactionCategoryCustomizer {
  static const String _storageKey = 'transaction_category_customizations';
  static Map<String, TransactionCategoryCustomization>? _cache;

  static Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  static Future<void> _loadFromStorage() async {
    if (_cache != null) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _cache = jsonMap.map((key, value) => MapEntry(
        key,
        TransactionCategoryCustomization.fromJson(value as Map<String, dynamic>),
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

  /// 거래 카테고리 이름 가져오기
  static Future<String> getCategoryName(TransactionCategory category) async {
    await _loadFromStorage();
    return _cache![category.name]?.name ?? category.displayName;
  }

  /// 거래 카테고리 색상 가져오기
  static Future<int> getCategoryColor(TransactionCategory category) async {
    await _loadFromStorage();
    // 기본 색상은 카테고리 타입에 따라 다르게 설정
    if (category.isIncome) {
      return _cache![category.name]?.colorValue ?? 0xFF4CAF50; // 초록색
    } else if (category.isExpense) {
      return _cache![category.name]?.colorValue ?? 0xFFF44336; // 빨간색
    } else {
      return _cache![category.name]?.colorValue ?? 0xFF2196F3; // 파란색
    }
  }

  /// 거래 카테고리 커스터마이징 정보 가져오기
  static Future<TransactionCategoryCustomization?> getCustomization(TransactionCategory category) async {
    await _loadFromStorage();
    return _cache![category.name];
  }

  /// 거래 카테고리 커스터마이징 저장
  static Future<void> setCustomization(
    TransactionCategory category,
    String name,
    int colorValue,
  ) async {
    await _loadFromStorage();
    _cache![category.name] = TransactionCategoryCustomization(
      name: name,
      colorValue: colorValue,
    );
    await _saveToStorage();
  }

  /// 거래 카테고리 커스터마이징 삭제 (기본값으로 복원)
  static Future<void> removeCustomization(TransactionCategory category) async {
    await _loadFromStorage();
    _cache!.remove(category.name);
    await _saveToStorage();
  }

  /// 모든 커스터마이징 정보 가져오기
  static Future<Map<String, TransactionCategoryCustomization>> getAllCustomizations() async {
    await _loadFromStorage();
    return Map.from(_cache!);
  }
}
