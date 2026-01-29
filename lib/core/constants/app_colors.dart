import 'package:flutter/material.dart';

/// 홈런 앱 컬러 팔레트
/// 토스 스타일 - 미니멀하고 깔끔한 디자인
class AppColors {
  AppColors._();

  // ============================================
  // 🎨 Primary - 메인 포인트 컬러 (홈런 그린)
  // ============================================
  static const Color primary = Color(0xFF00C853);      // 밝은 그린
  static const Color primaryLight = Color(0xFF5EFC82); // 연한 그린
  static const Color primaryDark = Color(0xFF009624);  // 진한 그린

  // ============================================
  // ⚫ Grayscale - 무채색 팔레트
  // ============================================
  static const Color gray900 = Color(0xFF191F28);  // 거의 검정
  static const Color gray800 = Color(0xFF333D4B);  // 진한 회색
  static const Color gray700 = Color(0xFF4E5968);  // 어두운 회색
  static const Color gray600 = Color(0xFF6B7684);  // 중간 회색
  static const Color gray500 = Color(0xFF8B95A1);  // 회색
  static const Color gray400 = Color(0xFFB0B8C1);  // 연한 회색
  static const Color gray300 = Color(0xFFD1D6DB);  // 더 연한 회색
  static const Color gray200 = Color(0xFFE5E8EB);  // 배경 회색
  static const Color gray100 = Color(0xFFF2F4F6);  // 밝은 배경
  static const Color gray50 = Color(0xFFF9FAFB);   // 거의 흰색

  // ============================================
  // 🏠 Background & Surface
  // ============================================
  static const Color background = Color(0xFFF9FAFB);   // 앱 배경
  static const Color surface = Color(0xFFFFFFFF);      // 카드/시트 배경
  static const Color surfaceVariant = Color(0xFFF2F4F6); // 입력 필드 배경
  static const Color divider = Color(0xFFE5E8EB);      // 구분선

  // ============================================
  // 📝 Text Colors
  // ============================================
  static const Color textPrimary = Color(0xFF191F28);   // 메인 텍스트
  static const Color textSecondary = Color(0xFF6B7684); // 보조 텍스트
  static const Color textTertiary = Color(0xFFB0B8C1);  // 힌트/비활성 텍스트
  static const Color textOnPrimary = Color(0xFFFFFFFF); // 포인트 컬러 위 텍스트

  // ============================================
  // 🚦 Semantic Colors (최소한으로 사용)
  // ============================================
  static const Color success = Color(0xFF00C853);   // 성공/수입 (primary와 동일)
  static const Color warning = Color(0xFFFF9800);   // 경고 (오렌지)
  static const Color error = Color(0xFFFF5252);     // 에러/지출 (빨강)
  static const Color info = Color(0xFF448AFF);      // 정보 (파랑)

  // ============================================
  // 💰 Ledger Colors (가계부)
  // ============================================
  static const Color ledgerIncome = Color(0xFF00C853);   // 수입 - 그린 (primary)
  static const Color ledgerExpense = Color(0xFFFF5252);  // 지출 - 레드
  static const Color ledgerTransfer = Color(0xFF448AFF); // 이동 - 블루

  static const Color ledgerBackground = Color(0xFFF9FAFB);
  static const Color ledgerSurface = Color(0xFFFFFFFF);
  static const Color ledgerSurfaceVariant = Color(0xFFF2F4F6);

  // ============================================
  // 💳 Asset/Debt Colors
  // ============================================
  static const Color assetDeposit = Color(0xFF448AFF);  // 예금
  static const Color assetSavings = Color(0xFF00C853);  // 적금
  static const Color assetStock = Color(0xFFFF9800);    // 주식
  static const Color assetPension = Color(0xFF7C4DFF);  // 연금
  static const Color assetReal = Color(0xFFE91E63);     // 부동산
  static const Color assetOther = Color(0xFF6B7684);    // 기타

  static const Color debtBank = Color(0xFFFF5252);
  static const Color debtCompany = Color(0xFFFF7043);
  static const Color debtOther = Color(0xFFE53935);

  // ============================================
  // 🎨 Gradients (토스 스타일 - 부드러운 그라데이션)
  // ============================================
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00C853), Color(0xFF69F0AE)],
  );

  static const LinearGradient primaryButtonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF00E676), Color(0xFF00C853)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF5F7FA)],
  );

  // ============================================
  // Legacy support (기존 코드 호환)
  // ============================================
  static const Color secondary = primary;
  static const Color secondaryLight = primaryLight;
  static const Color secondaryDark = primaryDark;
  static const Color accent = Color(0xFFFF9800);
  static const Color accentLight = Color(0xFFFFB74D);
  static const Color accentDark = Color(0xFFF57C00);

  static const LinearGradient successGradient = primaryGradient;
}
