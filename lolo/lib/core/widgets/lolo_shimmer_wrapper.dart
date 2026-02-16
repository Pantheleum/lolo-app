import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_gradients.dart';

/// A shimmer effect wrapper that applies a sweeping gradient animation
/// over its child widget to indicate loading state.
///
/// Wraps any child widget with a shimmer overlay. Uses design system
/// shimmer gradients. Direction reverses in RTL layouts.
/// Animation cycle: 1500ms.
class LoloShimmerWrapper extends StatefulWidget {
  const LoloShimmerWrapper({
    required this.child,
    this.isLoading = true,
    this.baseColor,
    this.highlightColor,
    super.key,
  });

  /// The child widget to apply the shimmer effect over.
  final Widget child;

  /// Whether the shimmer animation is active.
  final bool isLoading;

  /// Optional base color override for the shimmer.
  final Color? baseColor;

  /// Optional highlight color override for the shimmer.
  final Color? highlightColor;

  @override
  State<LoloShimmerWrapper> createState() => _LoloShimmerWrapperState();
}

class _LoloShimmerWrapperState extends State<LoloShimmerWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.isLoading) _controller.repeat();
  }

  @override
  void didUpdateWidget(LoloShimmerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isLoading && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.child;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final baseGradient =
        isDark ? LoloGradients.shimmerDark : LoloGradients.shimmerLight;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final progress = _controller.value;
        final effectiveProgress = isRtl ? 1.0 - progress : progress;

        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: baseGradient.colors,
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1.0 + 2.0 * effectiveProgress, 0),
              end: Alignment(1.0 + 2.0 * effectiveProgress, 0),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}
