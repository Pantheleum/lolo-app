import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_streak_display.dart';
import 'package:lolo/core/widgets/lolo_progress_bar.dart';

/// Combined streak and XP level widget for the dashboard.
class StreakWidget extends StatelessWidget {
  const StreakWidget({
    required this.streak,
    required this.level,
    required this.xpProgress,
    required this.activeDays,
    super.key,
  });

  final int streak;
  final int level;
  final double xpProgress;
  final List<bool> activeDays;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
      ),
      child: Container(
        padding: const EdgeInsets.all(LoloSpacing.spaceMd),
        decoration: BoxDecoration(
          color: isDark
              ? LoloColors.darkSurfaceElevated1
              : LoloColors.lightSurfaceElevated1,
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          border: Border.all(
            color: isDark
                ? LoloColors.darkBorderDefault
                : LoloColors.lightBorderDefault,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: LoloStreakDisplay(
                streakCount: streak,
                activeDays: activeDays,
                isActive: streak > 0,
              ),
            ),
            const SizedBox(width: LoloSpacing.spaceMd),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Level $level',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: LoloColors.colorPrimary,
                    ),
                  ),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  LoloProgressBar(
                    value: xpProgress.clamp(0.0, 1.0),
                    color: LoloColors.colorAccent,
                    sublabel: '${(xpProgress * 100).toInt()}% to next level',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
