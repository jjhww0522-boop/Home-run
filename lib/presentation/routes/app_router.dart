import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../pages/account_page.dart';
import '../pages/credit_card_page.dart';
import '../pages/fixed_expense_page.dart';

/// 앱 라우터 설정
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // 스플래시 화면
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      // 메인 홈 화면
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      // 계좌 관리
      GoRoute(
        path: '/accounts',
        name: 'accounts',
        builder: (context, state) => const AccountPage(),
      ),
      // 신용카드 관리
      GoRoute(
        path: '/credit-cards',
        name: 'credit-cards',
        builder: (context, state) => const CreditCardPage(),
      ),
      // 고정비 관리
      GoRoute(
        path: '/fixed-expenses',
        name: 'fixed-expenses',
        builder: (context, state) => const FixedExpensePage(),
      ),
      // TODO: 추가 라우트들
      // - /assets: 자산 관리
      // - /assets/add: 자산 추가
      // - /debts: 부채 관리
      // - /goal: 목표 설정
      // - /statistics: 통계
      // - /settings: 설정
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('페이지를 찾을 수 없습니다: ${state.uri}'),
      ),
    ),
  );
}
