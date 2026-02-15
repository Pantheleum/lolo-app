import 'package:flutter/material.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Grid of badge icons with earned (colorful) vs locked (greyed out) state.
///
/// Earned badges display their rarity-coded color and glow border.
/// Locked badges are dimmed with an optional progress indicator.
class BadgeGrid extends StatelessWidget {
  const BadgeGrid({
    required this.earned,
    required this.unearned,
    super.key,
  });

  final List<BadgeEntity> earned;
  final List<BadgeEntity> unearned;

  Color _rarityColor(String rarity) => switch (rarity) {
        'common' => Colors.grey,
        'uncommon' => Colors.green,
        'rare' => const Color(0xFF4A90D9),
        'epic' => Colors.purple,
        'legendary' => const Color(0xFFC9A96E),
        _ => Colors.grey,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final allBadges = [...earned, ...unearned];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(l10n.badges, style: theme.textTheme.titleMedium),
            const SizedBox(width: LoloSpacing.spaceXs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: LoloColors.colorAccent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${earned.length}/${allBadges.length}',
                style: theme.textTheme.labelSmall?.copyWith(
                    color: LoloColors.colorAccent),
              ),
            ),
          ],
        ),
        const SizedBox(height: LoloSpacing.spaceSm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: allBadges.length,
          itemBuilder: (_, i) {
            final badge = allBadges[i];
            final color = _rarityColor(badge.rarity);
            return GestureDetector(
              onTap: () => _showBadgeDetail(context, badge, color),
              child: Semantics(
                label: '${badge.name} badge, ${badge.rarity}'
                    '${badge.isEarned ? ", earned" : ""}',
                child: Container(
                  decoration: BoxDecoration(
                    color: badge.isEarned
                        ? color.withValues(alpha: 0.15)
                        : LoloColors.darkBgSecondary,
                    borderRadius: BorderRadius.circular(12),
                    border: badge.isEarned
                        ? Border.all(color: color.withValues(alpha: 0.5))
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.military_tech,
                        size: 28,
                        color: badge.isEarned ? color : Colors.white24,
                      ),
                      const SizedBox(height: 4),
                      if (!badge.isEarned && badge.progress != null)
                        SizedBox(
                          width: 32,
                          child: LinearProgressIndicator(
                            value: badge.progress!,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation(color),
                            minHeight: 3,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showBadgeDetail(BuildContext context, BadgeEntity badge, Color color) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return Padding(
          padding: const EdgeInsets.all(LoloSpacing.spaceXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.military_tech,
                  size: 48, color: badge.isEarned ? color : Colors.white24),
              const SizedBox(height: LoloSpacing.spaceSm),
              Text(badge.name, style: theme.textTheme.titleLarge),
              const SizedBox(height: LoloSpacing.spaceXs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge.rarity.toUpperCase(),
                  style: TextStyle(color: color, fontSize: 11,
                      fontWeight: FontWeight.w600, letterSpacing: 1),
                ),
              ),
              const SizedBox(height: LoloSpacing.spaceMd),
              Text(badge.description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium),
              if (badge.progressDescription != null) ...[
                const SizedBox(height: LoloSpacing.spaceSm),
                Text(badge.progressDescription!,
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: LoloColors.darkTextSecondary)),
              ],
              const SizedBox(height: LoloSpacing.spaceLg),
            ],
          ),
        );
      },
    );
  }
}
