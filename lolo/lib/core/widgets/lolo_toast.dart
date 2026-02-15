import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Toast notification variant.
enum ToastVariant { xpGain, success, error, info }

/// Transient notification overlay with auto-dismiss and swipe-up to dismiss.
///
/// 4 variants: XP gain (gold), success (green), error (red), info (blue).
/// Slides down from the top, auto-dismisses after [duration].
class LoloToast extends StatefulWidget {
  const LoloToast({
    required this.variant,
    required this.title,
    this.message,
    this.duration = const Duration(seconds: 4),
    this.onDismissed,
    super.key,
  });

  final ToastVariant variant;
  final String title;
  final String? message;
  final Duration duration;
  final VoidCallback? onDismissed;

  /// Shows a toast as an overlay entry.
  static void show(
    BuildContext context, {
    required ToastVariant variant,
    required String title,
    String? message,
    Duration duration = const Duration(seconds: 4),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _ToastOverlay(
        variant: variant,
        title: title,
        message: message,
        duration: duration,
        onDismissed: () => entry.remove(),
      ),
    );
    overlay.insert(entry);
  }

  @override
  State<LoloToast> createState() => _LoloToastState();
}

class _LoloToastState extends State<LoloToast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
    Future<void>.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismissed?.call());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SlideTransition(
        position: _slideAnimation,
        child: _ToastContent(variant: widget.variant, title: widget.title, message: widget.message),
      );
}

/// Internal overlay wrapper that manages position and dismissal.
class _ToastOverlay extends StatefulWidget {
  const _ToastOverlay({
    required this.variant,
    required this.title,
    this.message,
    required this.duration,
    required this.onDismissed,
  });

  final ToastVariant variant;
  final String title;
  final String? message;
  final Duration duration;
  final VoidCallback onDismissed;

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _slide = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
    Future<void>.delayed(widget.duration, _dismiss);
  }

  void _dismiss() {
    if (!mounted) return;
    _controller.reverse().then((_) {
      if (mounted) widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + 8;
    return Positioned(
      top: topPadding, left: 8, right: 8,
      child: GestureDetector(
        onVerticalDragEnd: (d) { if (d.velocity.pixelsPerSecond.dy < -100) _dismiss(); },
        child: SlideTransition(position: _slide,
          child: _ToastContent(variant: widget.variant, title: widget.title, message: widget.message)),
      ),
    );
  }
}

/// Visual content of the toast notification.
class _ToastContent extends StatelessWidget {
  const _ToastContent({required this.variant, required this.title, this.message});

  final ToastVariant variant;
  final String title;
  final String? message;

  Color get _accentColor => switch (variant) {
        ToastVariant.xpGain => LoloColors.colorAccent,
        ToastVariant.success => LoloColors.colorSuccess,
        ToastVariant.error => LoloColors.colorError,
        ToastVariant.info => LoloColors.colorInfo,
      };

  IconData get _icon => switch (variant) {
        ToastVariant.xpGain => Icons.star_outlined,
        ToastVariant.success => Icons.check_circle_outline,
        ToastVariant.error => Icons.cancel_outlined,
        ToastVariant.info => Icons.info_outline,
      };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? LoloColors.darkSurfaceElevated2 : LoloColors.lightSurfaceElevated2;

    return Material(
      color: Colors.transparent,
      child: Semantics(liveRegion: true, label: '$title. ${message ?? ""}',
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsetsDirectional.all(12),
          decoration: BoxDecoration(
            color: bg, borderRadius: BorderRadius.circular(12),
            border: BorderDirectional(start: BorderSide(width: 3, color: _accentColor)),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))],
          ),
          child: Row(children: [
            Icon(_icon, size: 24, color: _accentColor),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              if (message != null) Text(message!, style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
            ])),
          ]),
        )),
    );
  }
}
