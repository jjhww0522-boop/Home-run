import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_strings.dart';
import 'core/constants/app_button_styles.dart';
import 'presentation/routes/app_router.dart';

/// 홈런 앱 루트 위젯
/// 토스 스타일 - 미니멀하고 깔끔한 디자인
class HomeRunApp extends ConsumerWidget {
  const HomeRunApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // 라우터 설정
      routerConfig: AppRouter.router,

      // 한국어 로케일 설정
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Material 3 테마 설정 (토스 스타일)
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),

        // 폰트 설정
        fontFamily: 'Pretendard',

        // 스캐폴드 배경색
        scaffoldBackgroundColor: AppColors.background,

        // AppBar 테마 - 토스 스타일 (깔끔하게)
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.gray900,
          ),
          iconTheme: IconThemeData(
            color: AppColors.gray900,
            size: 24,
          ),
        ),

        // 카드 테마 - 부드러운 그림자
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.black.withOpacity(0.08),
        ),

        // Elevated 버튼 테마 - 그라데이션 스타일
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppButtonStyles.primary,
        ),

        // Outlined 버튼 테마
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: AppButtonStyles.outlined,
        ),

        // Text 버튼 테마
        textButtonTheme: TextButtonThemeData(
          style: AppButtonStyles.text,
        ),

        // FAB 테마
        floatingActionButtonTheme: AppButtonStyles.fabTheme,

        // 칩 테마
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.gray100,
          selectedColor: AppColors.primary.withOpacity(0.12),
          labelStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.gray700,
          ),
          secondaryLabelStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // 입력 필드 테마
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.gray100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.gray400,
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.gray600,
          ),
        ),

        // 바텀 시트 테마
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          showDragHandle: true,
          dragHandleColor: AppColors.gray300,
          dragHandleSize: Size(40, 4),
        ),

        // 다이얼로그 테마
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.surface,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titleTextStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.gray900,
          ),
          contentTextStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.gray700,
          ),
        ),

        // 스낵바 테마
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.gray900,
          contentTextStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 4,
        ),

        // 탭바 테마
        tabBarTheme: TabBarThemeData(
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.gray500,
          labelStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
        ),

        // 하단 네비게이션 바 테마
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.gray400,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),

        // Divider 테마
        dividerTheme: const DividerThemeData(
          color: AppColors.gray200,
          thickness: 1,
          space: 1,
        ),

        // 프로그레스 인디케이터 테마
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
          linearTrackColor: AppColors.gray200,
          circularTrackColor: AppColors.gray200,
        ),

        // 스위치 테마
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return AppColors.gray400;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.gray200;
          }),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),

        // 체크박스 테마
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(color: AppColors.gray400, width: 2),
        ),

        // 라디오 테마
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.gray400;
          }),
        ),

        // 날짜 선택기 테마 (한글화 + 예쁜 디자인)
        datePickerTheme: DatePickerThemeData(
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 8,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          // 헤더 스타일
          headerBackgroundColor: AppColors.primary,
          headerForegroundColor: Colors.white,
          headerHeadlineStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          headerHelpStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
          // 요일 스타일
          weekdayStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.gray500,
          ),
          // 일반 날짜 스타일
          dayStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          // 선택된 날짜 스타일
          dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return null;
          }),
          dayForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            if (states.contains(WidgetState.disabled)) {
              return AppColors.gray300;
            }
            return AppColors.textPrimary;
          }),
          dayOverlayColor: WidgetStateProperty.all(
            AppColors.primary.withOpacity(0.12),
          ),
          // 오늘 날짜 스타일
          todayBackgroundColor: WidgetStateProperty.all(Colors.transparent),
          todayForegroundColor: WidgetStateProperty.all(AppColors.primary),
          todayBorder: const BorderSide(color: AppColors.primary, width: 2),
          // 연도 선택 스타일
          yearStyle: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return null;
          }),
          yearForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return AppColors.textPrimary;
          }),
          yearOverlayColor: WidgetStateProperty.all(
            AppColors.primary.withOpacity(0.12),
          ),
          // 취소/확인 버튼 스타일
          cancelButtonStyle: TextButton.styleFrom(
            foregroundColor: AppColors.gray600,
            textStyle: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          confirmButtonStyle: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          // 입력 모드 전환 버튼 숨기기
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.gray100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
