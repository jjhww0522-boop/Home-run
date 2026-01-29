import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// 귀여운 스타일의 야구장 위젯
/// 부드럽고 현대적인 디자인
class PixelBaseballField extends StatefulWidget {
  final double progressPercent;
  final String targetName;
  final int currentAssets;
  final int targetAssets;

  const PixelBaseballField({
    super.key,
    required this.progressPercent,
    required this.targetName,
    this.currentAssets = 0,
    this.targetAssets = 0,
  });

  @override
  State<PixelBaseballField> createState() => _PixelBaseballFieldState();
}

class _PixelBaseballFieldState extends State<PixelBaseballField>
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
  void didUpdateWidget(PixelBaseballField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progressPercent != widget.progressPercent) {
      _previousProgress = widget.progressPercent;
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

  String _formatAmount(int amount) {
    if (amount >= 100000000) {
      final billions = amount / 100000000;
      return '${billions.toStringAsFixed(1)}억원';
    } else if (amount >= 10000) {
      return '${(amount / 10000).toStringAsFixed(0)}만원';
    }
    return '$amount원';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF87CEEB), // 하늘색
            const Color(0xFFB0E0E6), // 연한 하늘색
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 상단 헤더 (부드러운 스타일)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFFD700).withOpacity(0.9),
                  const Color(0xFFFFA500).withOpacity(0.9),
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _runnerAnimation,
                  builder: (context, child) {
                    return Text(
                      '홈런까지 ${_runnerAnimation.value.toStringAsFixed(0)}%!',
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // 야구장 필드
          AnimatedBuilder(
            animation: _runnerAnimation,
            builder: (context, child) {
              return SizedBox(
                height: 320,
                child: Stack(
                  children: [
                    // 야구장 그리기
                    CustomPaint(
                      size: const Size(double.infinity, 320),
                      painter: _CuteBaseballFieldPainter(
                        progressPercent: _runnerAnimation.value,
                      ),
                    ),

                    // 말풍선 스타일 진행률 표시
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: _buildProgressBubble(_runnerAnimation.value),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // 하단 정보 패널 (부드러운 스타일)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF2C3E50),
                  const Color(0xFF34495E),
                ],
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            child: Column(
              children: [
                _buildCuteInfoRow(
                  '💰 모은 돈',
                  _formatAmount(widget.currentAssets),
                  const Color(0xFF4CAF50),
                ),
                const SizedBox(height: 12),
                _buildCuteInfoRow(
                  '🎯 목표 금액',
                  _formatAmount(widget.targetAssets),
                  const Color(0xFFFFD700),
                ),
                const SizedBox(height: 12),
                _buildCuteInfoRow(
                  '🏃 남은 금액',
                  _formatAmount(widget.targetAssets - widget.currentAssets),
                  const Color(0xFFFF6B6B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBubble(double progress) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🐕',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 10),
          Text(
            '${progress.toStringAsFixed(0)}%',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2C3E50),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCuteInfoRow(String label, String value, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: accentColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// 귀여운 스타일 야구장 페인터
class _CuteBaseballFieldPainter extends CustomPainter {
  final double progressPercent;

  _CuteBaseballFieldPainter({required this.progressPercent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseDistance = size.height * 0.25;

    // 베이스 위치 계산
    final homeBase = Offset(center.dx, center.dy + baseDistance);
    final firstBase = Offset(center.dx + baseDistance, center.dy);
    final secondBase = Offset(center.dx, center.dy - baseDistance);
    final thirdBase = Offset(center.dx - baseDistance, center.dy);

    // 구름 그리기 (부드러운 스타일)
    _drawClouds(canvas, size);

    // 관중석 배경 (부드러운 그라데이션)
    _drawStands(canvas, size);

    // 외야 잔디 (부드러운 그라데이션)
    _drawOutfield(canvas, size, center, baseDistance * 1.8);

    // 내야 잔디
    _drawInfield(canvas, homeBase, firstBase, secondBase, thirdBase);

    // 주로 (흙)
    _drawBasePath(canvas, homeBase, firstBase, secondBase, thirdBase);

    // 베이스 라인 (부드러운 선)
    _drawBaseLines(canvas, homeBase, firstBase, secondBase, thirdBase);

    // 진행 경로 (밝게 빛나는 경로)
    _drawProgressPath(canvas, homeBase, firstBase, secondBase, thirdBase);

    // 베이스 그리기 (부드러운 스타일)
    _drawCuteBase(canvas, homeBase, 0, isHome: true);
    _drawCuteBase(canvas, firstBase, 25);
    _drawCuteBase(canvas, secondBase, 50);
    _drawCuteBase(canvas, thirdBase, 75);

    // 투수 마운드
    _drawMound(canvas, center);

    // 강아지 캐릭터 그리기 (귀여운 스타일)
    _drawDogCharacter(canvas, homeBase, firstBase, secondBase, thirdBase);

    // 관중 강아지들 (부드러운 스타일)
    _drawAudience(canvas, size);

    // 홈런볼 효과
    if (progressPercent > 0) {
      _drawHomeRunEffects(canvas, size, progressPercent);
    }
  }

  void _drawClouds(Canvas canvas, Size size) {
    // 부드러운 구름 (여러 원으로 구성)
    final cloudPaint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..style = PaintingStyle.fill;

    // 구름 1
    final cloud1 = Offset(size.width * 0.15, size.height * 0.1);
    _drawSoftCloud(canvas, cloud1, 25, cloudPaint);

    // 구름 2
    final cloud2 = Offset(size.width * 0.75, size.height * 0.15);
    _drawSoftCloud(canvas, cloud2, 30, cloudPaint);
  }

  void _drawSoftCloud(Canvas canvas, Offset center, double size, Paint paint) {
    // 부드러운 구름을 여러 원으로 그리기
    canvas.drawCircle(center, size * 0.6, paint);
    canvas.drawCircle(center + Offset(-size * 0.4, 0), size * 0.5, paint);
    canvas.drawCircle(center + Offset(size * 0.4, 0), size * 0.5, paint);
    canvas.drawCircle(center + Offset(0, -size * 0.3), size * 0.45, paint);
  }

  void _drawStands(Canvas canvas, Size size) {
    // 관중석 배경 (부드러운 그라데이션)
    final standRect = Rect.fromLTWH(0, 0, size.width, size.height * 0.2);
    final standGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF5D6D7E),
        const Color(0xFF566573),
      ],
    );
    final standPaint = Paint()..shader = standGradient.createShader(standRect);
    canvas.drawRect(standRect, standPaint);
  }

  void _drawOutfield(Canvas canvas, Size size, Offset center, double radius) {
    // 외야 잔디 (부드러운 그라데이션)
    final outfieldRect = Rect.fromCircle(center: center, radius: radius);
    final grassGradient = RadialGradient(
      colors: [
        const Color(0xFF66BB6A),
        const Color(0xFF4CAF50),
        const Color(0xFF388E3C),
      ],
    );
    final grassPaint = Paint()
      ..shader = grassGradient.createShader(outfieldRect);
    canvas.drawCircle(center, radius, grassPaint);
  }

  void _drawInfield(Canvas canvas, Offset home, Offset first, Offset second, Offset third) {
    // 내야 잔디 (다이아몬드 모양, 부드러운 그라데이션)
    final infieldPath = Path()
      ..moveTo(home.dx, home.dy)
      ..lineTo(first.dx, first.dy)
      ..lineTo(second.dx, second.dy)
      ..lineTo(third.dx, third.dy)
      ..close();

    final infieldRect = Rect.fromLTRB(
      third.dx,
      second.dy,
      first.dx,
      home.dy,
    );
    final infieldGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF81C784),
        const Color(0xFF66BB6A),
      ],
    );
    final infieldPaint = Paint()
      ..shader = infieldGradient.createShader(infieldRect);

    canvas.drawPath(infieldPath, infieldPaint);
  }

  void _drawBasePath(Canvas canvas, Offset home, Offset first, Offset second, Offset third) {
    // 주로 (흙색, 부드러운 원형)
    final dirtPaint = Paint()
      ..color = const Color(0xFFA0826D)
      ..style = PaintingStyle.fill;

    // 홈 플레이트 주변
    canvas.drawCircle(home, 12, dirtPaint);

    // 베이스 주변 흙
    canvas.drawCircle(first, 10, dirtPaint);
    canvas.drawCircle(second, 10, dirtPaint);
    canvas.drawCircle(third, 10, dirtPaint);
  }

  void _drawBaseLines(Canvas canvas, Offset home, Offset first, Offset second, Offset third) {
    // 베이스 라인 (부드러운 흰색 선)
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(home, first, linePaint);
    canvas.drawLine(first, second, linePaint);
    canvas.drawLine(second, third, linePaint);
    canvas.drawLine(third, home, linePaint);
  }

  void _drawProgressPath(Canvas canvas, Offset home, Offset first, Offset second, Offset third) {
    if (progressPercent <= 0) return;

    // 진행 경로 (부드러운 골드 그라데이션)
    final progressPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final glowPaint = Paint()
      ..color = const Color(0xFFFFD700).withOpacity(0.4)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()..moveTo(home.dx, home.dy);
    final totalPath = 4.0;
    final currentSegment = progressPercent / 25.0;

    if (currentSegment >= 1) {
      path.lineTo(first.dx, first.dy);
      if (currentSegment >= 2) {
        path.lineTo(second.dx, second.dy);
        if (currentSegment >= 3) {
          path.lineTo(third.dx, third.dy);
          if (currentSegment >= 4) {
            path.lineTo(home.dx, home.dy);
          } else {
            final t = (currentSegment - 3);
            path.lineTo(
              third.dx + (home.dx - third.dx) * t,
              third.dy + (home.dy - third.dy) * t,
            );
          }
        } else {
          final t = (currentSegment - 2);
          path.lineTo(
            second.dx + (third.dx - second.dx) * t,
            second.dy + (third.dy - second.dy) * t,
          );
        }
      } else {
        final t = (currentSegment - 1);
        path.lineTo(
          first.dx + (second.dx - first.dx) * t,
          first.dy + (second.dy - first.dy) * t,
        );
      }
    } else {
      final t = currentSegment;
      path.lineTo(
        home.dx + (first.dx - home.dx) * t,
        home.dy + (first.dy - home.dy) * t,
      );
    }

    // 글로우 효과
    canvas.drawPath(path, glowPaint);
    // 메인 경로
    canvas.drawPath(path, progressPaint);
  }

  void _drawCuteBase(Canvas canvas, Offset position, double threshold, {bool isHome = false}) {
    final isReached = progressPercent >= threshold;

    if (isHome) {
      // 홈 플레이트 (다이아몬드 모양, 부드러운 스타일)
      final homePath = Path();
      homePath.moveTo(position.dx, position.dy - 10);
      homePath.lineTo(position.dx + 8, position.dy - 3);
      homePath.lineTo(position.dx + 8, position.dy + 6);
      homePath.lineTo(position.dx - 8, position.dy + 6);
      homePath.lineTo(position.dx - 8, position.dy - 3);
      homePath.close();

      final basePaint = Paint()
        ..color = isReached ? const Color(0xFFFFD700) : Colors.white
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = isReached ? const Color(0xFFFFA500) : const Color(0xFFCCCCCC)
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke;

      canvas.drawPath(homePath, basePaint);
      canvas.drawPath(homePath, borderPaint);
    } else {
      // 베이스 (부드러운 원형)
      final basePaint = Paint()
        ..color = isReached ? const Color(0xFFFFD700) : Colors.white
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = isReached ? const Color(0xFFFFA500) : const Color(0xFFCCCCCC)
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(position, 9, basePaint);
      canvas.drawCircle(position, 9, borderPaint);
    }
  }

  void _drawMound(Canvas canvas, Offset center) {
    // 투수 마운드 (부드러운 원형)
    final moundPaint = Paint()
      ..color = const Color(0xFFA0826D)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 8, moundPaint);
  }

  void _drawDogCharacter(Canvas canvas, Offset home, Offset first, Offset second, Offset third) {
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

    // 그림자 (부드러운 타원)
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: charPosition + const Offset(0, 18),
        width: 24,
        height: 8,
      ),
      shadowPaint,
    );

    // 강아지 캐릭터 (귀여운 부드러운 스타일)
    _drawCuteDog(canvas, charPosition);
  }

  void _drawCuteDog(Canvas canvas, Offset position) {
    // 강아지 몸통 (노란색 원형)
    final bodyPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, 12, bodyPaint);

    // 강아지 머리 (약간 위, 더 큰 원)
    canvas.drawCircle(position + const Offset(0, -14), 14, bodyPaint);

    // 눈 (검은색, 큰 원)
    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position + const Offset(-6, -16), 3.5, eyePaint);
    canvas.drawCircle(position + const Offset(6, -16), 3.5, eyePaint);

    // 눈 하이라이트 (흰색 작은 원)
    final highlightPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position + const Offset(-5, -17), 1.5, highlightPaint);
    canvas.drawCircle(position + const Offset(7, -17), 1.5, highlightPaint);

    // 코 (검은색 작은 원)
    canvas.drawCircle(position + const Offset(0, -12), 2.5, eyePaint);

    // 입 (웃는 모양, 부드러운 곡선)
    final mouthPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final mouthPath = Path();
    mouthPath.moveTo(position.dx - 4, position.dy - 8);
    mouthPath.quadraticBezierTo(
      position.dx,
      position.dy - 6,
      position.dx + 4,
      position.dy - 8,
    );
    canvas.drawPath(mouthPath, mouthPaint);

    // 귀 (갈색, 부드러운 타원)
    final earPaint = Paint()
      ..color = const Color(0xFFD2691E)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: position + const Offset(-8, -22),
        width: 8,
        height: 12,
      ),
      earPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: position + const Offset(8, -22),
        width: 8,
        height: 12,
      ),
      earPaint,
    );

    // 유니폼 (파란색, 부드러운 원형)
    final uniformPaint = Paint()
      ..color = const Color(0xFF2196F3)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: position + const Offset(0, 2),
        width: 20,
        height: 16,
      ),
      uniformPaint,
    );

    // 유니폼 번호 (흰색)
    final numberPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position + const Offset(0, 2), 4, numberPaint);

    // 다리 (달리는 모습, 부드러운 타원)
    final legPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.fill;

    // 앞다리
    canvas.drawOval(
      Rect.fromCenter(
        center: position + const Offset(-6, 16),
        width: 6,
        height: 8,
      ),
      legPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: position + const Offset(6, 16),
        width: 6,
        height: 8,
      ),
      legPaint,
    );

    // 뒷다리
    canvas.drawOval(
      Rect.fromCenter(
        center: position + const Offset(-7, 18),
        width: 5,
        height: 7,
      ),
      legPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: position + const Offset(7, 18),
        width: 5,
        height: 7,
      ),
      legPaint,
    );

    // 땀 방울 효과 (부드러운 원형)
    final sweatPaint = Paint()
      ..color = const Color(0xFF87CEEB).withOpacity(0.7)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position + const Offset(-12, -14), 2.5, sweatPaint);
    canvas.drawCircle(position + const Offset(12, -14), 2.5, sweatPaint);
    canvas.drawCircle(position + const Offset(-10, -12), 2, sweatPaint);
    canvas.drawCircle(position + const Offset(10, -12), 2, sweatPaint);
  }

  void _drawAudience(Canvas canvas, Size size) {
    // 관중석에 강아지 관중들 (부드러운 원형)
    final audienceY = size.height * 0.1;

    for (int i = 0; i < 20; i++) {
      final x = (size.width / 20) * i + (size.width / 40);
      final dogColor = i % 4 == 0
          ? const Color(0xFFFFD700)
          : i % 4 == 1
              ? const Color(0xFFFF6B6B)
              : i % 4 == 2
                  ? const Color(0xFF4ECDC4)
                  : const Color(0xFF9B59B6);

      final dogPaint = Paint()
        ..color = dogColor
        ..style = PaintingStyle.fill;

      // 작은 강아지 (몸통)
      canvas.drawCircle(Offset(x, audienceY), 4, dogPaint);

      // 머리
      canvas.drawCircle(Offset(x, audienceY - 5), 3.5, dogPaint);

      // 응원 도구 (풍선, 깃발)
      if (i % 5 == 0) {
        // 깃발
        final flagPaint = Paint()
          ..color = const Color(0xFFFF6B6B)
          ..style = PaintingStyle.fill;

        canvas.drawRect(
          Rect.fromLTWH(x - 1, audienceY - 12, 2, 8),
          flagPaint,
        );
      } else if (i % 5 == 2) {
        // 풍선
        final balloonPaint = Paint()
          ..color = const Color(0xFFFFD700)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(Offset(x, audienceY - 10), 3, balloonPaint);
      }
    }
  }

  void _drawHomeRunEffects(Canvas canvas, Size size, double progress) {
    // 홈런볼 효과 (부드러운 원형)
    if (progress > 50) {
      final ballCount = ((progress - 50) / 10).round();
      for (int i = 0; i < ballCount; i++) {
        final angle = (i * 2 * math.pi / ballCount) + (progress * 0.1);
        final distance = 60.0 + (progress - 50) * 0.5;
        final ballPos = Offset(
          size.width / 2 + distance * math.cos(angle),
          size.height / 2 + distance * math.sin(angle),
        );

        final ballPaint = Paint()
          ..color = const Color(0xFFFFD700)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(ballPos, 4, ballPaint);
      }
    }

    // 폭죽 효과 (100% 달성 시, 부드러운 원형)
    if (progress >= 100) {
      final fireworkPaint = Paint()
        ..color = const Color(0xFFFF6B00)
        ..style = PaintingStyle.fill;

      for (int i = 0; i < 8; i++) {
        final angle = i * math.pi / 4;
        final distance = 40.0;
        final fireworkPos = Offset(
          size.width / 2 + distance * math.cos(angle),
          size.height / 2 + distance * math.sin(angle),
        );

        canvas.drawCircle(fireworkPos, 5, fireworkPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CuteBaseballFieldPainter oldDelegate) {
    return oldDelegate.progressPercent != progressPercent;
  }
}
