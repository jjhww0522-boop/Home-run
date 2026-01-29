import 'package:intl/intl.dart';

/// 홈런 인사이트 - 거래가 목표에 미치는 영향 계산
class HomeRunInsightService {
  /// 월 평균 저축액 (예상)
  static const int _averageMonthlySaving = 2000000; // 200만원

  /// 목표까지 남은 금액과 월 저축액을 기반으로 예상 달성일 계산
  static DateTime calculateGoalDate(int remainingAmount) {
    if (remainingAmount <= 0) return DateTime.now();
    final monthsToGoal = (remainingAmount / _averageMonthlySaving).ceil();
    return DateTime.now().add(Duration(days: monthsToGoal * 30));
  }

  /// 지출이 목표에 미치는 영향 (지연 일수) 계산
  static int calculateExpenseImpact(int expenseAmount) {
    // 지출액 / 일평균 저축액 = 지연 일수
    final dailySaving = _averageMonthlySaving / 30;
    return (expenseAmount / dailySaving).round();
  }

  /// 저축이 목표에 미치는 영향 (단축 일수) 계산
  static int calculateSavingImpact(int savingAmount) {
    final dailySaving = _averageMonthlySaving / 30;
    return (savingAmount / dailySaving).round();
  }

  /// 지출 피드백 메시지 생성
  static HomeRunInsight? getExpenseInsight(int amount) {
    if (amount < 50000) return null; // 5만원 미만은 표시 안함

    final delayDays = calculateExpenseImpact(amount);

    if (delayDays <= 0) return null;

    String message;
    InsightType type;

    if (delayDays >= 7) {
      message = '이 지출로 홈런 달성이\n약 ${delayDays}일 늦춰져요 😥';
      type = InsightType.warning;
    } else if (delayDays >= 3) {
      message = '이 지출로 홈런 달성이\n약 ${delayDays}일 늦춰져요';
      type = InsightType.caution;
    } else {
      message = '홈런까지 ${delayDays}일 늦춰지지만\n가끔은 필요한 지출이에요 💪';
      type = InsightType.neutral;
    }

    return HomeRunInsight(
      message: message,
      type: type,
      impactDays: delayDays,
    );
  }

  /// 저축 피드백 메시지 생성
  static HomeRunInsight? getSavingInsight(int amount) {
    if (amount < 10000) return null; // 1만원 미만은 표시 안함

    final shortenDays = calculateSavingImpact(amount);

    if (shortenDays <= 0) return null;

    String message;

    if (shortenDays >= 7) {
      message = '홈런에 ${shortenDays}일 더 가까워졌어요! 🏠🎉';
    } else if (shortenDays >= 3) {
      message = '홈런에 ${shortenDays}일 가까워졌어요! ⚾';
    } else {
      message = '작은 저축도 홈런의 시작이에요! 🌱';
    }

    return HomeRunInsight(
      message: message,
      type: InsightType.positive,
      impactDays: shortenDays,
    );
  }

  /// 수입 피드백 메시지 생성
  static HomeRunInsight? getIncomeInsight(int amount) {
    final shortenDays = calculateSavingImpact(amount);

    String message;

    if (shortenDays >= 30) {
      message = '이 수입으로 홈런에\n약 ${(shortenDays / 30).round()}개월 가까워졌어요! 🚀';
    } else if (shortenDays >= 7) {
      message = '홈런까지 ${shortenDays}일 단축! 💰';
    } else {
      return null; // 작은 금액은 표시 안함
    }

    return HomeRunInsight(
      message: message,
      type: InsightType.positive,
      impactDays: shortenDays,
    );
  }

  /// 금액 포맷
  static String formatAmount(int amount) {
    if (amount >= 100000000) {
      return '${(amount / 100000000).toStringAsFixed(1)}억원';
    } else if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)}천만원';
    } else if (amount >= 10000) {
      return '${NumberFormat('#,###').format(amount ~/ 10000)}만원';
    }
    return '${NumberFormat('#,###').format(amount)}원';
  }
}

/// 인사이트 타입
enum InsightType {
  positive,  // 긍정적 (저축, 수입)
  neutral,   // 중립 (작은 지출)
  caution,   // 주의 (중간 지출)
  warning,   // 경고 (큰 지출)
}

/// 홈런 인사이트 데이터
class HomeRunInsight {
  final String message;
  final InsightType type;
  final int impactDays;

  HomeRunInsight({
    required this.message,
    required this.type,
    required this.impactDays,
  });
}
