import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/account_model_stub.dart';
import 'interfaces/account_local_datasource_interface.dart';

export 'interfaces/account_local_datasource_interface.dart';
export '../../models/models_stub.dart';

/// 계좌 로컬 데이터소스 구현체 (웹용 - SharedPreferences 기반)
class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  static const String _storageKey = 'accounts';
  static List<AccountModel>? _cachedAccounts;
  static int _idCounter = 1;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> _loadFromStorage() async {
    if (_cachedAccounts != null) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedAccounts = jsonList.map((e) => _accountFromJson(e)).toList();
      if (_cachedAccounts!.isNotEmpty) {
        _idCounter = _cachedAccounts!.map((a) => a.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    } else {
      _cachedAccounts = [];
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await _prefs;
    final jsonList = _cachedAccounts!.map((a) => _accountToJson(a)).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

  Map<String, dynamic> _accountToJson(AccountModel a) {
    return {
      'id': a.id,
      'uid': a.uid,
      'name': a.name,
      'type': a.type.index,
      'balance': a.balance,
      'institution': a.institution,
      'interestRate': a.interestRate,
      'monthlyPayment': a.monthlyPayment,
      'maturityDate': a.maturityDate?.toIso8601String(),
      'startDate': a.startDate?.toIso8601String(),
      'totalPayments': a.totalPayments,
      'memo': a.memo,
      'sortOrder': a.sortOrder,
      'isActive': a.isActive,
      'createdAt': a.createdAt.toIso8601String(),
      'updatedAt': a.updatedAt.toIso8601String(),
    };
  }

  AccountModel _accountFromJson(Map<String, dynamic> json) {
    return AccountModel()
      ..id = json['id'] as int
      ..uid = json['uid'] as String
      ..name = json['name'] as String
      ..type = AccountType.values[json['type'] as int]
      ..balance = json['balance'] as int
      ..institution = json['institution'] as String?
      ..interestRate = json['interestRate'] as double?
      ..monthlyPayment = json['monthlyPayment'] as int?
      ..maturityDate = json['maturityDate'] != null
          ? DateTime.parse(json['maturityDate'] as String)
          : null
      ..startDate = json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null
      ..totalPayments = json['totalPayments'] as int?
      ..memo = json['memo'] as String?
      ..sortOrder = json['sortOrder'] as int
      ..isActive = json['isActive'] as bool
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = DateTime.parse(json['updatedAt'] as String);
  }

  @override
  Future<List<AccountModel>> getAll() async {
    await _loadFromStorage();
    return _cachedAccounts!
        .where((a) => a.isActive)
        .toList();
  }

  @override
  Future<AccountModel?> getById(int id) async {
    await _loadFromStorage();
    try {
      return _cachedAccounts!.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AccountModel?> getByUid(String uid) async {
    await _loadFromStorage();
    try {
      return _cachedAccounts!.firstWhere((a) => a.uid == uid);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> save(AccountModel account) async {
    await _loadFromStorage();
    if (account.id == 0) {
      // 새로 추가하는 경우
      account.id = _idCounter++;
      _cachedAccounts!.add(account);
    } else {
      // 수정하는 경우
      final index = _cachedAccounts!.indexWhere((a) => a.id == account.id);
      if (index >= 0) {
        _cachedAccounts![index] = account;
      } else {
        // id는 있지만 리스트에 없는 경우
        _cachedAccounts!.add(account);
        if (account.id >= _idCounter) {
          _idCounter = account.id + 1;
        }
      }
    }
    await _saveToStorage();
  }

  @override
  Future<void> delete(int id) async {
    await _loadFromStorage();
    final account = await getById(id);
    if (account != null) {
      account.isActive = false;
      account.updatedAt = DateTime.now();
      await save(account);
    }
  }

  @override
  Future<void> deleteAll() async {
    await _loadFromStorage();
    _cachedAccounts!.clear();
    await _saveToStorage();
  }
}
