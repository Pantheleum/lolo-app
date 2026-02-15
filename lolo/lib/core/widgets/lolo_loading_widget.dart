import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Centered loading spinner with optional label.
///
/// Uses the LOLO compass icon with a pulse animation for branded loading,
/// or a standard circular indicator for inline usage.
class LoloLoadingWidget extends StatefulWidget {
  const LoloLoadingWidget({
    this.label,
    this.useBrandedAnimation = false,
    this.size = 40,
    this.semanticLabel,
    super.key,
  });

  /// Optional text below the spinner.
  final String? label;
  /// Use the branded compass pulse instead of a standard spinner.
  final bool useBrandedAnimation;
  /// Spinner diameter.
  final double size;
  final String? semanticLabel;

  @override
  State<LoloLoadingWidget> createState() => _LoloLoadingWidgetState();
}

class _LoloLoadingWidgetState extends State<LoloLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    if (widget.useBrandedAnimation) _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final labelColor = isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;

    return Semantics(
      label: widget.semanticLabel ?? widget.label ?? 'Loading',
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (widget.useBrandedAnimation)
            ScaleTransition(scale: _scaleAnimation,
              child: Icon(Icons.explore, size: widget.size, color: LoloColors.colorPrimary))
          else
            SizedBox(width: widget.size, height: widget.size,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: const AlwaysStoppedAnimation<Color>(LoloColors.colorPrimary))),
          if (widget.label != null) ...[
            const SizedBox(height: 12),
            Text(widget.label!, style: theme.textTheme.bodyMedium?.copyWith(color: labelColor)),
          ],
        ]),
      ),
    );
  }
}
