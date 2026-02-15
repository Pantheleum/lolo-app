import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Animated XP progress bar with level thresholds.
///
/// Shows current XP vs target XP with a smooth fill animation.
/// Designed for dark overlay contexts (e.g., inside the level card gradient).
class XpProgressBar extends StatefulWidget {
  const XpProgressBar({
    required this.progress,
    required this.currentXp,
    required this.targetXp,
    this.height = 8,
    this.duration = const Duration(milliseconds: 600),
    super.key,
  });

  /// Progress value between 0.0 and 1.0.
  final double progress;

  /// Current XP amount (shown on the left label).
  final int currentXp;

  /// Target XP for next level (shown on the right label).
  final int targetXp;

  /// Bar height in logical pixels.
  final double height;

  /// Animation duration.
  final Duration duration;

  @override
  State<XpProgressBar> createState() => _XpProgressBarState();
}

class _XpProgressBarState extends State<XpProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.progress.clamp(0, 1))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void didUpdateWidget(XpProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      final prev = _animation.value;
      _animation = Tween<double>(
        begin: prev,
        end: widget.progress.clamp(0, 1),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
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
  Widget build(BuildContext context) {
    return Semantics(
      label: '${(widget.progress * 100).toInt()}% to next level. '
          '${widget.currentXp} of ${widget.targetXp} XP.',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: widget.height,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (_, __) => ClipRRect(
                borderRadius: BorderRadius.circular(widget.height / 2),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: widget.height,
                      color: Colors.white24,
                    ),
                    FractionallySizedBox(
                      widthFactor: _animation.value,
                      child: Container(
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: LoloColors.colorAccent,
                          borderRadius: BorderRadius.circular(widget.height / 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: LoloSpacing.spaceXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${widget.currentXp} XP',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Text('${widget.targetXp} XP',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
