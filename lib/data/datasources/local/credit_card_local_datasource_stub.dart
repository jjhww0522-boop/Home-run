import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/credit_card_model_stub.dart';
import 'interfaces/credit_card_local_datasource_interface.dart';

export 'interfaces/credit_card_local_datasource_interface.dart';
export '../../models/models_stub.dart';

/// 신용카드 로컬 데이터소스 구현체 (웹용 - SharedPreferences 기반)
class CreditCardLocalDataSourceImpl implements CreditCardLocalDataSource {
  static const String _storageKey = 'credit_cards';
  static List<CreditCardModel>? _cachedCards;
  static int _idCounter = 1;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> _loadFromStorage() async {
    if (_cachedCards != null) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedCards = jsonList.map((e) => _cardFromJson(e)).toList();
      if (_cachedCards!.isNotEmpty) {
        _idCounter = _cachedCards!.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    } else {
      _cachedCards = [];
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await _prefs;
    final jsonList = _cachedCards!.map((c) => _cardToJson(c)).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

  Map<String, dynamic> _cardToJson(CreditCardModel c) {
    return {
      'id': c.id,
      'uid': c.uid,
      'name': c.name,
      'cardType': c.cardType.index,
      'issuer': c.issuer,
      'cardNumber': c.cardNumber,
      'paymentDay': c.paymentDay,
      'targetAmount': c.targetAmount,
      'currentUsage': c.currentUsage,
      'annualFee': c.annualFee,
      'billingCycleStartDay': c.billingCycleStartDay,
      'linkedAccountId': c.linkedAccountId,
      'memo': c.memo,
      'sortOrder': c.sortOrder,
      'isActive': c.isActive,
      'createdAt': c.createdAt.toIso8601String(),
      'updatedAt': c.updatedAt.toIso8601String(),
    };
  }

  CreditCardModel _cardFromJson(Map<String, dynamic> json) {
    return CreditCardModel()
      ..id = json['id'] as int
      ..uid = json['uid'] as String
      ..name = json['name'] as String
      ..cardType = CardType.values[json['cardType'] as int]
      ..issuer = json['issuer'] as String
      ..cardNumber = json['cardNumber'] as String?
      ..paymentDay = json['paymentDay'] as int
      ..targetAmount = json['targetAmount'] as int
      ..currentUsage = json['currentUsage'] as int
      ..annualFee = json['annualFee'] as int?
      ..billingCycleStartDay = json['billingCycleStartDay'] as int?
      ..linkedAccountId = json['linkedAccountId'] as String?
      ..memo = json['memo'] as String?
      ..sortOrder = json['sortOrder'] as int
      ..isActive = json['isActive'] as bool
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = DateTime.parse(json['updatedAt'] as String);
  }

  @override
  Future<List<CreditCardModel>> getAll() async {
    await _loadFromStorage();
    return _cachedCards!
        .where((c) => c.isActive)
        .toList();
  }

  @override
  Future<CreditCardModel?> getById(int id) async {
    await _loadFromStorage();
    try {
      return _cachedCards!.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<CreditCardModel?> getByUid(String uid) async {
    await _loadFromStorage();
    try {
      return _cachedCards!.firstWhere((c) => c.uid == uid);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> save(CreditCardModel card) async {
    await _loadFromStorage();
    if (card.id == 0) {
      // 새로 추가하는 경우
      card.id = _idCounter++;
      _cachedCards!.add(card);
    } else {
      // 수정하는 경우
      final index = _cachedCards!.indexWhere((c) => c.id == card.id);
      if (index >= 0) {
        _cachedCards![index] = card;
      } else {
        // id는 있지만 리스트에 없는 경우
        _cachedCards!.add(card);
        if (card.id >= _idCounter) {
          _idCounter = card.id + 1;
        }
      }
    }
    await _saveToStorage();
  }

  @override
  Future<void> delete(int id) async {
    await _loadFromStorage();
    final card = await getById(id);
    if (card != null) {
      card.isActive = false;
      card.updatedAt = DateTime.now();
      await save(card);
    }
  }

  @override
  Future<void> deleteAll() async {
    await _loadFromStorage();
    _cachedCards!.clear();
    await _saveToStorage();
  }
}
