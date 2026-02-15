import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Circular progress ring that wraps the partner's avatar.
///
/// Shows profile completion percentage as an arc. The unfilled
/// portion uses a muted border color for visual continuity.
class ProfileCompletionRing extends StatelessWidget {
  const ProfileCompletionRing({
    required this.percent,
    required this.child,
    this.size = 88,
    this.strokeWidth = 3,
    super.key,
  });

  /// Completion value from 0.0 to 1.0.
  final double percent;

  /// Avatar or content inside the ring.
  final Widget child;

  /// Outer diameter of the ring.
  final double size;

  /// Width of the ring stroke.
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ring
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              percent: percent,
              activeColor: LoloColors.colorPrimary,
              inactiveColor: isDark
                  ? LoloColors.darkBorderDefault
                  : LoloColors.lightBorderDefault,
              strokeWidth: strokeWidth,
            ),
          ),
          // Content
          child,
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percent;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;

  _RingPainter({
    required this.percent,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Inactive background
    final bgPaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // Active arc
    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      2 * math.pi * percent,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.percent != percent;
}
