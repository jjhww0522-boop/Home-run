import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 토스 스타일 아이콘 상수
/// 굵고 시원시원한 아이콘 스타일
class AppIcons {
  AppIcons._();

  // ============================================
  // 📐 Icon Sizes - 토스 스타일 (크고 시원하게)
  // ============================================
  static const double sizeXS = 16.0;
  static const double sizeSM = 20.0;
  static const double sizeMD = 24.0;
  static const double sizeLG = 28.0;
  static const double sizeXL = 32.0;
  static const double sizeXXL = 40.0;
  static const double sizeHero = 48.0;

  // ============================================
  // 🎨 Icon Styles - 기본 스타일
  // ============================================

  /// 기본 아이콘 (회색)
  static const IconThemeData defaultStyle = IconThemeData(
    size: sizeMD,
    color: AppColors.gray600,
  );

  /// 강조 아이콘 (Primary)
  static const IconThemeData primaryStyle = IconThemeData(
    size: sizeLG,
    color: AppColors.primary,
  );

  /// 헤더용 대형 아이콘
  static const IconThemeData heroStyle = IconThemeData(
    size: sizeHero,
    color: AppColors.primary,
  );

  // ============================================
  // 🏠 Navigation Icons - 굵은 스타일
  // ============================================
  static const IconData home = Icons.home_rounded;
  static const IconData homeOutlined = Icons.home_outlined;
  static const IconData wallet = Icons.account_balance_wallet_rounded;
  static const IconData walletOutlined = Icons.account_balance_wallet_outlined;
  static const IconData chart = Icons.bar_chart_rounded;
  static const IconData chartOutlined = Icons.bar_chart_outlined;
  static const IconData settings = Icons.settings_rounded;
  static const IconData settingsOutlined = Icons.settings_outlined;
  static const IconData person = Icons.person_rounded;
  static const IconData personOutlined = Icons.person_outline_rounded;

  // ============================================
  // 💰 Ledger Icons - 가계부
  // ============================================
  static const IconData income = Icons.arrow_downward_rounded;
  static const IconData expense = Icons.arrow_upward_rounded;
  static const IconData transfer = Icons.swap_horiz_rounded;
  static const IconData add = Icons.add_rounded;
  static const IconData addCircle = Icons.add_circle_rounded;
  static const IconData calendar = Icons.calendar_today_rounded;
  static const IconData copy = Icons.content_copy_rounded;
  static const IconData delete = Icons.delete_rounded;
  static const IconData edit = Icons.edit_rounded;

  // ============================================
  // 📁 Category Icons - 카테고리 (Rounded 스타일)
  // ============================================
  // 소득
  static const IconData salary = Icons.work_rounded;
  static const IconData bonus = Icons.card_giftcard_rounded;
  static const IconData investment = Icons.trending_up_rounded;
  static const IconData sideJob = Icons.add_business_rounded;
  static const IconData otherIncome = Icons.attach_money_rounded;

  // 지출
  static const IconData food = Icons.restaurant_rounded;
  static const IconData transport = Icons.directions_car_rounded;
  static const IconData housing = Icons.home_rounded;
  static const IconData medical = Icons.local_hospital_rounded;
  static const IconData education = Icons.school_rounded;
  static const IconData culture = Icons.movie_rounded;
  static const IconData clothing = Icons.checkroom_rounded;
  static const IconData shopping = Icons.shopping_cart_rounded;
  static const IconData social = Icons.people_rounded;
  static const IconData financial = Icons.account_balance_rounded;
  static const IconData more = Icons.more_horiz_rounded;

  // 저축/투자
  static const IconData savingsDeposit = Icons.savings_rounded;
  static const IconData stock = Icons.candlestick_chart_rounded;
  static const IconData fund = Icons.pie_chart_rounded;
  static const IconData insurance = Icons.health_and_safety_rounded;
  static const IconData pension = Icons.elderly_rounded;
  static const IconData crypto = Icons.currency_bitcoin_rounded;
  static const IconData otherSavings = Icons.wallet_rounded;

