import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// 야구장 모양 목표 달성률 차트
class BaseballProgressChart extends StatelessWidget {
  final double progressPercent;
  final String targetName;

  const BaseballProgressChart({
    super.key,
    required this.progressPercent,
    required this.targetName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('⚾', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  const Text(
                    '목표 달성률',
                    style: TextStyle(
                      fontSize: AppSizes.fontM,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingS,
                  vertical: AppSizes.paddingXS,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
                child: Text(
                  targetName,
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontSize: AppSizes.fontXS,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingS),

          // 야구장 다이아몬드
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 150,
              child: CustomPaint(
                painter: _BaseballDiamondPainter(progressPercent: progressPercent),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${progressPercent.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      Text(
                        _getProgressMessage(progressPercent),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
          ),

          const SizedBox(height: AppSizes.paddingS),

          // 베이스 범례
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBaseLegend('🏠', '홈', 0),
                _buildBaseLegend('1️⃣', '1루', 25),
                _buildBaseLegend('2️⃣', '2루', 50),
                _buildBaseLegend('3️⃣', '3루', 75),
                _buildBaseLegend('🏆', '홈런', 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getProgressMessage(double percent) {
    if (percent >= 100) return '홈런 달성! 🎉';
    if (percent >= 75) return '3루! 거의 다 왔어요!';
    if (percent >= 50) return '2루! 절반 달성!';
    if (percent >= 25) return '1루! 좋은 출발!';
    return '출발! 화이팅!';
  }

  Widget _buildBaseLegend(String emoji, String label, double threshold) {
    final isReached = progressPercent >= threshold;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          emoji,
          style: TextStyle(
            fontSize: 12,
            color: isReached ? null : Colors.grey,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: isReached ? const Color(0xFF1B5E20) : AppColors.textTertiary,
            fontWeight: isReached ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _BaseballDiamondPainter extends CustomPainter {
  final double progressPercent;

  _BaseballDiamondPainter({required this.progressPercent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseDistance = size.height * 0.32;

    // 베이스 위치 (다이아몬드 형태)
    final homeBase = Offset(center.dx, center.dy + baseDistance);
    final firstBase = Offset(center.dx + baseDistance, center.dy);
    final secondBase = Offset(center.dx, center.dy - baseDistance);
    final thirdBase = Offset(center.dx - baseDistance, center.dy);

    // 외야 (진한 초록)
    final outfieldPaint = Paint()
      ..color = const Color(0xFF4CAF50);

    canvas.drawCircle(center, baseDistance * 1.45, outfieldPaint);

    // 내야 잔디 (밝은 초록)
    final infieldGrassPaint = Paint()
      ..color = const Color(0xFF66BB6A);

    final diamondPath = Path()
      ..moveTo(homeBase.dx, homeBase.dy)
      ..lineTo(firstBase.dx, firstBase.dy)
      ..lineTo(secondBase.dx, secondBase.dy)
      ..lineTo(thirdBase.dx, thirdBase.dy)
      ..close();

    canvas.drawPath(diamondPath, infieldGrassPaint);

    // 내야 흙 (베이스 주변)
    final dirtPaint = Paint()
      ..color = const Color(0xFFD7CCC8);

    // 홈 플레이트 주변 흙
    canvas.drawCircle(homeBase, 14, dirtPaint);
    // 투수 마운드
    canvas.drawCircle(center, 8, dirtPaint);
    // 각 베이스 주변 흙
    canvas.drawCircle(firstBase, 10, dirtPaint);
    canvas.drawCircle(secondBase, 10, dirtPaint);
    canvas.drawCircle(thirdBase, 10, dirtPaint);

    // 베이스 라인 (흰색)
    final baseLinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(homeBase, firstBase, baseLinePaint);
    canvas.drawLine(firstBase, secondBase, baseLinePaint);
    canvas.drawLine(secondBase, thirdBase, baseLinePaint);
    canvas.drawLine(thirdBase, homeBase, baseLinePaint);

    // 파울 라인 연장
    final foulLinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 1루 방향 파울 라인
    final foulLine1End = Offset(
      homeBase.dx + (firstBase.dx - homeBase.dx) * 1.8,
      homeBase.dy + (firstBase.dy - homeBase.dy) * 1.8,
    );
    canvas.drawLine(homeBase, foulLine1End, foulLinePaint);

    // 3루 방향 파울 라인
    final foulLine3End = Offset(
      homeBase.dx + (thirdBase.dx - homeBase.dx) * 1.8,
      homeBase.dy + (thirdBase.dy - homeBase.dy) * 1.8,
    );
    canvas.drawLine(homeBase, foulLine3End, foulLinePaint);

    // 활성화된 경로 (진행률)
    final activeLinePaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    _drawActivePath(canvas, homeBase, firstBase, secondBase, thirdBase, activeLinePaint);

    // 베이스 그리기
    _drawBase(canvas, homeBase, 0, isHome: true);
    _drawBase(canvas, firstBase, 25);
    _drawBase(canvas, secondBase, 50);
    _drawBase(canvas, thirdBase, 75);

    // 투수 마운드 표시
    final moundPaint = Paint()
      ..color = const Color(0xFFBCAAA4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 4, moundPaint);

    // 주자 위치 표시
    _drawRunner(canvas, homeBase, firstBase, secondBase, thirdBase);
  }

  void _drawActivePath(Canvas canvas, Offset home, Offset first, Offset second, Offset third, Paint paint) {
    if (progressPercent <= 0) return;

    final path = Path()..moveTo(home.dx, home.dy);

    if (progressPercent >= 25) {
      path.lineTo(first.dx, first.dy);
    } else {
      final t = progressPercent / 25;
      path.lineTo(
        home.dx + (first.dx - home.dx) * t,
        home.dy + (first.dy - home.dy) * t,
      );
      canvas.drawPath(path, paint);
      return;
    }

    if (progressPercent >= 50) {
      path.lineTo(second.dx, second.dy);
    } else {
      final t = (progressPercent - 25) / 25;
      path.lineTo(
        first.dx + (second.dx - first.dx) * t,
        first.dy + (second.dy - first.dy) * t,
      );
      canvas.drawPath(path, paint);
      return;
    }

    if (progressPercent >= 75) {
      path.lineTo(third.dx, third.dy);
    } else {
      final t = (progressPercent - 50) / 25;
      path.lineTo(
        second.dx + (third.dx - second.dx) * t,
        second.dy + (third.dy - second.dy) * t,
      );
      canvas.drawPath(path, paint);
      return;
    }

    if (progressPercent >= 100) {
      path.lineTo(home.dx, home.dy);
    } else {
      final t = (progressPercent - 75) / 25;
      path.lineTo(
        third.dx + (home.dx - third.dx) * t,
        third.dy + (home.dy - third.dy) * t,
      );
    }

    canvas.drawPath(path, paint);
  }

  void _drawBase(Canvas canvas, Offset position, double threshold, {bool isHome = false}) {
    final isReached = progressPercent >= threshold;
    final baseSize = isHome ? 10.0 : 8.0;

    if (isHome) {
      // 홈 베이스 (오각형)
      final homePath = Path();
      homePath.moveTo(position.dx, position.dy - baseSize * 0.7);
      homePath.lineTo(position.dx + baseSize * 0.6, position.dy - baseSize * 0.2);
      homePath.lineTo(position.dx + baseSize * 0.6, position.dy + baseSize * 0.4);
      homePath.lineTo(position.dx - baseSize * 0.6, position.dy + baseSize * 0.4);
      homePath.lineTo(position.dx - baseSize * 0.6, position.dy - baseSize * 0.2);
      homePath.close();

      final basePaint = Paint()
        ..color = isReached ? const Color(0xFFFFD700) : Colors.white
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = isReached ? const Color(0xFFFF8F00) : Colors.grey.shade400
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawPath(homePath, basePaint);
      canvas.drawPath(homePath, borderPaint);
    } else {
      // 일반 베이스 (다이아몬드 형태)
      canvas.save();
      canvas.translate(position.dx, position.dy);
      canvas.rotate(math.pi / 4);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: baseSize,
        height: baseSize,
      );

      final basePaint = Paint()
        ..color = isReached ? const Color(0xFFFFD700) : Colors.white
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = isReached ? const Color(0xFFFF8F00) : Colors.grey.shade400
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(2));
      canvas.drawRRect(rrect, basePaint);
      canvas.drawRRect(rrect, borderPaint);
      canvas.restore();
    }
  }

  void _drawRunner(Canvas canvas, Offset home, Offset first, Offset second, Offset third) {
    Offset runnerPosition;

    if (progressPercent >= 100) {
      runnerPosition = home;
    } else if (progressPercent >= 75) {
      final t = (progressPercent - 75) / 25;
      runnerPosition = Offset(
        third.dx + (home.dx - third.dx) * t,
        third.dy + (home.dy - third.dy) * t,
      );
    } else if (progressPercent >= 50) {
      final t = (progressPercent - 50) / 25;
      runnerPosition = Offset(
        second.dx + (third.dx - second.dx) * t,
        second.dy + (third.dy - second.dy) * t,
      );
    } else if (progressPercent >= 25) {
      final t = (progressPercent - 25) / 25;
      runnerPosition = Offset(
        first.dx + (second.dx - first.dx) * t,
        first.dy + (second.dy - first.dy) * t,
      );
    } else {
      final t = progressPercent / 25;
      runnerPosition = Offset(
        home.dx + (first.dx - home.dx) * t,
        home.dy + (first.dy - home.dy) * t,
      );
    }

    // 그림자
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawCircle(runnerPosition + const Offset(1, 1), 6, shadowPaint);

    // 야구공
    final ballPaint = Paint()..color = Colors.white;
    canvas.drawCircle(runnerPosition, 6, ballPaint);

    // 야구공 테두리
    final ballBorderPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(runnerPosition, 6, ballBorderPaint);

    // 야구공 실밥 (빨간색)
    final stitchPaint = Paint()
      ..color = const Color(0xFFE53935)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: runnerPosition, radius: 3),
      -0.8,
      1.6,
      false,
      stitchPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: runnerPosition, radius: 3),
      2.3,
      1.6,
      false,
      stitchPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _BaseballDiamondPainter oldDelegate) {
    return oldDelegate.progressPercent != progressPercent;
  }
}
