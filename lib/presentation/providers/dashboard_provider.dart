import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/models_stub.dart'
    if (dart.library.io) '../../data/models/models.dart';
import 'ledger_provider.dart';

part 'dashboard_provider.g.dart';

/// 대시보드 설정 모델
class DashboardSettings {
  final int monthlyLivingExpense;  // 월 생활비
  final int emergencyFundMonths;   // 비상금 목표 개월수
  final int currentEmergencyFund;  // 현재 비상금
  final String carName;            // 차량명
  final int averageFuelCost;       // 평균 주유비
  final int virtualSavings;        // 가상 저금통 누적액

  DashboardSettings({
    this.monthlyLivingExpense = 2500000,  // 기본 250만원
    this.emergencyFundMonths = 3,
    this.currentEmergencyFund = 0,
    this.carName = '아이오닉 하이브리드',
    this.averageFuelCost = 150000,        // 기본 15만원
    this.virtualSavings = 0,
  });

  int get targetEmergencyFund => monthlyLivingExpense * emergencyFundMonths;
  double get emergencyFundProgress =>
    targetEmergencyFund > 0 ? (currentEmergencyFund / targetEmergencyFund * 100).clamp(0, 100) : 0;

  DashboardSettings copyWith({
    int? monthlyLivingExpense,
    int? emergencyFundMonths,
    int? currentEmergencyFund,
    String? carName,
    int? averageFuelCost,
    int? virtualSavings,
  }) {
    return DashboardSettings(
      monthlyLivingExpense: monthlyLivingExpense ?? this.monthlyLivingExpense,
      emergencyFundMonths: emergencyFundMonths ?? this.emergencyFundMonths,
      currentEmergencyFund: currentEmergencyFund ?? this.currentEmergencyFund,
      carName: carName ?? this.carName,
      averageFuelCost: averageFuelCost ?? this.averageFuelCost,
      virtualSavings: virtualSavings ?? this.virtualSavings,
    );
  }
}

/// 대시보드 설정 Notifier
@riverpod
class DashboardSettingsNotifier extends _$DashboardSettingsNotifier {
  @override
  DashboardSettings build() {
    return DashboardSettings(
      monthlyLivingExpense: 2500000,
      emergencyFundMonths: 3,
      currentEmergencyFund: 5000000,  // 예시: 500만원
      carName: '아이오닉 하이브리드',
      averageFuelCost: 150000,
      virtualSavings: 0,
    );
  }

  void updateLivingExpense(int amount) {
    state = state.copyWith(monthlyLivingExpense: amount);
  }

  void updateEmergencyFund(int amount) {
    state = state.copyWith(currentEmergencyFund: amount);
  }

  void updateAverageFuelCost(int amount) {
    state = state.copyWith(averageFuelCost: amount);
  }

  void addToVirtualSavings(int amount) {
    state = state.copyWith(virtualSavings: state.virtualSavings + amount);
  }

  void resetVirtualSavings() {
    state = state.copyWith(virtualSavings: 0);
  }
}

/// 이번 달 주유비 계산 Provider
@riverpod
Future<int> thisMonthFuelCost(Ref ref) async {
  final dataSource = ref.watch(transactionLocalDataSourceProvider);
  final now = DateTime.now();
  final transactions = await dataSource.getByMonth(now.year, now.month);

  // 교통비 카테고리 중 주유 관련 거래 필터링
  final fuelTransactions = transactions.where((t) =>
      t.type == TransactionType.expense &&
      t.category == TransactionCategory.transport &&
      (t.description?.contains('주유') == true ||
       t.description?.contains('충전') == true ||
       t.description?.contains('기름') == true ||
       t.description?.contains('연료') == true));

  return fuelTransactions.fold<int>(0, (sum, t) => sum + t.amount);
}

/// 주유비 절약액 계산 Provider
@riverpod
Future<FuelSavingsData> fuelSavings(Ref ref) async {
  final settings = ref.watch(dashboardSettingsNotifierProvider);
  final thisMonthCost = await ref.watch(thisMonthFuelCostProvider.future);

  final savings = settings.averageFuelCost - thisMonthCost;
  final hasSavings = savings > 0;

  return FuelSavingsData(
    thisMonthCost: thisMonthCost,
    averageCost: settings.averageFuelCost,
    savings: hasSavings ? savings : 0,
    hasSavings: hasSavings,
    carName: settings.carName,
  );
}

/// 주유비 절약 데이터
class FuelSavingsData {
  final int thisMonthCost;
  final int averageCost;
  final int savings;
  final bool hasSavings;
  final String carName;

  FuelSavingsData({
    required this.thisMonthCost,
    required this.averageCost,
    required this.savings,
    required this.hasSavings,
    required this.carName,
  });
}

/// 이달의 성적표 데이터
class MonthlyReportData {
  final int totalIncome;      // 수입 합계
  final int totalExpense;     // 지출 합계
  final int totalSavings;     // 저축/투자 합계 (순자산 증가분)
  final int netChange;        // 순수익 (수입 - 지출)
  final int year;
  final int month;

  MonthlyReportData({
    required this.totalIncome,
    required this.totalExpense,
    required this.totalSavings,
    required this.netChange,
    required this.year,
    required this.month,
  });
}

/// 이달의 성적표 Provider
@riverpod
Future<MonthlyReportData> monthlyReport(Ref ref) async {
  // transactionNotifier를 watch하여 거래 변경 시 자동 갱신
  ref.watch(transactionNotifierProvider);

  final dataSource = ref.watch(transactionLocalDataSourceProvider);
  final now = DateTime.now();
  final transactions = await dataSource.getByMonth(now.year, now.month);

  // 수입 합계
  final totalIncome = transactions
      .where((t) => t.type == TransactionType.income)
      .fold<int>(0, (sum, t) => sum + t.amount);

  // 지출 합계
  final totalExpense = transactions
      .where((t) => t.type == TransactionType.expense)
      .fold<int>(0, (sum, t) => sum + t.amount);

  // 저축/투자 합계 (순자산 증가분)
  final totalSavings = transactions
      .where((t) => t.type == TransactionType.transfer)
      .fold<int>(0, (sum, t) => sum + t.amount);

  // 순수익 (수입 - 지출)
  final netChange = totalIncome - totalExpense;

  return MonthlyReportData(
    totalIncome: totalIncome,
    totalExpense: totalExpense,
    totalSavings: totalSavings,
    netChange: netChange,
    year: now.year,
    month: now.month,
  );
}