  // ============================================
  // 🎯 Action Icons - 액션
  // ============================================
  static const IconData check = Icons.check_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData chevronRight = Icons.chevron_right_rounded;
  static const IconData chevronLeft = Icons.chevron_left_rounded;
  static const IconData chevronDown = Icons.keyboard_arrow_down_rounded;
  static const IconData chevronUp = Icons.keyboard_arrow_up_rounded;
  static const IconData arrowBack = Icons.arrow_back_rounded;
  static const IconData arrowForward = Icons.arrow_forward_rounded;
  static const IconData refresh = Icons.refresh_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData filter = Icons.filter_list_rounded;
  static const IconData sort = Icons.sort_rounded;
  static const IconData info = Icons.info_rounded;
  static const IconData infoOutlined = Icons.info_outline_rounded;
  static const IconData warning = Icons.warning_rounded;
  static const IconData warningAmber = Icons.warning_amber_rounded;
  static const IconData error = Icons.error_rounded;
  static const IconData success = Icons.check_circle_rounded;
  static const IconData notification = Icons.notifications_rounded;
  static const IconData notificationOutlined = Icons.notifications_outlined;

  // ============================================
  // 🏠 Home Run - 홈런 앱 전용
  // ============================================
  static const IconData homeRun = Icons.sports_baseball_rounded;
  static const IconData target = Icons.gps_fixed_rounded;
  static const IconData savings = Icons.savings_rounded;
  static const IconData rocket = Icons.rocket_launch_rounded;
  static const IconData celebration = Icons.celebration_rounded;
  static const IconData lightbulb = Icons.lightbulb_rounded;
  static const IconData lightbulbOutlined = Icons.lightbulb_outline_rounded;
  static const IconData repeat = Icons.repeat_rounded;
  static const IconData map = Icons.map_rounded;
  static const IconData apartment = Icons.apartment_rounded;
  static const IconData accountBalance = Icons.account_balance_rounded;
  static const IconData splitAccount = Icons.call_split_rounded;

  // ============================================
  // 🔧 Helper Methods
  // ============================================

  /// 카테고리에 맞는 아이콘 반환
  static IconData getCategoryIcon(String categoryName) {
    switch (categoryName) {
      // 소득
      case 'salary': return salary;
      case 'bonus': return bonus;
      case 'investment': return investment;
      case 'sideJob': return sideJob;
      case 'otherIncome': return otherIncome;
      // 지출
      case 'food': return food;
      case 'transport': return transport;
      case 'housing': return housing;
      case 'medical': return medical;
      case 'education': return education;
      case 'culture': return culture;
      case 'clothing': return clothing;
      case 'living': return shopping;
      case 'social': return social;
      case 'financial': return financial;
      // 저축/투자
      case 'savingsDeposit': return savingsDeposit;
      case 'stock': return stock;
      case 'fund': return fund;
      case 'insurance': return insurance;
      case 'pension': return pension;
      case 'crypto': return crypto;
      case 'otherSavings': return otherSavings;
      default: return more;
    }
  }

  /// 굵은 스타일의 아이콘 위젯 생성
  static Icon bold(IconData icon, {Color? color, double? size}) {
    return Icon(
      icon,
      color: color ?? AppColors.gray900,
      size: size ?? sizeLG,
    );
  }

  /// 보조 스타일의 아이콘 위젯 생성
  static Icon muted(IconData icon, {double? size}) {
    return Icon(
      icon,
      color: AppColors.gray500,
      size: size ?? sizeMD,
    );
  }

  /// Primary 컬러 아이콘 위젯 생성
  static Icon primary(IconData icon, {double? size}) {
    return Icon(
      icon,
      color: AppColors.primary,
      size: size ?? sizeLG,
    );
  }
}
