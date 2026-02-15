import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';

/// Weekly streak calendar showing 7 day dots.
///
/// Each dot is colored based on whether XP was earned that day:
/// - Green filled dot: active day (xp > 0)
/// - Dim empty dot: missed day (xp == 0)
/// Shows day abbreviation below each dot.
class StreakCalendar extends StatelessWidget {
  const StreakCalendar({required this.weeklyXp, super.key});

  final List<WeeklyXp> weeklyXp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('This Week', style: theme.textTheme.titleMedium),
        const SizedBox(height: LoloSpacing.spaceSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weeklyXp.map((day) {
            final isActive = day.xp > 0;
            return Semantics(
              label: '${day.day}: ${isActive ? "${day.xp} XP earned" : "no activity"}',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? LoloColors.colorSuccess.withValues(alpha: 0.2)
                          : LoloColors.darkBgSecondary,
                      border: Border.all(
                        color: isActive
                            ? LoloColors.colorSuccess
                            : Colors.white12,
                        width: 2,
                      ),
                    ),
                    child: isActive
                        ? const Icon(Icons.check, size: 16,
                            color: LoloColors.colorSuccess)
                        : null,
                  ),
                  const SizedBox(height: LoloSpacing.space2xs),
                  Text(
                    day.day,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isActive
                          ? LoloColors.colorSuccess
                          : LoloColors.darkTextSecondary,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
