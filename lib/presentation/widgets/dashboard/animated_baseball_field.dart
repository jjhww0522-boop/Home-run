import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';

/// 애니메이션이 있는 야구장 위젯
/// 순자산 달성률에 따라 캐릭터가 1루, 2루, 3루로 이동
class AnimatedBaseballField extends StatefulWidget {
  final double progressPercent;
  final String targetName;
  final int currentAssets;
  final int targetAssets;

  const AnimatedBaseballField({
    super.key,
    required this.progressPercent,
    required this.targetName,
    this.currentAssets = 0,
    this.targetAssets = 0,
  });

  @override
  State<AnimatedBaseballField> createState() => _AnimatedBaseballFieldState();
}

class _AnimatedBaseballFieldState extends State<AnimatedBaseballField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _runnerAnimation;
  double _previousProgress = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _runnerAnimation = Tween<double>(
      begin: 0,
      end: widget.progressPercent,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedBaseballField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progressPercent != widget.progressPercent) {
      _previousProgress = oldWidget.progressPercent;
      _runnerAnimation = Tween<double>(
        begin: _previousProgress,
        end: widget.progressPercent,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getCurrentBase(double progress) {
    if (progress >= 100) return '홈런!';
    if (progress >= 75) return '3루';
    if (progress >= 50) return '2루';
    if (progress >= 25) return '1루';
    return '타석';
  }

  String _getNextMilestone(double progress) {
    if (progress >= 100) return '목표 달성!';
    if (progress >= 75) return '홈런까지 ${(100 - progress).toStringAsFixed(1)}%';
    if (progress >= 50) return '3루까지 ${(75 - progress).toStringAsFixed(1)}%';
    if (progress >= 25) return '2루까지 ${(50 - progress).toStringAsFixed(1)}%';
    return '1루까지 ${(25 - progress).toStringAsFixed(1)}%';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 헤더
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        AppIcons.homeRun,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      '홈런 대시보드',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray900,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.targetName,
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 야구장 필드
          AnimatedBuilder(
            animation: _runnerAnimation,
            builder: (context, child) {
              return SizedBox(
                height: 220,
                child: Stack(
                  children: [
                    // 야구장 그리기
                    CustomPaint(
                      size: const Size(double.infinity, 220),
                      painter: _BaseballFieldPainter(
                        progressPercent: _runnerAnimation.value,
                      ),
                    ),

                    // 중앙 진행률 표시
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${_runnerAnimation.value.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _getCurrentBase(_runnerAnimation.value),
                              style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // 하단 정보
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.08),
                  AppColors.primary.withOpacity(0.03),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                // 베이스 범례
                Expanded(
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
          ),

          // 다음 목표 안내
          AnimatedBuilder(
            animation: _runnerAnimation,
            builder: (context, child) {
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      AppIcons.target,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _getNextMilestone(_runnerAnimation.value),
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray700,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBaseLegend(String emoji, String label, double threshold) {
    final isReached = widget.progressPercent >= threshold;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          emoji,
          style: TextStyle(
            fontSize: 16,
            color: isReached ? null : Colors.grey.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 10,
            fontWeight: isReached ? FontWeight.w600 : FontWeight.w400,
            color: isReached ? AppColors.primary : AppColors.gray400,
          ),
        ),
      ],
    );
  }
}

/// 야구장 페인터
class _BaseballFieldPainter extends CustomPainter {
  final double progressPercent;

  _BaseballFieldPainter({required this.progressPercent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 10);
    final baseDistance = size.height * 0.32;

    // 베이스 위치
    final homeBase = Offset(center.dx, center.dy + baseDistance);
    final firstBase = Offset(center.dx + baseDistance, center.dy);
    final secondBase = Offset(center.dx, center.dy - baseDistance);
    final thirdBase = Offset(center.dx - baseDistance, center.dy);

    // 외야 (진한 초록)
    final outfieldPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          const Color(0xFF66BB6A),
          const Color(0xFF4CAF50),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: baseDistance * 1.5));

    canvas.drawCircle(center, baseDistance * 1.5, outfieldPaint);

    // 내야 잔디
    final infieldPaint = Paint()
      ..color = const Color(0xFF81C784);

    final diamondPath = Path()
      ..moveTo(homeBase.dx, homeBase.dy)
      ..lineTo(firstBase.dx, firstBase.dy)
      ..lineTo(secondBase.dx, secondBase.dy)
      ..lineTo(thirdBase.dx, thirdBase.dy)
      ..close();

    canvas.drawPath(diamondPath, infieldPaint);

    // 내야 흙
    final dirtPaint = Paint()..color = const Color(0xFFD7CCC8);

    canvas.drawCircle(homeBase, 16, dirtPaint);
    canvas.drawCircle(center, 10, dirtPaint);
    canvas.drawCircle(firstBase, 12, dirtPaint);
    canvas.drawCircle(secondBase, 12, dirtPaint);
    canvas.drawCircle(thirdBase, 12, dirtPaint);

    // 베이스 라인
    final baseLinePaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(homeBase, firstBase, baseLinePaint);
    canvas.drawLine(firstBase, secondBase, baseLinePaint);
    canvas.drawLine(secondBase, thirdBase, baseLinePaint);
    canvas.drawLine(thirdBase, homeBase, baseLinePaint);

    // 파울 라인
    final foulLinePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final foulLine1End = Offset(
      homeBase.dx + (firstBase.dx - homeBase.dx) * 2,
      homeBase.dy + (firstBase.dy - homeBase.dy) * 2,
    );
    canvas.drawLine(homeBase, foulLine1End, foulLinePaint);

    final foulLine3End = Offset(
      homeBase.dx + (thirdBase.dx - homeBase.dx) * 2,
      homeBase.dy + (thirdBase.dy - homeBase.dy) * 2,
    );
    canvas.drawLine(homeBase, foulLine3End, foulLinePaint);

    // 진행 경로 (노란색)
    final progressPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    _drawProgressPath(canvas, homeBase, firstBase, secondBase, thirdBase, progressPaint);

    // 베이스 그리기
    _drawBase(canvas, homeBase, 0, isHome: true);
    _drawBase(canvas, firstBase, 25);
    _drawBase(canvas, secondBase, 50);
    _drawBase(canvas, thirdBase, 75);

    // 투수 마운드
    final moundPaint = Paint()..color = const Color(0xFFBCAAA4);
    canvas.drawCircle(center, 5, moundPaint);

    // 캐릭터 (주자) 그리기
    _drawCharacter(canvas, homeBase, firstBase, secondBase, thirdBase);
  }

  void _drawProgressPath(Canvas canvas, Offset home, Offset first, Offset second, Offset third, Paint paint) {
    if (progressPercent <= 0) return;

    final path = Path()..moveTo(home.dx, home.dy);

    if (progressPercent >= 25) {
      path.lineTo(first.dx, first.dy);
      if (progressPercent >= 50) {
        path.lineTo(second.dx, second.dy);
        if (progressPercent >= 75) {
          path.lineTo(third.dx, third.dy);
          if (progressPercent >= 100) {
            path.lineTo(home.dx, home.dy);
          } else {
            final t = (progressPercent - 75) / 25;
            path.lineTo(
              third.dx + (home.dx - third.dx) * t,
              third.dy + (home.dy - third.dy) * t,
            );
          }
        } else {
          final t = (progressPercent - 50) / 25;
          path.lineTo(
            second.dx + (third.dx - second.dx) * t,
            second.dy + (third.dy - second.dy) * t,
          );
        }
      } else {
        final t = (progressPercent - 25) / 25;
        path.lineTo(
          first.dx + (second.dx - first.dx) * t,
          first.dy + (second.dy - first.dy) * t,
        );
      }
    } else {
      final t = progressPercent / 25;
      path.lineTo(
        home.dx + (first.dx - home.dx) * t,
        home.dy + (first.dy - home.dy) * t,
      );
    }

    canvas.drawPath(path, paint);
  }

  void _drawBase(Canvas canvas, Offset position, double threshold, {bool isHome = false}) {
    final isReached = progressPercent >= threshold;
    final baseSize = isHome ? 12.0 : 10.0;

    if (isHome) {
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
        ..strokeWidth = 2;

      canvas.drawPath(homePath, basePaint);
      canvas.drawPath(homePath, borderPaint);
    } else {
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
        ..strokeWidth = 2;

      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(2));
      canvas.drawRRect(rrect, basePaint);
      canvas.drawRRect(rrect, borderPaint);
      canvas.restore();
    }
  }

  void _drawCharacter(Canvas canvas, Offset home, Offset first, Offset second, Offset third) {
    Offset charPosition;

    if (progressPercent >= 100) {
      charPosition = home;
    } else if (progressPercent >= 75) {
      final t = (progressPercent - 75) / 25;
      charPosition = Offset(
        third.dx + (home.dx - third.dx) * t,
        third.dy + (home.dy - third.dy) * t,
      );
    } else if (progressPercent >= 50) {
      final t = (progressPercent - 50) / 25;
      charPosition = Offset(
        second.dx + (third.dx - second.dx) * t,
        second.dy + (third.dy - second.dy) * t,
      );
    } else if (progressPercent >= 25) {
      final t = (progressPercent - 25) / 25;
      charPosition = Offset(
        first.dx + (second.dx - first.dx) * t,
        first.dy + (second.dy - first.dy) * t,
      );
    } else {
      final t = progressPercent / 25;
      charPosition = Offset(
        home.dx + (first.dx - home.dx) * t,
        home.dy + (first.dy - home.dy) * t,
      );
    }

    // 그림자
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawOval(
      Rect.fromCenter(
        center: charPosition + const Offset(0, 12),
        width: 16,
        height: 6,
      ),
      shadowPaint,
    );

    // 캐릭터 몸통 (원)
    final bodyPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 1.0,
        colors: [
          const Color(0xFFFFEB3B),
          const Color(0xFFFFC107),
        ],
      ).createShader(Rect.fromCircle(center: charPosition, radius: 12));
    canvas.drawCircle(charPosition, 12, bodyPaint);

    // 테두리
    final borderPaint = Paint()
      ..color = const Color(0xFFFF9800)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(charPosition, 12, borderPaint);

    // 눈 (두 개)
    final eyePaint = Paint()..color = const Color(0xFF333333);
    canvas.drawCircle(charPosition + const Offset(-4, -2), 2.5, eyePaint);
    canvas.drawCircle(charPosition + const Offset(4, -2), 2.5, eyePaint);

    // 눈 하이라이트
    final eyeHighlightPaint = Paint()..color = Colors.white;
    canvas.drawCircle(charPosition + const Offset(-3, -3), 1, eyeHighlightPaint);
    canvas.drawCircle(charPosition + const Offset(5, -3), 1, eyeHighlightPaint);

    // 웃는 입
    final smilePaint = Paint()
      ..color = const Color(0xFF333333)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: charPosition + const Offset(0, 3), width: 10, height: 8),
      0.2,
      2.7,
      false,
      smilePaint,
    );

    // 볼터치
    final blushPaint = Paint()..color = const Color(0xFFFF8A80).withOpacity(0.5);
    canvas.drawOval(
      Rect.fromCenter(center: charPosition + const Offset(-7, 2), width: 5, height: 3),
      blushPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: charPosition + const Offset(7, 2), width: 5, height: 3),
      blushPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _BaseballFieldPainter oldDelegate) {
    return oldDelegate.progressPercent != progressPercent;
  }
}
