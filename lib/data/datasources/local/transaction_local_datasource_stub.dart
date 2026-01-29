import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/models_stub.dart';
import 'interfaces/transaction_local_datasource_interface.dart';

export 'interfaces/transaction_local_datasource_interface.dart';
export '../../models/models_stub.dart';

/// 웹용 거래 로컬 데이터소스 구현체 (SharedPreferences 기반)
class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  static const String _storageKey = 'transactions';
  static List<TransactionModel>? _cachedTransactions;
  static int _idCounter = 1;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> _loadFromStorage() async {
    if (_cachedTransactions != null) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedTransactions = jsonList.map((e) => _transactionFromJson(e)).toList();
      if (_cachedTransactions!.isNotEmpty) {
        _idCounter = _cachedTransactions!.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    } else {
      _cachedTransactions = [];
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await _prefs;
    final jsonList = _cachedTransactions!.map((t) => _transactionToJson(t)).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

  Map<String, dynamic> _transactionToJson(TransactionModel t) {
    return {
      'id': t.id,
      'uid': t.uid,
      'date': t.date.toIso8601String(),
      'type': t.type.index,
      'category': t.category.index,
      'customCategoryId': t.customCategoryId,
      'subcategory': t.subcategory,
      'description': t.description,
      'amount': t.amount,
      'withdrawAccountId': t.withdrawAccountId,
      'depositAccountId': t.depositAccountId,
      'isRecurring': t.isRecurring,
      'recurringDay': t.recurringDay,
      'recurringTemplateId': t.recurringTemplateId,
      'lastGeneratedDate': t.lastGeneratedDate?.toIso8601String(),
      'createdAt': t.createdAt.toIso8601String(),
      'updatedAt': t.updatedAt.toIso8601String(),
    };
  }

  TransactionModel _transactionFromJson(Map<String, dynamic> json) {
    return TransactionModel()
      ..id = json['id'] as int
      ..uid = json['uid'] as String? ?? ''
      ..date = DateTime.parse(json['date'] as String)
      ..type = TransactionType.values[json['type'] as int]
      ..category = TransactionCategory.values[json['category'] as int]
      ..customCategoryId = json['customCategoryId'] as String?
      ..subcategory = json['subcategory'] as String?
      ..description = json['description'] as String?
      ..amount = json['amount'] as int
      ..withdrawAccountId = json['withdrawAccountId'] as int?
      ..depositAccountId = json['depositAccountId'] as int?
      ..isRecurring = json['isRecurring'] as bool? ?? false
      ..recurringDay = json['recurringDay'] as int?
      ..recurringTemplateId = json['recurringTemplateId'] as int?
      ..lastGeneratedDate = json['lastGeneratedDate'] != null
          ? DateTime.parse(json['lastGeneratedDate'] as String)
          : null
      ..createdAt = json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now()
      ..updatedAt = json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now();
  }

  @override
  Future<List<TransactionModel>> getAll() async {
    await _loadFromStorage();
    return List.from(_cachedTransactions!)..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<List<TransactionModel>> getByType(TransactionType type) async {
    await _loadFromStorage();
    return _cachedTransactions!
        .where((t) => t.type == type)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<List<TransactionModel>> getByDateRange(DateTime start, DateTime end) async {
    await _loadFromStorage();
    return _cachedTransactions!
        .where((t) => t.date.isAfter(start.subtract(const Duration(days: 1))) &&
                      t.date.isBefore(end.add(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<List<TransactionModel>> getByMonth(int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);
    return await getByDateRange(start, end);
  }

  @override
  Future<TransactionModel?> getById(int id) async {
    await _loadFromStorage();
    try {
      return _cachedTransactions!.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(TransactionModel transaction) async {
    await _loadFromStorage();
    final existingIndex = _cachedTransactions!.indexWhere((t) => t.id == transaction.id && transaction.id != 0);
    if (existingIndex >= 0) {
      _cachedTransactions![existingIndex] = transaction;
    } else {
      transaction.id = _idCounter++;
      _cachedTransactions!.add(transaction);
    }
    await _saveToStorage();
  }

  @override
  Future<void> delete(int id) async {
    await _loadFromStorage();
    _cachedTransactions!.removeWhere((t) => t.id == id);
    await _saveToStorage();
  }

  @override
  Future<int> getTotalByType(TransactionType type, int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);

    await _loadFromStorage();
    final transactions = _cachedTransactions!
        .where((t) => t.type == type &&
                      t.date.isAfter(start.subtract(const Duration(days: 1))) &&
                      t.date.isBefore(end.add(const Duration(days: 1))))
        .toList();

    return transactions.fold<int>(0, (sum, t) => sum + t.amount);
  }

  @override
  Future<List<TransactionModel>> getRecurringTransactions() async {
    await _loadFromStorage();
    return _cachedTransactions!.where((t) => t.isRecurring).toList();
  }
}
