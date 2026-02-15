import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';

/// Compact stat display: icon, value (large text), label (small text).
///
/// Used in 2- or 3-column grids on dashboard and gamification screens.
class StatCard extends StatelessWidget {
  const StatCard({
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor,
    this.onTap,
    this.semanticLabel,
    super.key,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color? iconColor;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary;
    final borderColor = isDark ? LoloColors.darkBorderDefault : LoloColors.lightBorderDefault;
    final secondaryText = isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary;

    return Semantics(label: semanticLabel ?? '$label: $value', button: onTap != null,
      child: GestureDetector(onTap: onTap, child: Container(
        height: 80, padding: const EdgeInsetsDirectional.all(12),
        decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 24, color: iconColor ?? LoloColors.colorPrimary),
          const SizedBox(height: 4),
          Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: secondaryText),
            maxLines: 1, overflow: TextOverflow.ellipsis),
        ]))));
  }
}
