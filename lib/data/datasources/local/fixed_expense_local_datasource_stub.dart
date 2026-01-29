import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/models_stub.dart'
    if (dart.library.io) '../../models/models.dart';
import 'interfaces/fixed_expense_local_datasource_interface.dart';

export 'interfaces/fixed_expense_local_datasource_interface.dart';

/// 고정비 로컬 데이터소스 구현체 (웹용 - SharedPreferences 기반)
class FixedExpenseLocalDataSourceImpl implements FixedExpenseLocalDataSource {
  static const String _storageKey = 'fixed_expenses';
  static List<FixedExpenseModel>? _cachedExpenses;
  static int _idCounter = 1;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> _loadFromStorage() async {
    if (_cachedExpenses != null) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedExpenses = jsonList.map((e) => _expenseFromJson(e)).toList();
      if (_cachedExpenses!.isNotEmpty) {
        _idCounter = _cachedExpenses!.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    } else {
      _cachedExpenses = [];
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await _prefs;
    final jsonList = _cachedExpenses!.map((e) => _expenseToJson(e)).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

  Map<String, dynamic> _expenseToJson(FixedExpenseModel e) {
    return {
      'id': e.id,
      'uid': e.uid,
      'title': e.title,
      'category': e.category.index,
      'customCategoryId': e.customCategoryId,
      'dueDate': e.dueDate,
      'isVariableAmount': e.isVariableAmount,
      'isRecurringMonthly': e.isRecurringMonthly,
      'amount': e.amount,
      'linkedAccountId': e.linkedAccountId,
      'linkedPaymentMethodId': e.linkedPaymentMethodId,
      'isActive': e.isActive,
      'createdAt': e.createdAt.toIso8601String(),
      'updatedAt': e.updatedAt.toIso8601String(),
    };
  }

  FixedExpenseModel _expenseFromJson(Map<String, dynamic> json) {
    return FixedExpenseModel()
      ..id = json['id'] as int
      ..uid = json['uid'] as String
      ..title = json['title'] as String
      ..category = FixedExpenseCategory.values[json['category'] as int]
      ..customCategoryId = json['customCategoryId'] as String?
      ..dueDate = json['dueDate'] as int
      ..isVariableAmount = json['isVariableAmount'] as bool
      ..isRecurringMonthly = (json['isRecurringMonthly'] as bool?) ?? false
      ..amount = json['amount'] as int?
      ..linkedAccountId = json['linkedAccountId'] as int?
      ..linkedPaymentMethodId = json['linkedPaymentMethodId'] as int?
      ..isActive = json['isActive'] as bool
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = DateTime.parse(json['updatedAt'] as String);
  }

  @override
  Future<List<FixedExpenseModel>> getAll() async {
    await _loadFromStorage();
    return List.from(_cachedExpenses!);
  }

  @override
  Future<List<FixedExpenseModel>> getActive() async {
    await _loadFromStorage();
    return _cachedExpenses!.where((e) => e.isActive).toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  @override
  Future<FixedExpenseModel?> getById(int id) async {
    await _loadFromStorage();
    try {
      return _cachedExpenses!.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<FixedExpenseModel?> getByUid(String uid) async {
    await _loadFromStorage();
    try {
      return _cachedExpenses!.firstWhere((e) => e.uid == uid);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> save(FixedExpenseModel fixedExpense) async {
    await _loadFromStorage();
    fixedExpense.updatedAt = DateTime.now();
    final index = _cachedExpenses!.indexWhere((e) => e.id == fixedExpense.id);
    if (index >= 0) {
      _cachedExpenses![index] = fixedExpense;
    } else {
      fixedExpense.id = _idCounter++;
      _cachedExpenses!.add(fixedExpense);
    }
    await _saveToStorage();
  }

  @override
  Future<void> delete(int id) async {
    await _loadFromStorage();
    _cachedExpenses!.removeWhere((e) => e.id == id);
    await _saveToStorage();
  }

  @override
  Future<void> deleteByUid(String uid) async {
    await _loadFromStorage();
    _cachedExpenses!.removeWhere((e) => e.uid == uid);
    await _saveToStorage();
  }
}
