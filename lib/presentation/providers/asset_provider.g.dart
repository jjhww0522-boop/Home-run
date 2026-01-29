// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$assetLocalDataSourceHash() =>
    r'781dbfbbbad6613f56b032ff8d2a018f373e046e';

/// 자산 로컬 데이터소스 Provider
///
/// Copied from [assetLocalDataSource].
@ProviderFor(assetLocalDataSource)
final assetLocalDataSourceProvider =
    AutoDisposeProvider<AssetLocalDataSource>.internal(
  assetLocalDataSource,
  name: r'assetLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$assetLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AssetLocalDataSourceRef = AutoDisposeProviderRef<AssetLocalDataSource>;
String _$assetRepositoryHash() => r'11fdecc79482d8e7e0aa51419947336309a57746';

/// 자산 Repository Provider
///
/// Copied from [assetRepository].
@ProviderFor(assetRepository)
final assetRepositoryProvider = AutoDisposeProvider<AssetRepository>.internal(
  assetRepository,
  name: r'assetRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$assetRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AssetRepositoryRef = AutoDisposeProviderRef<AssetRepository>;
String _$assetListHash() => r'7e565a982397550f64fd6525029f07e33ac7df7b';

/// 모든 자산 목록 Provider
///
/// Copied from [assetList].
@ProviderFor(assetList)
final assetListProvider = AutoDisposeFutureProvider<List<Asset>>.internal(
  assetList,
  name: r'assetListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$assetListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AssetListRef = AutoDisposeFutureProviderRef<List<Asset>>;
String _$totalAssetsHash() => r'ff1e84dc0592e6ef8ecf65c65fc7b8d1e1be464d';

/// 총 자산 Provider
///
/// Copied from [totalAssets].
@ProviderFor(totalAssets)
final totalAssetsProvider = AutoDisposeFutureProvider<int>.internal(
  totalAssets,
  name: r'totalAssetsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalAssetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalAssetsRef = AutoDisposeFutureProviderRef<int>;
String _$assetNotifierHash() => r'89c86ca1e5f4c2776165600236a8f830d69ec12b';

/// 자산 상태 관리 Notifier
///
/// Copied from [AssetNotifier].
@ProviderFor(AssetNotifier)
final assetNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AssetNotifier, List<Asset>>.internal(
  AssetNotifier.new,
  name: r'assetNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$assetNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AssetNotifier = AutoDisposeAsyncNotifier<List<Asset>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
