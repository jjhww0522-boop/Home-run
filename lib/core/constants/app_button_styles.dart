import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 토스 스타일 버튼 스타일
/// 그라데이션과 입체감이 있는 둥근 버튼
class AppButtonStyles {
  AppButtonStyles._();

  // ============================================
  // 📐 Button Sizes
  // ============================================
  static const double heightSM = 40.0;
  static const double heightMD = 48.0;
  static const double heightLG = 56.0;
  static const double heightXL = 64.0;

  static const double radiusSM = 10.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusFull = 100.0;

  // ============================================
  // 🎨 Primary Button - 그라데이션 버튼
  // ============================================

  /// Primary 버튼 스타일 (그라데이션 + 입체감)
  static ButtonStyle get primary => ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
        ),
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return 0;
          if (states.contains(WidgetState.disabled)) return 0;
          return 4;
        }),
        shadowColor: WidgetStateProperty.all(
          AppColors.primary.withOpacity(0.4),
        ),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray300;
          }
          return AppColors.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray500;
          }
          return Colors.white;
        }),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        overlayColor: WidgetStateProperty.all(
          Colors.white.withOpacity(0.1),
        ),
      );

  /// 작은 Primary 버튼
  static ButtonStyle get primarySmall => primary.copyWith(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  // ============================================
  // ⚪ Secondary Button - 보조 버튼
  // ============================================

  /// Secondary 버튼 스타일 (회색 배경)
  static ButtonStyle get secondary => ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray200;
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.gray300;
          }
          return AppColors.gray100;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray400;
          }
          return AppColors.gray900;
        }),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  // ============================================
  // 🔲 Outlined Button - 테두리 버튼
  // ============================================

  /// Outlined 버튼 스타일
  static ButtonStyle get outlined => ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
            side: const BorderSide(color: AppColors.gray300, width: 1.5),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.gray100;
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray400;
          }
          return AppColors.gray900;
        }),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return const BorderSide(color: AppColors.gray300, width: 1.5);
          }
          return const BorderSide(color: AppColors.gray400, width: 1.5);
        }),
      );

  // ============================================
  // 🔘 Text Button - 텍스트 버튼
  // ============================================

  /// Text 버튼 스타일
  static ButtonStyle get text => ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSM),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.gray100;
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray400;
          }
          return AppColors.primary;
        }),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  // ============================================
  // ❌ Danger Button - 위험 액션 버튼
  // ============================================

  /// Danger 버튼 스타일 (삭제 등)
  static ButtonStyle get danger => ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMD),
          ),
        ),
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return 0;
          return 2;
        }),
        shadowColor: WidgetStateProperty.all(
          AppColors.error.withOpacity(0.3),
        ),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.gray300;
          }
          return AppColors.error;
        }),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  // ============================================
  // 💫 Floating Action Button
  // ============================================

  /// FAB 스타일
  static const FloatingActionButtonThemeData fabTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 4,
    focusElevation: 6,
    hoverElevation: 8,
    splashColor: Colors.white24,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );
}

/// 그라데이션 버튼 위젯
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final Gradient? gradient;
  final BorderRadius? borderRadius;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 52,
    this.gradient,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: isEnabled
            ? (gradient ?? AppColors.primaryButtonGradient)
            : null,
        color: isEnabled ? null : AppColors.gray300,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isEnabled ? Colors.white : AppColors.gray500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// 아이콘 버튼 위젯 (토스 스타일)
class TossIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double size;
  final double iconSize;

  const TossIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size = 44,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor ?? AppColors.gray700,
            ),
          ),
        ),
      ),
    );
  }
}

/// 칩 버튼 위젯 (토스 스타일)
class TossChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final IconData? icon;

  const TossChipButton({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.selectedColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = selectedColor ?? AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.12) : AppColors.gray100,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: color.withOpacity(0.5), width: 1)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? color : AppColors.gray600,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? color : AppColors.gray700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
