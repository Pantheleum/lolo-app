import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_skeleton.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/presentation/providers/gamification_providers.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

class GamificationHubScreen extends ConsumerWidget {
  const GamificationHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncProfile = ref.watch(gamificationProfileProvider);
    final asyncBadges = ref.watch(badgesProvider);

    return Scaffold(
      appBar: LoloAppBar(title: l10n.gamification),
      body: asyncProfile.when(
        loading: () => const Center(child: LoloSkeleton(type: SkeletonType.card)),
        error: (e, _) => Center(child: Text('$e')),
        data: (profile) => SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LevelCard(profile: profile),
              const SizedBox(height: LoloSpacing.lg),
              _StreakCard(profile: profile),
              const SizedBox(height: LoloSpacing.lg),
              _XpChart(weeklyXp: profile.weeklyXp),
              const SizedBox(height: LoloSpacing.lg),
              asyncBadges.when(
                loading: () => const LoloSkeleton(type: SkeletonType.list),
                error: (e, _) => Text('$e'),
                data: (b) => _BadgeGrid(earned: b.earned, unearned: b.unearned),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.profile});
  final GamificationProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A90D9), Color(0xFF2D5A8E)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                alignment: Alignment.center,
                child: Text('${profile.currentLevel}',
                    style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white)),
              ),
              const SizedBox(width: LoloSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.levelName,
                        style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                    Text('${profile.totalXpEarned} XP total',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: LoloSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: profile.xpProgress,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(LoloColors.colorAccent),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: LoloSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${profile.xpCurrent} XP',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Text('${profile.xpForNextLevel} XP',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.profile});
  final GamificationProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(LoloSpacing.md),
      decoration: BoxDecoration(
        color: LoloColors.darkBgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Text('\uD83D\uDD25', style: TextStyle(fontSize: 32)),
          const SizedBox(width: LoloSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${profile.currentStreak} day streak',
                    style: theme.textTheme.titleMedium),
                Text('Best: ${profile.longestStreak} days',
                    style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.ac_unit, color: LoloColors.colorPrimary, size: 20),
              Text('${profile.freezesAvailable}',
                  style: theme.textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _XpChart extends StatelessWidget {
  const _XpChart({required this.weeklyXp});
  final List<WeeklyXp> weeklyXp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxXp = weeklyXp.fold<int>(1, (m, w) => w.xp > m ? w.xp : m);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weekly Activity', style: theme.textTheme.titleMedium),
        const SizedBox(height: LoloSpacing.md),
        SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: weeklyXp.map((w) => Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${w.xp}', style: const TextStyle(fontSize: 10)),
                    const SizedBox(height: 4),
                    Flexible(
                      child: FractionallySizedBox(
                        heightFactor: w.xp / maxXp,
                        child: Container(
                          decoration: BoxDecoration(
                            color: LoloColors.colorPrimary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(w.day, style: theme.textTheme.labelSmall),
                  ],
                ),
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}

class _BadgeGrid extends StatelessWidget {
  const _BadgeGrid({required this.earned, required this.unearned});
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.badges, style: theme.textTheme.titleMedium),
        const SizedBox(height: LoloSpacing.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: earned.length + unearned.length,
          itemBuilder: (_, i) {
            final badge = i < earned.length ? earned[i] : unearned[i - earned.length];
            return Semantics(
              label: '${badge.name} badge, ${badge.rarity}${badge.isEarned ? ", earned" : ""}',
              child: Tooltip(
                message: badge.name,
                child: Container(
                  decoration: BoxDecoration(
                    color: badge.isEarned
                        ? _rarityColor(badge.rarity).withValues(alpha: 0.15)
                        : LoloColors.darkBgSecondary,
                    borderRadius: BorderRadius.circular(12),
                    border: badge.isEarned
                        ? Border.all(color: _rarityColor(badge.rarity).withValues(alpha: 0.5))
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.military_tech,
                        size: 28,
                        color: badge.isEarned
                            ? _rarityColor(badge.rarity)
                            : Colors.white24,
                      ),
                      const SizedBox(height: 4),
                      if (!badge.isEarned && badge.progress != null)
                        SizedBox(
                          width: 32,
                          child: LinearProgressIndicator(
                            value: badge.progress!,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation(
                                _rarityColor(badge.rarity)),
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
}
