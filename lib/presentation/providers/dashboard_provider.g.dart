// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$thisMonthFuelCostHash() => r'99f3397502e3b6db9b0223190a60bb66ed134a55';

/// 이번 달 주유비 계산 Provider
///
/// Copied from [thisMonthFuelCost].
@ProviderFor(thisMonthFuelCost)
final thisMonthFuelCostProvider = AutoDisposeFutureProvider<int>.internal(
  thisMonthFuelCost,
  name: r'thisMonthFuelCostProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$thisMonthFuelCostHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ThisMonthFuelCostRef = AutoDisposeFutureProviderRef<int>;
String _$fuelSavingsHash() => r'cc2fc82802aad9937115f6ad5583c99c7d634f66';

/// 주유비 절약액 계산 Provider
///
/// Copied from [fuelSavings].
@ProviderFor(fuelSavings)
final fuelSavingsProvider = AutoDisposeFutureProvider<FuelSavingsData>.internal(
  fuelSavings,
  name: r'fuelSavingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fuelSavingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FuelSavingsRef = AutoDisposeFutureProviderRef<FuelSavingsData>;
String _$monthlyReportHash() => r'fce1f90394260afe31d3889c0836e870ee521f10';

/// 이달의 성적표 Provider
///
/// Copied from [monthlyReport].
@ProviderFor(monthlyReport)
final monthlyReportProvider =
    AutoDisposeFutureProvider<MonthlyReportData>.internal(
  monthlyReport,
  name: r'monthlyReportProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$monthlyReportHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MonthlyReportRef = AutoDisposeFutureProviderRef<MonthlyReportData>;
String _$dashboardSettingsNotifierHash() =>
    r'46c5e9b085b8c3c7e0867f482bd8943879d853b1';

/// 대시보드 설정 Notifier
///
/// Copied from [DashboardSettingsNotifier].
@ProviderFor(DashboardSettingsNotifier)
final dashboardSettingsNotifierProvider = AutoDisposeNotifierProvider<
    DashboardSettingsNotifier, DashboardSettings>.internal(
  DashboardSettingsNotifier.new,
  name: r'dashboardSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DashboardSettingsNotifier = AutoDisposeNotifier<DashboardSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
