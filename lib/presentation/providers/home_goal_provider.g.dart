// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_goal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeGoalLocalDataSourceHash() =>
    r'5c4ec82ced770be0bb4d62e62d6b2810fcf86c7d';

/// 목표 로컬 데이터소스 Provider
///
/// Copied from [homeGoalLocalDataSource].
@ProviderFor(homeGoalLocalDataSource)
final homeGoalLocalDataSourceProvider =
    AutoDisposeProvider<HomeGoalLocalDataSource>.internal(
  homeGoalLocalDataSource,
  name: r'homeGoalLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeGoalLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HomeGoalLocalDataSourceRef
    = AutoDisposeProviderRef<HomeGoalLocalDataSource>;
String _$homeGoalRepositoryHash() =>
    r'7f1f6a7f69dcd1fde07d88eec48eb9baa5f3b629';

/// 목표 Repository Provider
///
/// Copied from [homeGoalRepository].
@ProviderFor(homeGoalRepository)
final homeGoalRepositoryProvider =
    AutoDisposeProvider<HomeGoalRepository>.internal(
  homeGoalRepository,
  name: r'homeGoalRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeGoalRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HomeGoalRepositoryRef = AutoDisposeProviderRef<HomeGoalRepository>;
String _$apiServiceHash() => r'd76dea2a3d4afd840c19952cd59fe889ce36151d';

/// API 서비스 Provider
///
/// Copied from [apiService].
@ProviderFor(apiService)
final apiServiceProvider = AutoDisposeProvider<ApiService>.internal(
  apiService,
  name: r'apiServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ApiServiceRef = AutoDisposeProviderRef<ApiService>;
String _$currentGoalHash() => r'6055f824b0ac5655006885782d172d99c8745d99';

/// 현재 목표 Provider
///
/// Copied from [currentGoal].
@ProviderFor(currentGoal)
final currentGoalProvider = AutoDisposeFutureProvider<HomeGoal?>.internal(
  currentGoal,
  name: r'currentGoalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentGoalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentGoalRef = AutoDisposeFutureProviderRef<HomeGoal?>;
String _$apartmentTradesHash() => r'bc6db7059bd5976df780c4028ccbe185254df9d3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 실거래가 조회 Provider
///
/// Copied from [apartmentTrades].
@ProviderFor(apartmentTrades)
const apartmentTradesProvider = ApartmentTradesFamily();

/// 실거래가 조회 Provider
///
/// Copied from [apartmentTrades].
class ApartmentTradesFamily extends Family<AsyncValue<List<HousePriceModel>>> {
  /// 실거래가 조회 Provider
  ///
  /// Copied from [apartmentTrades].
  const ApartmentTradesFamily();

  /// 실거래가 조회 Provider
  ///
  /// Copied from [apartmentTrades].
  ApartmentTradesProvider call({
    required String lawdCd,
    required String dealYm,
  }) {
    return ApartmentTradesProvider(
      lawdCd: lawdCd,
      dealYm: dealYm,
    );
  }

  @override
  ApartmentTradesProvider getProviderOverride(
    covariant ApartmentTradesProvider provider,
  ) {
    return call(
      lawdCd: provider.lawdCd,
      dealYm: provider.dealYm,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'apartmentTradesProvider';
}

/// 실거래가 조회 Provider
///
/// Copied from [apartmentTrades].
class ApartmentTradesProvider
    extends AutoDisposeFutureProvider<List<HousePriceModel>> {
  /// 실거래가 조회 Provider
  ///
  /// Copied from [apartmentTrades].
  ApartmentTradesProvider({
    required String lawdCd,
    required String dealYm,
  }) : this._internal(
          (ref) => apartmentTrades(
            ref as ApartmentTradesRef,
            lawdCd: lawdCd,
            dealYm: dealYm,
          ),
          from: apartmentTradesProvider,
          name: r'apartmentTradesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$apartmentTradesHash,
          dependencies: ApartmentTradesFamily._dependencies,
          allTransitiveDependencies:
              ApartmentTradesFamily._allTransitiveDependencies,
          lawdCd: lawdCd,
          dealYm: dealYm,
        );

  ApartmentTradesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lawdCd,
    required this.dealYm,
  }) : super.internal();

  final String lawdCd;
  final String dealYm;

  @override
  Override overrideWith(
    FutureOr<List<HousePriceModel>> Function(ApartmentTradesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApartmentTradesProvider._internal(
        (ref) => create(ref as ApartmentTradesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lawdCd: lawdCd,
        dealYm: dealYm,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<HousePriceModel>> createElement() {
    return _ApartmentTradesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApartmentTradesProvider &&
        other.lawdCd == lawdCd &&
        other.dealYm == dealYm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lawdCd.hashCode);
    hash = _SystemHash.combine(hash, dealYm.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ApartmentTradesRef
    on AutoDisposeFutureProviderRef<List<HousePriceModel>> {
  /// The parameter `lawdCd` of this provider.
  String get lawdCd;

  /// The parameter `dealYm` of this provider.
  String get dealYm;
}

class _ApartmentTradesProviderElement
    extends AutoDisposeFutureProviderElement<List<HousePriceModel>>
    with ApartmentTradesRef {
  _ApartmentTradesProviderElement(super.provider);

  @override
  String get lawdCd => (origin as ApartmentTradesProvider).lawdCd;
  @override
  String get dealYm => (origin as ApartmentTradesProvider).dealYm;
}

String _$homeGoalNotifierHash() => r'87444e630f76690aad0f57fef26abdf37b1cc20d';

/// 목표 상태 관리 Notifier
///
/// Copied from [HomeGoalNotifier].
@ProviderFor(HomeGoalNotifier)
final homeGoalNotifierProvider =
    AutoDisposeAsyncNotifierProvider<HomeGoalNotifier, HomeGoal?>.internal(
  HomeGoalNotifier.new,
  name: r'homeGoalNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeGoalNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeGoalNotifier = AutoDisposeAsyncNotifier<HomeGoal?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
