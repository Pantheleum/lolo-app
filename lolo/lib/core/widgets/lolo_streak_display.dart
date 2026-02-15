import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Streak display with flame icon, count, "days" label, and mini 7-day calendar.
///
/// Flame icon animates (scale pulse) when active. Gold accent when streak > 0,
/// gray when broken. Mini calendar shows last 7 days as filled/empty dots.
class LoloStreakDisplay extends StatefulWidget {
  const LoloStreakDisplay({
    required this.streakCount,
    this.activeDays = const [],
    this.isActive = true,
    this.onTap,
    this.semanticLabel,
    super.key,
  });

  final int streakCount;
  /// Last 7 days: true = action completed, false = missed.
  final List<bool> activeDays;
  final bool isActive;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  State<LoloStreakDisplay> createState() => _LoloStreakDisplayState();
}

class _LoloStreakDisplayState extends State<LoloStreakDisplay> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(LoloStreakDisplay old) {
    super.didUpdateWidget(old);
    if (widget.streakCount > old.streakCount && widget.isActive) {
      _pulseController.forward().then((_) => _pulseController.reverse());
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    final countColor = widget.isActive ? LoloColors.colorAccent : (isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary);
    final flameColor = widget.isActive ? LoloColors.colorWarning : LoloColors.gray5;

    return Semantics(label: widget.semanticLabel ?? '${widget.streakCount} day streak',
      child: GestureDetector(onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsetsDirectional.all(12),
          decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ScaleTransition(scale: _pulseAnimation,
                child: Icon(Icons.local_fire_department, size: 24, color: flameColor)),
              const SizedBox(width: 8),
              Text('${widget.streakCount}', style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700, color: countColor)),
              const SizedBox(width: 4),
              Text('days', style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
            ]),
            if (widget.activeDays.isNotEmpty) ...[
              const SizedBox(height: 8),
              _MiniCalendar(days: widget.activeDays),
            ],
          ]),
        )));
  }
}

/// Mini 7-day calendar row: filled circles for active days, outlined for missed.
class _MiniCalendar extends StatelessWidget {
  const _MiniCalendar({required this.days});
  final List<bool> days;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final normalizedDays = days.length >= 7 ? days.sublist(days.length - 7) : days;

    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(7, (i) {
        final isActive = i < normalizedDays.length && normalizedDays[i];
        return Padding(padding: const EdgeInsetsDirectional.symmetric(horizontal: 3),
          child: Container(width: 8, height: 8, decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? LoloColors.colorSuccess : Colors.transparent,
            border: Border.all(
              color: isActive ? LoloColors.colorSuccess
                  : (isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault),
              width: 1.5),
          )));
      }));
  }
}
