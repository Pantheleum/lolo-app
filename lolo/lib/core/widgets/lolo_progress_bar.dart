import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';

/// Progress indicator variant.
enum ProgressVariant { linear, circular }

/// Animated progress bar with linear and circular gauge variants.
///
/// Linear: 8dp height, 4dp radius track, gradient or solid fill.
/// Circular: configurable size, 8dp stroke, animated clockwise fill (counter-clockwise in RTL).
class LoloProgressBar extends StatefulWidget {
  const LoloProgressBar({
    required this.value,
    this.variant = ProgressVariant.linear,
    this.color,
    this.useGradient = false,
    this.size = 120,
    this.strokeWidth = 8,
    this.label,
    this.sublabel,
    this.animationDuration = const Duration(milliseconds: 500),
    this.semanticLabel,
    super.key,
  });

  /// Progress value between 0.0 and 1.0.
  final double value;
  final ProgressVariant variant;
  /// Solid fill color. Ignored if [useGradient] is true.
  final Color? color;
  /// Use the premium gradient for the fill.
  final bool useGradient;
  /// Circular variant diameter.
  final double size;
  final double strokeWidth;
  /// Label above linear bar, or center of circular gauge.
  final String? label;
  /// Sub-label (e.g., "XP needed").
  final String? sublabel;
  final Duration animationDuration;
  final String? semanticLabel;

  @override
  State<LoloProgressBar> createState() => _LoloProgressBarState();
}

class _LoloProgressBarState extends State<LoloProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.animationDuration, vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void didUpdateWidget(LoloProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = _animation.value;
      _animation = Tween<double>(begin: _previousValue, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.variant == ProgressVariant.linear
      ? _buildLinear(context) : _buildCircular(context);

  Widget _buildLinear(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final trackColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    final fillColor = widget.color ?? LoloColors.colorPrimary;

    return Semantics(label: widget.semanticLabel ?? '${(widget.value * 100).toInt()}% progress',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        if (widget.label != null || widget.sublabel != null)
          Padding(padding: const EdgeInsetsDirectional.only(bottom: 8),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              if (widget.label != null) Text(widget.label!, style: theme.textTheme.titleMedium),
              if (widget.sublabel != null) Text(widget.sublabel!, style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
            ])),
        SizedBox(height: 8, child: AnimatedBuilder(animation: _animation, builder: (_, __) {
          return ClipRRect(borderRadius: BorderRadius.circular(4),
            child: Stack(children: [
              Container(width: double.infinity, height: 8, color: trackColor),
              FractionallySizedBox(widthFactor: _animation.value.clamp(0.0, 1.0),
                child: Container(height: 8,
                  decoration: BoxDecoration(
                    color: widget.useGradient ? null : fillColor,
                    gradient: widget.useGradient ? LoloGradients.premium : null,
                    borderRadius: BorderRadius.circular(4)))),
            ]));
        })),
      ]));
  }

  Widget _buildCircular(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final trackColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    final fillColor = widget.color ?? LoloColors.colorPrimary;

    return Semantics(label: widget.semanticLabel ?? '${(widget.value * 100).toInt()}% progress',
      child: SizedBox(width: widget.size, height: widget.size,
        child: AnimatedBuilder(animation: _animation, builder: (_, __) {
          return Stack(alignment: Alignment.center, children: [
            CustomPaint(size: Size(widget.size, widget.size),
              painter: _CircularProgressPainter(
                value: _animation.value.clamp(0.0, 1.0),
                trackColor: trackColor, fillColor: fillColor,
                strokeWidth: widget.strokeWidth,
                isRtl: Directionality.of(context) == TextDirection.rtl)),
            if (widget.label != null || widget.sublabel != null)
              Column(mainAxisSize: MainAxisSize.min, children: [
                if (widget.label != null) Text(widget.label!, style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 28)),
                if (widget.sublabel != null) Text(widget.sublabel!, style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
              ]),
          ]);
        })));
  }
}

class _CircularProgressPainter extends CustomPainter {
  _CircularProgressPainter({
    required this.value, required this.trackColor,
    required this.fillColor, required this.strokeWidth,
    required this.isRtl,
  });
  final double value;
  final Color trackColor;
  final Color fillColor;
  final double strokeWidth;
  final bool isRtl;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final trackPaint = Paint()..color = trackColor..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    final fillPaint = Paint()..color = fillColor..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * value * (isRtl ? -1 : 1);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, fillPaint);
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) => old.value != value;
}
