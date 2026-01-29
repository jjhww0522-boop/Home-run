import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/models_stub.dart';
import 'interfaces/payment_method_local_datasource_interface.dart';

export 'interfaces/payment_method_local_datasource_interface.dart';
export '../../models/models_stub.dart';

/// 웹용 결제 수단 로컬 데이터소스 구현체 (SharedPreferences 기반)
class PaymentMethodLocalDataSourceImpl implements PaymentMethodLocalDataSource {
  static const String _storageKey = 'payment_methods';
  static List<PaymentMethodModel>? _cachedMethods;
  static int _idCounter = 1;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> _loadFromStorage() async {
    if (_cachedMethods != null) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedMethods = jsonList.map((e) => _methodFromJson(e)).toList();
      if (_cachedMethods!.isNotEmpty) {
        _idCounter = _cachedMethods!.map((m) => m.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    } else {
      _cachedMethods = [];
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await _prefs;
    final jsonList = _cachedMethods!.map((m) => _methodToJson(m)).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

  Map<String, dynamic> _methodToJson(PaymentMethodModel m) {
    return {
      'id': m.id,
      'uid': m.uid,
      'name': m.name,
      'type': m.type.index,
      'balance': m.balance,
      'memo': m.memo,
      'linkedAccountId': m.linkedAccountId,
      'sortOrder': m.sortOrder,
      'isActive': m.isActive,
      'createdAt': m.createdAt.toIso8601String(),
      'updatedAt': m.updatedAt.toIso8601String(),
    };
  }

  PaymentMethodModel _methodFromJson(Map<String, dynamic> json) {
    return PaymentMethodModel()
      ..id = json['id'] as int
      ..uid = json['uid'] as String
      ..name = json['name'] as String
      ..type = PaymentMethodType.values[json['type'] as int]
      ..balance = json['balance'] as int
      ..memo = json['memo'] as String?
      ..linkedAccountId = json['linkedAccountId'] as String?
      ..sortOrder = json['sortOrder'] as int
      ..isActive = json['isActive'] as bool
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = DateTime.parse(json['updatedAt'] as String);
  }

  @override
  Future<List<PaymentMethodModel>> getAll() async {
    await _loadFromStorage();
    return _cachedMethods!
        .where((m) => m.isActive)
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  @override
  Future<PaymentMethodModel?> getById(int id) async {
    await _loadFromStorage();
    try {
      return _cachedMethods!.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(PaymentMethodModel method) async {
    await _loadFromStorage();
    final existingIndex = _cachedMethods!.indexWhere((m) => m.id == method.id && method.id != 0);
    if (existingIndex >= 0) {
      _cachedMethods![existingIndex] = method;
    } else {
      method.id = _idCounter++;
      _cachedMethods!.add(method);
    }
    await _saveToStorage();
  }

  @override
  Future<void> delete(int id) async {
    await _loadFromStorage();
    final index = _cachedMethods!.indexWhere((m) => m.id == id);
    if (index >= 0) {
      _cachedMethods![index].isActive = false;
      _cachedMethods![index].updatedAt = DateTime.now();
      await _saveToStorage();
    }
  }

  @override
  Future<void> deleteAll() async {
    await _loadFromStorage();
    _cachedMethods!.clear();
    await _saveToStorage();
  }

  @override
  Future<bool> hasAnyMethods() async {
    await _loadFromStorage();
    return _cachedMethods!.isNotEmpty;
  }

  @override
  Future<void> initializeDefaultMethods() async {
    // 웹에서는 기본 초기화 없음
  }
}
