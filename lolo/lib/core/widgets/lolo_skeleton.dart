import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';

/// Skeleton shimmer variant templates.
enum SkeletonVariant { card, list, text, avatar, custom }

/// Shimmer effect wrapper for loading states.
///
/// Animates a gradient sweep across child shapes at 1500ms per cycle.
/// Direction reverses in RTL (sweeps right-to-left in LTR, left-to-right in RTL).
class LoloSkeleton extends StatefulWidget {
  const LoloSkeleton({
    this.width,
    this.height,
    this.borderRadius,
    this.isCircle = false,
    this.child,
    super.key,
  });

  /// Creates a card-shaped skeleton.
  const LoloSkeleton.card({super.key})
      : width = double.infinity,
        height = 160,
        borderRadius = 12,
        isCircle = false,
        child = null;

  /// Creates a text-line skeleton.
  const LoloSkeleton.text({double widthFactor = 1.0, super.key})
      : width = null,
        height = 12,
        borderRadius = 4,
        isCircle = false,
        child = null;

  /// Creates an avatar-circle skeleton.
  const LoloSkeleton.avatar({double size = 48, super.key})
      : width = size,
        height = size,
        borderRadius = null,
        isCircle = true,
        child = null;

  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isCircle;
  final Widget? child;

  @override
  State<LoloSkeleton> createState() => _LoloSkeletonState();
}

class _LoloSkeletonState extends State<LoloSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final baseGradient = isDark ? LoloGradients.shimmerDark : LoloGradients.shimmerLight;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final progress = _controller.value;
        final effectiveProgress = isRtl ? 1.0 - progress : progress;

        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: widget.isCircle ? null
                : BorderRadius.circular(widget.borderRadius ?? 4),
            gradient: LinearGradient(
              colors: baseGradient.colors,
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + 2.0 * effectiveProgress, 0),
              end: Alignment(1.0 + 2.0 * effectiveProgress, 0),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Pre-built skeleton templates for common screen layouts.
class SkeletonTemplates {
  const SkeletonTemplates._();

  /// Dashboard skeleton: action card + 2 reminders + streak bar.
  static Widget dashboard() => const Padding(
        padding: EdgeInsetsDirectional.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LoloSkeleton(width: double.infinity, height: 200, borderRadius: 12),
          SizedBox(height: 16),
          Row(children: [
            Expanded(child: LoloSkeleton(height: 80, borderRadius: 12)),
            SizedBox(width: 8),
            Expanded(child: LoloSkeleton(height: 80, borderRadius: 12)),
            SizedBox(width: 8),
            Expanded(child: LoloSkeleton(height: 80, borderRadius: 12)),
          ]),
          SizedBox(height: 16),
          LoloSkeleton(width: double.infinity, height: 80, borderRadius: 12),
          SizedBox(height: 8),
          LoloSkeleton(width: double.infinity, height: 80, borderRadius: 12),
        ]),
      );

  /// Card list skeleton: 3 stacked card outlines.
  static Widget cardList() => const Padding(
        padding: EdgeInsetsDirectional.all(16),
        child: Column(children: [
          LoloSkeleton(width: double.infinity, height: 120, borderRadius: 12),
          SizedBox(height: 8),
          LoloSkeleton(width: double.infinity, height: 120, borderRadius: 12),
          SizedBox(height: 8),
          LoloSkeleton(width: double.infinity, height: 120, borderRadius: 12),
        ]),
      );

  /// Message result skeleton: bubble with 3 text lines.
  static Widget message() => Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const LoloSkeleton(width: double.infinity, height: 160, borderRadius: 12),
          const SizedBox(height: 16),
          LoloSkeleton(width: 200, height: 12, borderRadius: 4),
          const SizedBox(height: 8),
          const LoloSkeleton(width: double.infinity, height: 12, borderRadius: 4),
          const SizedBox(height: 8),
          LoloSkeleton(width: 260, height: 12, borderRadius: 4),
        ]),
      );

  /// Profile skeleton: avatar + 3 text lines.
  static Widget profile() => const Padding(
        padding: EdgeInsetsDirectional.all(16),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LoloSkeleton.avatar(size: 64),
          SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            LoloSkeleton(width: 140, height: 16, borderRadius: 4),
            SizedBox(height: 8),
            LoloSkeleton(width: 200, height: 12, borderRadius: 4),
            SizedBox(height: 8),
            LoloSkeleton(width: 100, height: 12, borderRadius: 4),
          ])),
        ]),
      );

  /// Gift grid skeleton: 2x2 grid.
  static Widget giftGrid() => const Padding(
        padding: EdgeInsetsDirectional.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: LoloSkeleton(height: 200, borderRadius: 12)),
            SizedBox(width: 16),
            Expanded(child: LoloSkeleton(height: 200, borderRadius: 12)),
          ]),
          SizedBox(height: 16),
          Row(children: [
            Expanded(child: LoloSkeleton(height: 200, borderRadius: 12)),
            SizedBox(width: 16),
            Expanded(child: LoloSkeleton(height: 200, borderRadius: 12)),
          ]),
        ]),
      );
}
