import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/errors/exceptions.dart';
import '../../../domain/entities/asset.dart';
import '../../models/models_stub.dart';
import 'interfaces/asset_local_datasource_interface.dart';

export 'interfaces/asset_local_datasource_interface.dart';
export '../../models/models_stub.dart';

/// 웹용 자산 로컬 데이터소스 구현체 (SharedPreferences 기반)
class AssetLocalDataSourceImpl implements AssetLocalDataSource {
  static const String _storageKey = 'assets';
  static List<AssetModel>? _cachedAssets;
  static int _idCounter = 1;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> _loadFromStorage() async {
    if (_cachedAssets != null) return;

    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedAssets = jsonList.map((e) => _assetFromJson(e)).toList();
      if (_cachedAssets!.isNotEmpty) {
        _idCounter = _cachedAssets!.map((a) => a.id).reduce((a, b) => a > b ? a : b) + 1;
      }
    } else {
      _cachedAssets = [];
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await _prefs;
    final jsonList = _cachedAssets!.map((a) => _assetToJson(a)).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
  }

  Map<String, dynamic> _assetToJson(AssetModel a) {
    return {
      'id': a.id,
      'uid': a.uid,
      'name': a.name,
      'type': a.type.index,
      'amount': a.amount,
      'memo': a.memo,
      'createdAt': a.createdAt.toIso8601String(),
      'updatedAt': a.updatedAt.toIso8601String(),
    };
  }

  AssetModel _assetFromJson(Map<String, dynamic> json) {
    return AssetModel()
      ..id = json['id'] as int
      ..uid = json['uid'] as String
      ..name = json['name'] as String
      ..type = AssetType.values[json['type'] as int]
      ..amount = json['amount'] as int
      ..memo = json['memo'] as String?
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = DateTime.parse(json['updatedAt'] as String);
  }

  @override
  Future<List<AssetModel>> getAllAssets() async {
    await _loadFromStorage();
    return List.from(_cachedAssets!);
  }

  @override
  Future<List<AssetModel>> getAssetsByType(AssetType type) async {
    await _loadFromStorage();
    return _cachedAssets!.where((a) => a.type == type).toList();
  }

  @override
  Future<AssetModel?> getAssetById(String id) async {
    await _loadFromStorage();
    try {
      return _cachedAssets!.firstWhere((a) => a.uid == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AssetModel> addAsset(AssetModel asset) async {
    await _loadFromStorage();
    asset.id = _idCounter++;
    _cachedAssets!.add(asset);
    await _saveToStorage();
    return asset;
  }

  @override
  Future<AssetModel> updateAsset(AssetModel asset) async {
    await _loadFromStorage();
    final index = _cachedAssets!.indexWhere((a) => a.uid == asset.uid);
    if (index < 0) {
      throw const NotFoundException(message: '수정할 자산을 찾을 수 없습니다.');
    }
    asset.id = _cachedAssets![index].id;
    _cachedAssets![index] = asset;
    await _saveToStorage();
    return asset;
  }

  @override
  Future<void> deleteAsset(String id) async {
    await _loadFromStorage();
    _cachedAssets!.removeWhere((a) => a.uid == id);
    await _saveToStorage();
  }

  @override
  Future<int> getTotalAssets() async {
    await _loadFromStorage();
    int total = 0;
    for (final asset in _cachedAssets!) {
      total += asset.amount;
    }
    return total;
  }
}
