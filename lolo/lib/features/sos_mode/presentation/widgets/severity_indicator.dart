import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';

/// Color-coded severity display for SOS assessment results.
///
/// Shows a labeled progress bar that shifts from green (low) to red (critical).
class SeverityIndicator extends StatelessWidget {
  const SeverityIndicator({
    required this.score,
    required this.label,
    super.key,
  });

  /// Severity score from 1 (mild) to 10 (critical).
  final int score;

  /// Human-readable severity label (e.g. "Moderate", "High").
  final String label;

  Color get _color {
    if (score <= 3) return LoloColors.colorSuccess;
    if (score <= 6) return LoloColors.colorWarning;
    return LoloColors.colorError;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Severity',
              style: theme.textTheme.titleSmall?.copyWith(
                color: isDark
                    ? LoloColors.darkTextSecondary
                    : LoloColors.lightTextSecondary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: _color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _color,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: LoloSpacing.spaceXs),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: score / 10,
            minHeight: 8,
            backgroundColor: isDark
                ? LoloColors.darkBgTertiary
                : LoloColors.lightBgTertiary,
            valueColor: AlwaysStoppedAnimation<Color>(_color),
          ),
        ),
        const SizedBox(height: LoloSpacing.space2xs),
        Text(
          '$score / 10',
          style: theme.textTheme.bodySmall?.copyWith(color: _color),
        ),
      ],
    );
  }
}
