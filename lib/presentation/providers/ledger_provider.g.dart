// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionLocalDataSourceHash() =>
    r'91171eb76163e33c3adb39cfe6a6fd5b402687d9';

/// 거래 데이터소스 Provider
///
/// Copied from [transactionLocalDataSource].
@ProviderFor(transactionLocalDataSource)
final transactionLocalDataSourceProvider =
    AutoDisposeProvider<TransactionLocalDataSource>.internal(
  transactionLocalDataSource,
  name: r'transactionLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransactionLocalDataSourceRef
    = AutoDisposeProviderRef<TransactionLocalDataSource>;
String _$paymentMethodLocalDataSourceHash() =>
    r'bc8fc99ca2860db90bb2a26a5bfffc451fe93716';

/// 결제 수단 데이터소스 Provider
///
/// Copied from [paymentMethodLocalDataSource].
@ProviderFor(paymentMethodLocalDataSource)
final paymentMethodLocalDataSourceProvider =
    AutoDisposeProvider<PaymentMethodLocalDataSource>.internal(
  paymentMethodLocalDataSource,
  name: r'paymentMethodLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentMethodLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PaymentMethodLocalDataSourceRef
    = AutoDisposeProviderRef<PaymentMethodLocalDataSource>;
String _$accountLocalDataSourceHash() =>
    r'60ca0d845eb99a3ea6033c7a7a451784079cb8c5';

/// 계좌 데이터소스 Provider
///
/// Copied from [accountLocalDataSource].
@ProviderFor(accountLocalDataSource)
final accountLocalDataSourceProvider =
    AutoDisposeProvider<AccountLocalDataSource>.internal(
  accountLocalDataSource,
  name: r'accountLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccountLocalDataSourceRef
    = AutoDisposeProviderRef<AccountLocalDataSource>;
String _$creditCardLocalDataSourceHash() =>
    r'd3dbf52308126da668bb9d7ccfae57a7b949aafb';

/// 신용카드 데이터소스 Provider
///
/// Copied from [creditCardLocalDataSource].
@ProviderFor(creditCardLocalDataSource)
final creditCardLocalDataSourceProvider =
    AutoDisposeProvider<CreditCardLocalDataSource>.internal(
  creditCardLocalDataSource,
  name: r'creditCardLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$creditCardLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CreditCardLocalDataSourceRef
    = AutoDisposeProviderRef<CreditCardLocalDataSource>;
String _$recurringTransactionServiceHash() =>
    r'f401cb7f25d229e7fa27b5dd4dae6bef14ce5850';

/// 반복 거래 서비스 Provider
///
/// Copied from [recurringTransactionService].
@ProviderFor(recurringTransactionService)
final recurringTransactionServiceProvider =
    AutoDisposeProvider<RecurringTransactionService>.internal(
  recurringTransactionService,
  name: r'recurringTransactionServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recurringTransactionServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecurringTransactionServiceRef
    = AutoDisposeProviderRef<RecurringTransactionService>;
String _$transactionListHash() => r'd6211d1bc987a3bbeef36fa1fb2656552f0efb0e';

/// 전체 거래 목록 Provider
///
/// Copied from [transactionList].
@ProviderFor(transactionList)
final transactionListProvider =
    AutoDisposeFutureProvider<List<TransactionModel>>.internal(
  transactionList,
  name: r'transactionListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TransactionListRef
    = AutoDisposeFutureProviderRef<List<TransactionModel>>;
String _$transactionsByTypeHash() =>
    r'c5eb66e1877d09bfe2258792e9728c5b79ef82e4';

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

/// 타입별 거래 목록 Provider
///
/// Copied from [transactionsByType].
@ProviderFor(transactionsByType)
const transactionsByTypeProvider = TransactionsByTypeFamily();

/// 타입별 거래 목록 Provider
///
/// Copied from [transactionsByType].
class TransactionsByTypeFamily
    extends Family<AsyncValue<List<TransactionModel>>> {
  /// 타입별 거래 목록 Provider
  ///
  /// Copied from [transactionsByType].
  const TransactionsByTypeFamily();

  /// 타입별 거래 목록 Provider
  ///
  /// Copied from [transactionsByType].
  TransactionsByTypeProvider call(
    TransactionType type,
  ) {
    return TransactionsByTypeProvider(
      type,
    );
  }

  @override
  TransactionsByTypeProvider getProviderOverride(
    covariant TransactionsByTypeProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'transactionsByTypeProvider';
}

/// 타입별 거래 목록 Provider
///
/// Copied from [transactionsByType].
class TransactionsByTypeProvider
    extends AutoDisposeFutureProvider<List<TransactionModel>> {
  /// 타입별 거래 목록 Provider
  ///
  /// Copied from [transactionsByType].
  TransactionsByTypeProvider(
    TransactionType type,
  ) : this._internal(
          (ref) => transactionsByType(
            ref as TransactionsByTypeRef,
            type,
          ),
          from: transactionsByTypeProvider,
          name: r'transactionsByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transactionsByTypeHash,
          dependencies: TransactionsByTypeFamily._dependencies,
          allTransitiveDependencies:
              TransactionsByTypeFamily._allTransitiveDependencies,
          type: type,
        );

  TransactionsByTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final TransactionType type;

  @override
  Override overrideWith(
    FutureOr<List<TransactionModel>> Function(TransactionsByTypeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionsByTypeProvider._internal(
        (ref) => create(ref as TransactionsByTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TransactionModel>> createElement() {
    return _TransactionsByTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsByTypeProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TransactionsByTypeRef
    on AutoDisposeFutureProviderRef<List<TransactionModel>> {
  /// The parameter `type` of this provider.
  TransactionType get type;
}

class _TransactionsByTypeProviderElement
    extends AutoDisposeFutureProviderElement<List<TransactionModel>>
    with TransactionsByTypeRef {
  _TransactionsByTypeProviderElement(super.provider);

  @override
  TransactionType get type => (origin as TransactionsByTypeProvider).type;
}

String _$transactionsByMonthHash() =>
    r'0c6426d74dd89a84ac026e557d6966511481a52e';

/// 월별 거래 목록 Provider
///
/// Copied from [transactionsByMonth].
@ProviderFor(transactionsByMonth)
const transactionsByMonthProvider = TransactionsByMonthFamily();

/// 월별 거래 목록 Provider
///
/// Copied from [transactionsByMonth].
class TransactionsByMonthFamily
    extends Family<AsyncValue<List<TransactionModel>>> {
  /// 월별 거래 목록 Provider
  ///
  /// Copied from [transactionsByMonth].
  const TransactionsByMonthFamily();

  /// 월별 거래 목록 Provider
  ///
  /// Copied from [transactionsByMonth].
  TransactionsByMonthProvider call({
    required int year,
    required int month,
  }) {
    return TransactionsByMonthProvider(
      year: year,
      month: month,
    );
  }

  @override
  TransactionsByMonthProvider getProviderOverride(
    covariant TransactionsByMonthProvider provider,
  ) {
    return call(
      year: provider.year,
      month: provider.month,
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
  String? get name => r'transactionsByMonthProvider';
}

/// 월별 거래 목록 Provider
///
/// Copied from [transactionsByMonth].
class TransactionsByMonthProvider
    extends AutoDisposeFutureProvider<List<TransactionModel>> {
  /// 월별 거래 목록 Provider
  ///
  /// Copied from [transactionsByMonth].
  TransactionsByMonthProvider({
    required int year,
    required int month,
  }) : this._internal(
          (ref) => transactionsByMonth(
            ref as TransactionsByMonthRef,
            year: year,
            month: month,
          ),
          from: transactionsByMonthProvider,
          name: r'transactionsByMonthProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transactionsByMonthHash,
          dependencies: TransactionsByMonthFamily._dependencies,
          allTransitiveDependencies:
              TransactionsByMonthFamily._allTransitiveDependencies,
          year: year,
          month: month,
        );

  TransactionsByMonthProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<List<TransactionModel>> Function(TransactionsByMonthRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionsByMonthProvider._internal(
        (ref) => create(ref as TransactionsByMonthRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TransactionModel>> createElement() {
    return _TransactionsByMonthProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsByMonthProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TransactionsByMonthRef
    on AutoDisposeFutureProviderRef<List<TransactionModel>> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _TransactionsByMonthProviderElement
    extends AutoDisposeFutureProviderElement<List<TransactionModel>>
    with TransactionsByMonthRef {
  _TransactionsByMonthProviderElement(super.provider);

  @override
  int get year => (origin as TransactionsByMonthProvider).year;
  @override
  int get month => (origin as TransactionsByMonthProvider).month;
}

String _$paymentMethodListHash() => r'fb77d9197536e5d7afae371fb3556f38e0945936';

/// 결제 수단 목록 Provider
///
/// Copied from [paymentMethodList].
@ProviderFor(paymentMethodList)
final paymentMethodListProvider =
    AutoDisposeFutureProvider<List<PaymentMethodModel>>.internal(
  paymentMethodList,
  name: r'paymentMethodListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentMethodListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PaymentMethodListRef
    = AutoDisposeFutureProviderRef<List<PaymentMethodModel>>;
String _$lastMonthFixedExpensesHash() =>
    r'1474512f2ce460a67f860da67b339ee1644150bf';

/// 지난달 고정 지출 Provider
///
/// Copied from [lastMonthFixedExpenses].
@ProviderFor(lastMonthFixedExpenses)
final lastMonthFixedExpensesProvider =
    AutoDisposeFutureProvider<List<TransactionModel>>.internal(
  lastMonthFixedExpenses,
  name: r'lastMonthFixedExpensesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lastMonthFixedExpensesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LastMonthFixedExpensesRef
    = AutoDisposeFutureProviderRef<List<TransactionModel>>;
String _$customTransactionCategoryLocalDataSourceHash() =>
    r'1bc4304436cec4d549310632c33257cd20b6bc14';

/// 사용자 정의 거래 카테고리 데이터소스 Provider
///
/// Copied from [customTransactionCategoryLocalDataSource].
@ProviderFor(customTransactionCategoryLocalDataSource)
final customTransactionCategoryLocalDataSourceProvider =
    AutoDisposeProvider<CustomTransactionCategoryLocalDataSource>.internal(
  customTransactionCategoryLocalDataSource,
  name: r'customTransactionCategoryLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customTransactionCategoryLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CustomTransactionCategoryLocalDataSourceRef
    = AutoDisposeProviderRef<CustomTransactionCategoryLocalDataSource>;
String _$customTransactionCategoriesByTypeHash() =>
    r'5b5531e90176b9b12a6503f0010129533e7294cc';

/// 타입별 사용자 정의 카테고리 목록 Provider
///
/// Copied from [customTransactionCategoriesByType].
@ProviderFor(customTransactionCategoriesByType)
const customTransactionCategoriesByTypeProvider =
    CustomTransactionCategoriesByTypeFamily();

/// 타입별 사용자 정의 카테고리 목록 Provider
///
/// Copied from [customTransactionCategoriesByType].
class CustomTransactionCategoriesByTypeFamily
    extends Family<AsyncValue<List<CustomTransactionCategoryModel>>> {
  /// 타입별 사용자 정의 카테고리 목록 Provider
  ///
  /// Copied from [customTransactionCategoriesByType].
  const CustomTransactionCategoriesByTypeFamily();

  /// 타입별 사용자 정의 카테고리 목록 Provider
  ///
  /// Copied from [customTransactionCategoriesByType].
  CustomTransactionCategoriesByTypeProvider call(
    TransactionType type,
  ) {
    return CustomTransactionCategoriesByTypeProvider(
      type,
    );
  }

  @override
  CustomTransactionCategoriesByTypeProvider getProviderOverride(
    covariant CustomTransactionCategoriesByTypeProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'customTransactionCategoriesByTypeProvider';
}

/// 타입별 사용자 정의 카테고리 목록 Provider
///
/// Copied from [customTransactionCategoriesByType].
class CustomTransactionCategoriesByTypeProvider
    extends AutoDisposeFutureProvider<List<CustomTransactionCategoryModel>> {
  /// 타입별 사용자 정의 카테고리 목록 Provider
  ///
  /// Copied from [customTransactionCategoriesByType].
  CustomTransactionCategoriesByTypeProvider(
    TransactionType type,
  ) : this._internal(
          (ref) => customTransactionCategoriesByType(
            ref as CustomTransactionCategoriesByTypeRef,
            type,
          ),
          from: customTransactionCategoriesByTypeProvider,
          name: r'customTransactionCategoriesByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customTransactionCategoriesByTypeHash,
          dependencies: CustomTransactionCategoriesByTypeFamily._dependencies,
          allTransitiveDependencies: CustomTransactionCategoriesByTypeFamily
              ._allTransitiveDependencies,
          type: type,
        );

  CustomTransactionCategoriesByTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final TransactionType type;

  @override
  Override overrideWith(
    FutureOr<List<CustomTransactionCategoryModel>> Function(
            CustomTransactionCategoriesByTypeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomTransactionCategoriesByTypeProvider._internal(
        (ref) => create(ref as CustomTransactionCategoriesByTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CustomTransactionCategoryModel>>
      createElement() {
    return _CustomTransactionCategoriesByTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomTransactionCategoriesByTypeProvider &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CustomTransactionCategoriesByTypeRef
    on AutoDisposeFutureProviderRef<List<CustomTransactionCategoryModel>> {
  /// The parameter `type` of this provider.
  TransactionType get type;
}

class _CustomTransactionCategoriesByTypeProviderElement
    extends AutoDisposeFutureProviderElement<
        List<CustomTransactionCategoryModel>>
    with CustomTransactionCategoriesByTypeRef {
  _CustomTransactionCategoriesByTypeProviderElement(super.provider);

  @override
  TransactionType get type =>
      (origin as CustomTransactionCategoriesByTypeProvider).type;
}

String _$filteredTransactionsByTypeHash() =>
    r'2662d66d69aed50a54c6d970d55f6ed32cd3b504';

/// 필터링된 거래 목록 Provider (선택된 연월 + 결제수단 필터)
///
/// Copied from [filteredTransactionsByType].
@ProviderFor(filteredTransactionsByType)
const filteredTransactionsByTypeProvider = FilteredTransactionsByTypeFamily();

/// 필터링된 거래 목록 Provider (선택된 연월 + 결제수단 필터)
///
/// Copied from [filteredTransactionsByType].
class FilteredTransactionsByTypeFamily
    extends Family<AsyncValue<List<TransactionModel>>> {
  /// 필터링된 거래 목록 Provider (선택된 연월 + 결제수단 필터)
  ///
  /// Copied from [filteredTransactionsByType].
  const FilteredTransactionsByTypeFamily();

  /// 필터링된 거래 목록 Provider (선택된 연월 + 결제수단 필터)
  ///
  /// Copied from [filteredTransactionsByType].
  FilteredTransactionsByTypeProvider call(
    TransactionType type,
  ) {
    return FilteredTransactionsByTypeProvider(
      type,
    );
  }

  @override
  FilteredTransactionsByTypeProvider getProviderOverride(
    covariant FilteredTransactionsByTypeProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'filteredTransactionsByTypeProvider';
}

/// 필터링된 거래 목록 Provider (선택된 연월 + 결제수단 필터)
///
/// Copied from [filteredTransactionsByType].
class FilteredTransactionsByTypeProvider
    extends AutoDisposeFutureProvider<List<TransactionModel>> {
  /// 필터링된 거래 목록 Provider (선택된 연월 + 결제수단 필터)
  ///
  /// Copied from [filteredTransactionsByType].
  FilteredTransactionsByTypeProvider(
    TransactionType type,
  ) : this._internal(
          (ref) => filteredTransactionsByType(
            ref as FilteredTransactionsByTypeRef,
            type,
          ),
          from: filteredTransactionsByTypeProvider,
          name: r'filteredTransactionsByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredTransactionsByTypeHash,
          dependencies: FilteredTransactionsByTypeFamily._dependencies,
          allTransitiveDependencies:
              FilteredTransactionsByTypeFamily._allTransitiveDependencies,
          type: type,
        );

  FilteredTransactionsByTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final TransactionType type;

  @override
  Override overrideWith(
    FutureOr<List<TransactionModel>> Function(
            FilteredTransactionsByTypeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredTransactionsByTypeProvider._internal(
        (ref) => create(ref as FilteredTransactionsByTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TransactionModel>> createElement() {
    return _FilteredTransactionsByTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredTransactionsByTypeProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredTransactionsByTypeRef
    on AutoDisposeFutureProviderRef<List<TransactionModel>> {
  /// The parameter `type` of this provider.
  TransactionType get type;
}

class _FilteredTransactionsByTypeProviderElement
    extends AutoDisposeFutureProviderElement<List<TransactionModel>>
    with FilteredTransactionsByTypeRef {
  _FilteredTransactionsByTypeProviderElement(super.provider);

  @override
  TransactionType get type =>
      (origin as FilteredTransactionsByTypeProvider).type;
}

String _$paymentMethodMonthlyUsageHash() =>
    r'42fe15b3bf9d0e88baea957c831fd6a3d19a3509';

/// 결제 수단별 이번 달 사용금액 Provider
///
/// Copied from [paymentMethodMonthlyUsage].
@ProviderFor(paymentMethodMonthlyUsage)
final paymentMethodMonthlyUsageProvider =
    AutoDisposeFutureProvider<Map<int, int>>.internal(
  paymentMethodMonthlyUsage,
  name: r'paymentMethodMonthlyUsageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentMethodMonthlyUsageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PaymentMethodMonthlyUsageRef
    = AutoDisposeFutureProviderRef<Map<int, int>>;
String _$incomeAddedNotifierHash() =>
    r'631eb12ab4a7a3c880b34ad6ddb60a9f10795be4';

/// 소득 추가 이벤트 Provider - 통장 쪼개기 연계용
///
/// Copied from [IncomeAddedNotifier].
@ProviderFor(IncomeAddedNotifier)
final incomeAddedNotifierProvider = AutoDisposeNotifierProvider<
    IncomeAddedNotifier, IncomeAddedEvent?>.internal(
  IncomeAddedNotifier.new,
  name: r'incomeAddedNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$incomeAddedNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IncomeAddedNotifier = AutoDisposeNotifier<IncomeAddedEvent?>;
String _$paymentMethodFilterHash() =>
    r'844454c8dd466505d252f50257556431d76fe286';

/// 결제 수단별 필터 상태 Provider
///
/// Copied from [PaymentMethodFilter].
@ProviderFor(PaymentMethodFilter)
final paymentMethodFilterProvider =
    AutoDisposeNotifierProvider<PaymentMethodFilter, int?>.internal(
  PaymentMethodFilter.new,
  name: r'paymentMethodFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentMethodFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PaymentMethodFilter = AutoDisposeNotifier<int?>;
String _$customTransactionCategoryNotifierHash() =>
    r'9b576e52c35aa7e8ff1e2f83984aae8e119f4671';

/// 사용자 정의 거래 카테고리 상태 관리 Notifier
///
/// Copied from [CustomTransactionCategoryNotifier].
@ProviderFor(CustomTransactionCategoryNotifier)
final customTransactionCategoryNotifierProvider =
    AutoDisposeAsyncNotifierProvider<CustomTransactionCategoryNotifier,
        List<CustomTransactionCategoryModel>>.internal(
  CustomTransactionCategoryNotifier.new,
  name: r'customTransactionCategoryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customTransactionCategoryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomTransactionCategoryNotifier
    = AutoDisposeAsyncNotifier<List<CustomTransactionCategoryModel>>;
String _$selectedYearMonthNotifierHash() =>
    r'9b2443482864df78637bb0137eb29ab1f7140f6a';

/// 가계부 연월 선택 Notifier
///
/// Copied from [SelectedYearMonthNotifier].
@ProviderFor(SelectedYearMonthNotifier)
final selectedYearMonthNotifierProvider = AutoDisposeNotifierProvider<
    SelectedYearMonthNotifier, SelectedYearMonth>.internal(
  SelectedYearMonthNotifier.new,
  name: r'selectedYearMonthNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedYearMonthNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedYearMonthNotifier = AutoDisposeNotifier<SelectedYearMonth>;
String _$transactionNotifierHash() =>
    r'5486787e903b0317c59f1032b16090d520a26248';

/// 거래 관리 Notifier
///
/// Copied from [TransactionNotifier].
@ProviderFor(TransactionNotifier)
final transactionNotifierProvider = AutoDisposeAsyncNotifierProvider<
    TransactionNotifier, List<TransactionModel>>.internal(
  TransactionNotifier.new,
  name: r'transactionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TransactionNotifier
    = AutoDisposeAsyncNotifier<List<TransactionModel>>;
String _$paymentMethodNotifierHash() =>
    r'e622d081bfb2f240df6645b52d3378fc8727f21a';

/// 결제 수단 관리 Notifier
///
/// Copied from [PaymentMethodNotifier].
@ProviderFor(PaymentMethodNotifier)
final paymentMethodNotifierProvider = AutoDisposeAsyncNotifierProvider<
    PaymentMethodNotifier, List<PaymentMethodModel>>.internal(
  PaymentMethodNotifier.new,
  name: r'paymentMethodNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentMethodNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PaymentMethodNotifier
    = AutoDisposeAsyncNotifier<List<PaymentMethodModel>>;
String _$accountNotifierHash() => r'ffd21f1d34e602632a859058f564b94f574cbe11';

/// 계좌 관리 Notifier
///
/// Copied from [AccountNotifier].
@ProviderFor(AccountNotifier)
final accountNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AccountNotifier, List<AccountModel>>.internal(
  AccountNotifier.new,
  name: r'accountNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AccountNotifier = AutoDisposeAsyncNotifier<List<AccountModel>>;
String _$creditCardNotifierHash() =>
    r'6b0afdb9db80dfe21bbdfd24c5c628457c482126';

/// 신용카드 관리 Notifier
///
/// Copied from [CreditCardNotifier].
@ProviderFor(CreditCardNotifier)
final creditCardNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CreditCardNotifier, List<CreditCardModel>>.internal(
  CreditCardNotifier.new,
  name: r'creditCardNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$creditCardNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreditCardNotifier = AutoDisposeAsyncNotifier<List<CreditCardModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
