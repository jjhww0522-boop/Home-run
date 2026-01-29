// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customFixedCategoryLocalDataSourceHash() =>
    r'bb2bbe7475d651969513fcf9b9f2a5a2c43232dc';

/// 사용자 정의 카테고리 데이터소스 Provider
///
/// Copied from [customFixedCategoryLocalDataSource].
@ProviderFor(customFixedCategoryLocalDataSource)
final customFixedCategoryLocalDataSourceProvider =
    AutoDisposeProvider<CustomFixedCategoryLocalDataSource>.internal(
  customFixedCategoryLocalDataSource,
  name: r'customFixedCategoryLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customFixedCategoryLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CustomFixedCategoryLocalDataSourceRef
    = AutoDisposeProviderRef<CustomFixedCategoryLocalDataSource>;
String _$customCategoryNameHash() =>
    r'7b0de3814b6ea39e8f09b234da26a916c6e4dbe7';

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

/// 카테고리 uid로 이름 조회 Provider
///
/// Copied from [customCategoryName].
@ProviderFor(customCategoryName)
const customCategoryNameProvider = CustomCategoryNameFamily();

/// 카테고리 uid로 이름 조회 Provider
///
/// Copied from [customCategoryName].
class CustomCategoryNameFamily extends Family<AsyncValue<String?>> {
  /// 카테고리 uid로 이름 조회 Provider
  ///
  /// Copied from [customCategoryName].
  const CustomCategoryNameFamily();

  /// 카테고리 uid로 이름 조회 Provider
  ///
  /// Copied from [customCategoryName].
  CustomCategoryNameProvider call(
    String uid,
  ) {
    return CustomCategoryNameProvider(
      uid,
    );
  }

  @override
  CustomCategoryNameProvider getProviderOverride(
    covariant CustomCategoryNameProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'customCategoryNameProvider';
}

/// 카테고리 uid로 이름 조회 Provider
///
/// Copied from [customCategoryName].
class CustomCategoryNameProvider extends AutoDisposeFutureProvider<String?> {
  /// 카테고리 uid로 이름 조회 Provider
  ///
  /// Copied from [customCategoryName].
  CustomCategoryNameProvider(
    String uid,
  ) : this._internal(
          (ref) => customCategoryName(
            ref as CustomCategoryNameRef,
            uid,
          ),
          from: customCategoryNameProvider,
          name: r'customCategoryNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customCategoryNameHash,
          dependencies: CustomCategoryNameFamily._dependencies,
          allTransitiveDependencies:
              CustomCategoryNameFamily._allTransitiveDependencies,
          uid: uid,
        );

  CustomCategoryNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<String?> Function(CustomCategoryNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomCategoryNameProvider._internal(
        (ref) => create(ref as CustomCategoryNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _CustomCategoryNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomCategoryNameProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CustomCategoryNameRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _CustomCategoryNameProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with CustomCategoryNameRef {
  _CustomCategoryNameProviderElement(super.provider);

  @override
  String get uid => (origin as CustomCategoryNameProvider).uid;
}

String _$fixedExpenseLocalDataSourceHash() =>
    r'61d5be23b262089e1ff1cc7a2c5142e4f4bd6a2c';

/// 고정비 데이터소스 Provider
///
/// Copied from [fixedExpenseLocalDataSource].
@ProviderFor(fixedExpenseLocalDataSource)
final fixedExpenseLocalDataSourceProvider =
    AutoDisposeProvider<FixedExpenseLocalDataSource>.internal(
  fixedExpenseLocalDataSource,
  name: r'fixedExpenseLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fixedExpenseLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FixedExpenseLocalDataSourceRef
    = AutoDisposeProviderRef<FixedExpenseLocalDataSource>;
String _$fixedExpenseServiceHash() =>
    r'01437f5b3e2c54657417c651c44e7e193c2bfea4';

/// 고정비 서비스 Provider
///
/// Copied from [fixedExpenseService].
@ProviderFor(fixedExpenseService)
final fixedExpenseServiceProvider =
    AutoDisposeProvider<FixedExpenseService>.internal(
  fixedExpenseService,
  name: r'fixedExpenseServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fixedExpenseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FixedExpenseServiceRef = AutoDisposeProviderRef<FixedExpenseService>;
String _$fixedExpenseListHash() => r'60b312eee5f4c764d39da95cf3ff9e01316a3116';

/// 전체 고정비 목록 Provider
///
/// Copied from [fixedExpenseList].
@ProviderFor(fixedExpenseList)
final fixedExpenseListProvider =
    AutoDisposeFutureProvider<List<FixedExpenseModel>>.internal(
  fixedExpenseList,
  name: r'fixedExpenseListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fixedExpenseListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FixedExpenseListRef
    = AutoDisposeFutureProviderRef<List<FixedExpenseModel>>;
String _$activeFixedExpenseListHash() =>
    r'842bfef6a36c2bb9ef837fc0745b6e0bf6303ee1';

/// 활성 고정비 목록 Provider
///
/// Copied from [activeFixedExpenseList].
@ProviderFor(activeFixedExpenseList)
final activeFixedExpenseListProvider =
    AutoDisposeFutureProvider<List<FixedExpenseModel>>.internal(
  activeFixedExpenseList,
  name: r'activeFixedExpenseListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeFixedExpenseListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ActiveFixedExpenseListRef
    = AutoDisposeFutureProviderRef<List<FixedExpenseModel>>;
String _$variableFixedExpensesDueThisMonthHash() =>
    r'668596ac838c19db1ec48d045021323cd11d9b9e';

/// 이번 달 결제일인 변동 고정비 목록 (내역 불러오기용)
///
/// Copied from [variableFixedExpensesDueThisMonth].
@ProviderFor(variableFixedExpensesDueThisMonth)
final variableFixedExpensesDueThisMonthProvider =
    AutoDisposeFutureProvider<List<FixedExpenseModel>>.internal(
  variableFixedExpensesDueThisMonth,
  name: r'variableFixedExpensesDueThisMonthProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$variableFixedExpensesDueThisMonthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VariableFixedExpensesDueThisMonthRef
    = AutoDisposeFutureProviderRef<List<FixedExpenseModel>>;
String _$totalExpectedFixedExpenseAmountHash() =>
    r'39cd7a31a6256a040745c337651a6e9a33ab096e';

/// 이번 달 총 고정비 예상 금액 Provider
///
/// Copied from [totalExpectedFixedExpenseAmount].
@ProviderFor(totalExpectedFixedExpenseAmount)
final totalExpectedFixedExpenseAmountProvider =
    AutoDisposeFutureProvider<int>.internal(
  totalExpectedFixedExpenseAmount,
  name: r'totalExpectedFixedExpenseAmountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalExpectedFixedExpenseAmountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalExpectedFixedExpenseAmountRef = AutoDisposeFutureProviderRef<int>;
String _$customFixedCategoryNotifierHash() =>
    r'4d6653685f2183a71a90b8cc7405704ec780c914';

/// 사용자 정의 카테고리 상태 관리 Notifier
///
/// Copied from [CustomFixedCategoryNotifier].
@ProviderFor(CustomFixedCategoryNotifier)
final customFixedCategoryNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CustomFixedCategoryNotifier, List<CustomFixedCategoryModel>>.internal(
  CustomFixedCategoryNotifier.new,
  name: r'customFixedCategoryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customFixedCategoryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomFixedCategoryNotifier
    = AutoDisposeAsyncNotifier<List<CustomFixedCategoryModel>>;
String _$fixedExpenseNotifierHash() =>
    r'f36d760bc27aa088b541a2ddfe881a45084c7797';

/// 고정비 상태 관리 Notifier
///
/// Copied from [FixedExpenseNotifier].
@ProviderFor(FixedExpenseNotifier)
final fixedExpenseNotifierProvider = AutoDisposeAsyncNotifierProvider<
    FixedExpenseNotifier, List<FixedExpenseModel>>.internal(
  FixedExpenseNotifier.new,
  name: r'fixedExpenseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fixedExpenseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FixedExpenseNotifier
    = AutoDisposeAsyncNotifier<List<FixedExpenseModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
