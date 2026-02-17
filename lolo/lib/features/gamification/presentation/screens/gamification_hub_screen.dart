import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_skeleton.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/presentation/providers/gamification_providers.dart';
import 'package:lolo/features/gamification/presentation/widgets/xp_progress_bar.dart';
import 'package:lolo/features/gamification/presentation/widgets/badge_grid.dart';
import 'package:lolo/features/gamification/presentation/widgets/streak_calendar.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Full gamification hub with level display, streak, weekly chart,
/// badge collection grid, and leaderboard preview.
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
        loading: () => const Center(child: LoloSkeleton.card()),
        error: (e, _) => Center(child: Text('$e')),
        data: (profile) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(gamificationProfileProvider);
            ref.invalidate(badgesProvider);
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(LoloSpacing.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Level card with animated XP bar
                _LevelCard(profile: profile),
                const SizedBox(height: LoloSpacing.spaceLg),

                // Streak section
                _StreakCard(profile: profile),
                const SizedBox(height: LoloSpacing.spaceLg),

                // Streak calendar dots for the week
                StreakCalendar(weeklyXp: profile.weeklyXp),
                const SizedBox(height: LoloSpacing.spaceLg),

                // Weekly stats chart + "View Stats" link
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Weekly Activity', style: Theme.of(context).textTheme.titleMedium),
                    TextButton(
                      onPressed: () => context.push('/profile/gamification/stats'),
                      child: Text('View Stats',
                          style: TextStyle(color: LoloColors.colorPrimary)),
                    ),
                  ],
                ),
                _XpChart(weeklyXp: profile.weeklyXp),
                const SizedBox(height: LoloSpacing.spaceLg),

                // Badge collection grid + "See All" link
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Badges', style: Theme.of(context).textTheme.titleMedium),
                    TextButton(
                      onPressed: () => context.push('/profile/gamification/badges'),
                      child: Text('See All',
                          style: TextStyle(color: LoloColors.colorPrimary)),
                    ),
                  ],
                ),
                asyncBadges.when(
                  loading: () => const LoloSkeleton(
                      width: double.infinity, height: 120),
                  error: (e, _) => Text('$e'),
                  data: (b) => BadgeGrid(
                      earned: b.earned, unearned: b.unearned),
                ),
                const SizedBox(height: LoloSpacing.spaceLg),

                // Leaderboard preview
                _LeaderboardPreview(),
              ],
            ),
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
      padding: const EdgeInsets.all(LoloSpacing.spaceLg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [LoloColors.colorPrimary, LoloColors.colorPrimaryDark],
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
              const SizedBox(width: LoloSpacing.spaceMd),
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
          const SizedBox(height: LoloSpacing.spaceMd),
          XpProgressBar(
            progress: profile.xpProgress,
            currentXp: profile.xpCurrent,
            targetXp: profile.xpForNextLevel,
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
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(LoloSpacing.spaceMd),
      decoration: BoxDecoration(
        color: isDark ? LoloColors.darkBgSecondary : LoloColors.lightBgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Text('\uD83D\uDD25', style: TextStyle(fontSize: 32)),
          const SizedBox(width: LoloSpacing.spaceMd),
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
          // Freeze button
          GestureDetector(
            onTap: profile.freezesAvailable > 0
                ? () => _showFreezeDialog(context)
                : null,
            child: Column(
              children: [
                Icon(Icons.ac_unit,
                    color: profile.freezesAvailable > 0
                        ? LoloColors.colorPrimary
                        : (isDark ? LoloColors.darkTextDisabled : LoloColors.lightTextDisabled),
                    size: 20),
                Text('${profile.freezesAvailable}',
                    style: theme.textTheme.labelSmall),
                Text('freezes', style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    color: isDark ? LoloColors.darkTextSecondary : LoloColors.lightTextSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFreezeDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Use Streak Freeze?'),
        content: const Text(
            'This will protect your streak for one missed day. '
            'You cannot undo this action.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // TODO: Call freeze API when backend endpoint is ready
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Streak freeze applied!'),
                  backgroundColor: LoloColors.colorSuccess,
                ),
              );
            },
            child: const Text('Use Freeze'),
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
        SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: weeklyXp.map((w) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${w.xp}', style: const TextStyle(fontSize: 10)),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
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

/// Leaderboard preview showing top 3 users as placeholder.
class _LeaderboardPreview extends StatelessWidget {
  static const _mockLeaders = [
    ('Ahmed K.', 4820, 1),
    ('Omar S.', 4350, 2),
    ('Youssef M.', 3980, 3),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Leaderboard', style: theme.textTheme.titleMedium),
        const SizedBox(height: LoloSpacing.spaceSm),
        ...List.generate(_mockLeaders.length, (i) {
          final (name, xp, rank) = _mockLeaders[i];
          final medalColor = switch (rank) {
            1 => LoloColors.colorAccent,
            2 => LoloColors.gray2,
            3 => LoloColors.colorBronze,
            _ => Colors.transparent,
          };
          return Padding(
            padding: const EdgeInsets.only(bottom: LoloSpacing.spaceXs),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: LoloSpacing.spaceMd,
                vertical: LoloSpacing.spaceSm,
              ),
              decoration: BoxDecoration(
                color: isDark ? LoloColors.darkBgSecondary : LoloColors.lightBgSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: medalColor.withValues(alpha: 0.2),
                    ),
                    alignment: Alignment.center,
                    child: Text('$rank',
                        style: TextStyle(
                            color: medalColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ),
                  const SizedBox(width: LoloSpacing.spaceSm),
                  Expanded(child: Text(name, style: theme.textTheme.bodyMedium)),
                  Text('$xp XP',
                      style: theme.textTheme.labelMedium?.copyWith(
                          color: LoloColors.colorAccent)),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
