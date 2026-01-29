import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/models_stub.dart'
    if (dart.library.io) '../../models/models.dart';

/// 사용자 정의 고정비 카테고리 로컬 데이터소스 (웹용 - SharedPreferences 기반)
class CustomFixedCategoryLocalDataSource {
  static const String _storageKey = 'custom_fixed_categories';
  static List<CustomFixedCategoryModel>? _cachedCategories;
  static int _idCounter = 1;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> _loadFromStorage() async {
    if (_cachedCategories != null) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedCategories = jsonList.map((e) => _categoryFromJson(e)).toList();
      if (_cachedCategories!.isNotEmpty) {
        _idCounter = _cachedCategories!.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    } else {
      _cachedCategories = [];
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await _prefs;
    final jsonList = _cachedCategories!.map((e) => _categoryToJson(e)).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

  Map<String, dynamic> _categoryToJson(CustomFixedCategoryModel c) {
    return {
      'id': c.id,
      'uid': c.uid,
      'name': c.name,
      'description': c.description,
      'iconName': c.iconName,
      'colorValue': c.colorValue,
      'sortOrder': c.sortOrder,
      'isActive': c.isActive,
      'createdAt': c.createdAt.toIso8601String(),
      'updatedAt': c.updatedAt.toIso8601String(),
    };
  }

  CustomFixedCategoryModel _categoryFromJson(Map<String, dynamic> json) {
    return CustomFixedCategoryModel()
      ..id = json['id'] as int
      ..uid = json['uid'] as String
      ..name = json['name'] as String
      ..description = json['description'] as String?
      ..iconName = json['iconName'] as String
      ..colorValue = json['colorValue'] as int
      ..sortOrder = json['sortOrder'] as int
      ..isActive = json['isActive'] as bool
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = DateTime.parse(json['updatedAt'] as String);
  }

  Future<List<CustomFixedCategoryModel>> getAll() async {
    await _loadFromStorage();
    return List.from(_cachedCategories!);
  }

  Future<List<CustomFixedCategoryModel>> getActive() async {
    await _loadFromStorage();
    return _cachedCategories!.where((c) => c.isActive).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  Future<CustomFixedCategoryModel?> getById(int id) async {
    await _loadFromStorage();
    try {
      return _cachedCategories!.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<CustomFixedCategoryModel?> getByUid(String uid) async {
    await _loadFromStorage();
    try {
      return _cachedCategories!.firstWhere((c) => c.uid == uid);
    } catch (e) {
      return null;
    }
  }

  Future<void> save(CustomFixedCategoryModel category) async {
    await _loadFromStorage();
    category.updatedAt = DateTime.now();
    final index = _cachedCategories!.indexWhere((c) => c.id == category.id);
    if (index >= 0) {
      _cachedCategories![index] = category;
    } else {
      category.id = _idCounter++;
      _cachedCategories!.add(category);
    }
    await _saveToStorage();
  }

  Future<void> delete(int id) async {
    await _loadFromStorage();
    _cachedCategories!.removeWhere((c) => c.id == id);
    await _saveToStorage();
  }

  Future<void> deleteByUid(String uid) async {
    await _loadFromStorage();
    _cachedCategories!.removeWhere((c) => c.uid == uid);
    await _saveToStorage();
  }
}
