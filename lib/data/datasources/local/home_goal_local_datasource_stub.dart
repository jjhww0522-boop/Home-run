import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entities/home_goal.dart';
import '../../models/models_stub.dart';
import 'interfaces/home_goal_local_datasource_interface.dart';

export 'interfaces/home_goal_local_datasource_interface.dart';
export '../../models/models_stub.dart';

/// 웹용 목표 주택 로컬 데이터소스 구현체 (SharedPreferences 기반)
class HomeGoalLocalDataSourceImpl implements HomeGoalLocalDataSource {
  static const String _storageKey = 'home_goal';
  static HomeGoal? _cachedGoal;
  static bool _isLoaded = false;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> _loadFromStorage() async {
    if (_isLoaded) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      _cachedGoal = _goalFromJson(json);
    }
    _isLoaded = true;
  }

  Future<void> _saveToStorage() async {
    final prefs = await _prefs;
    if (_cachedGoal != null) {
      await prefs.setString(_storageKey, jsonEncode(_goalToJson(_cachedGoal!)));
    } else {
      await prefs.remove(_storageKey);
    }
  }

  Map<String, dynamic> _goalToJson(HomeGoal goal) {
    return {
      'id': goal.id,
      'name': goal.name,
      'regionCode': goal.regionCode,
      'address': goal.address,
      'apartmentName': goal.apartmentName,
      'exclusiveArea': goal.exclusiveArea,
      'targetPrice': goal.targetPrice,
      'downPayment': goal.downPayment,
      'intermediatePayment': goal.intermediatePayment,
      'balance': goal.balance,
      'targetDate': goal.targetDate?.toIso8601String(),
      'memo': goal.memo,
      'createdAt': goal.createdAt.toIso8601String(),
      'updatedAt': goal.updatedAt.toIso8601String(),
    };
  }

  HomeGoal _goalFromJson(Map<String, dynamic> json) {
    return HomeGoal(
      id: json['id'] as String,
      name: json['name'] as String,
      regionCode: json['regionCode'] as String?,
      address: json['address'] as String?,
      apartmentName: json['apartmentName'] as String?,
      exclusiveArea: json['exclusiveArea'] as double?,
      targetPrice: json['targetPrice'] as int,
      downPayment: json['downPayment'] as int?,
      intermediatePayment: json['intermediatePayment'] as int?,
      balance: json['balance'] as int?,
      targetDate: json['targetDate'] != null ? DateTime.parse(json['targetDate'] as String) : null,
      memo: json['memo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  Future<HomeGoal?> getGoal() async {
    await _loadFromStorage();
    return _cachedGoal;
  }

  @override
  Future<void> saveGoal(HomeGoal goal) async {
    await _loadFromStorage();
    _cachedGoal = goal;
    await _saveToStorage();
  }

  @override
  Future<void> deleteGoal() async {
    await _loadFromStorage();
    _cachedGoal = null;
    await _saveToStorage();
  }
}
