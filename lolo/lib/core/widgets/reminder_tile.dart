import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

enum ReminderUrgency { future, approaching, imminent, today, overdue }
enum ReminderCategory { birthday, anniversary, holiday, custom }

/// Compact reminder list item with urgency-coded accent bar.
///
/// Start-side 4dp accent bar: green (future), amber (approaching), red (imminent/today/overdue).
/// Includes category icon, title, date, checkbox, and countdown badge.
class ReminderTile extends StatelessWidget {
  const ReminderTile({
    required this.title,
    required this.date,
    required this.category,
    this.icon,
    this.isCompleted = false,
    this.onTap,
    this.onToggleComplete,
    this.semanticLabel,
    super.key,
  });

  final String title;
  final DateTime date;
  final ReminderCategory category;
  final IconData? icon;
  final bool isCompleted;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggleComplete;
  final String? semanticLabel;

  ReminderUrgency get _urgency {
    final now = DateTime.now();
    final diff = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day)).inDays;
    if (diff < 0) return ReminderUrgency.overdue;
    if (diff == 0) return ReminderUrgency.today;
    if (diff <= 2) return ReminderUrgency.imminent;
    if (diff <= 6) return ReminderUrgency.approaching;
    return ReminderUrgency.future;
  }

  Color get _accentColor => switch (_urgency) {
        ReminderUrgency.future => LoloColors.colorSuccess,
        ReminderUrgency.approaching => LoloColors.colorWarning,
        _ => LoloColors.colorError,
      };

  String get _countdownText {
    final now = DateTime.now();
    final diff = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day)).inDays;
    if (diff < 0) return 'OVERDUE';
    if (diff == 0) return 'TODAY';
    if (diff == 1) return '1 day';
    return '$diff days';
  }

  IconData get _defaultIcon => switch (category) {
        ReminderCategory.birthday => Icons.cake_outlined,
        ReminderCategory.anniversary => Icons.favorite_outline,
        ReminderCategory.holiday => Icons.event_outlined,
        ReminderCategory.custom => Icons.notifications_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final titleWeight = switch (_urgency) {
      ReminderUrgency.future => FontWeight.w400,
      ReminderUrgency.approaching => FontWeight.w500,
      _ => FontWeight.w600,
    };
    final titleColor = _urgency == ReminderUrgency.overdue ? LoloColors.colorError : null;

    return Semantics(
      label: semanticLabel ?? '$title. $_countdownText.',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12),
            border: BorderDirectional(start: BorderSide(width: 4, color: _accentColor)),
          ),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
          child: Row(children: [
            if (onToggleComplete != null) ...[
              SizedBox(width: 24, height: 24, child: Checkbox(
                value: isCompleted,
                onChanged: (v) => onToggleComplete?.call(v ?? false),
                activeColor: LoloColors.colorPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              )),
              const SizedBox(width: 8),
            ],
            Icon(icon ?? _defaultIcon, size: 32, color: _accentColor),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: titleWeight, color: titleColor,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text('${date.day}/${date.month}/${date.year}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
              ],
            )),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (_urgency == ReminderUrgency.today || _urgency == ReminderUrgency.overdue)
                    ? _accentColor.withValues(alpha: 0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_countdownText, style: TextStyle(fontSize: 12,
                fontWeight: (_urgency == ReminderUrgency.today || _urgency == ReminderUrgency.overdue)
                    ? FontWeight.w700 : FontWeight.w500, color: _accentColor)),
            ),
          ]),
        ),
      ),
    );
  }
}
