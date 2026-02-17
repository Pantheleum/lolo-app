import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/presentation/providers/gamification_providers.dart';

/// Badge Gallery screen (Screen 31) with category tabs and 3-column grid.
class BadgeGalleryScreen extends ConsumerWidget {
  const BadgeGalleryScreen({super.key});

  static const _categories = ['All', 'Consistency', 'Milestones', 'Mastery', 'Special'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBadges = ref.watch(badgesProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Badges'),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: LoloColors.colorPrimary,
            indicatorWeight: 3,
            labelColor: Theme.of(context).textTheme.bodyLarge?.color,
            unselectedLabelColor: isDark
                ? LoloColors.darkTextTertiary
                : LoloColors.lightTextTertiary,
            tabs: _categories.map((c) => Tab(text: c)).toList(),
          ),
        ),
        body: asyncBadges.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (badges) {
            final all = [...badges.earned, ...badges.unearned];
            // Sort: earned first (newest first), then unearned (closest to completion)
            all.sort((a, b) {
              if (a.isEarned && !b.isEarned) return -1;
              if (!a.isEarned && b.isEarned) return 1;
              if (a.isEarned && b.isEarned) {
                return (b.earnedAt ?? DateTime(0))
                    .compareTo(a.earnedAt ?? DateTime(0));
              }
              return ((b.progress ?? 0) - (a.progress ?? 0)).sign.toInt();
            });

            return TabBarView(
              children: _categories.map((cat) {
                final filtered = cat == 'All'
                    ? all
                    : all
                        .where((b) =>
                            b.category.toLowerCase() == cat.toLowerCase())
                        .toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: LoloEmptyState(
                      icon: Icons.emoji_events_outlined,
                      title: 'No badges yet',
                      description:
                          'Complete your first action to start earning badges!',
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => _BadgeCell(
                    badge: filtered[i],
                    onTap: () => _showBadgeDetail(context, filtered[i]),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  void _showBadgeDetail(BuildContext context, BadgeEntity badge) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final rarityColor = _rarityColor(badge.rarity);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor:
          isDark ? LoloColors.darkBgSecondary : LoloColors.lightBgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: isDark
                    ? LoloColors.darkBorderDefault
                    : LoloColors.lightBorderDefault,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Badge icon
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: rarityColor.withValues(alpha: 0.15),
                border: badge.isEarned
                    ? Border.all(color: rarityColor, width: 2)
                    : null,
              ),
              child: Icon(
                _badgeIcon(badge.icon),
                size: 40,
                color: badge.isEarned ? rarityColor : LoloColors.gray3,
              ),
            ),
            const SizedBox(height: 16),

            // Name
            Text(badge.name, style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),

            // Rarity
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: rarityColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge.rarity[0].toUpperCase() + badge.rarity.substring(1),
                style: theme.textTheme.labelSmall?.copyWith(color: rarityColor),
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              badge.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? LoloColors.darkTextSecondary
                    : LoloColors.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Progress or earned date
            if (badge.isEarned)
              Text(
                'Earned ${_formatDate(badge.earnedAt!)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: LoloColors.colorSuccess,
                ),
              )
            else if (badge.progress != null) ...[
              Text(
                badge.progressDescription ?? 'Progress',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? LoloColors.darkTextTertiary
                      : LoloColors.lightTextTertiary,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: badge.progress!,
                  backgroundColor: isDark
                      ? LoloColors.darkBgTertiary
                      : LoloColors.lightBgTertiary,
                  color: rarityColor,
                  minHeight: 8,
                ),
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Color _rarityColor(String rarity) => switch (rarity.toLowerCase()) {
        'common' => LoloColors.gray3,
        'uncommon' => LoloColors.colorSuccess,
        'rare' => LoloColors.colorPrimary,
        'epic' => LoloColors.colorEpicPurple,
        'legendary' => LoloColors.colorAccent,
        _ => LoloColors.gray3,
      };

  IconData _badgeIcon(String icon) => switch (icon) {
        'streak' => Icons.local_fire_department,
        'star' => Icons.star,
        'heart' => Icons.favorite,
        'trophy' => Icons.emoji_events,
        'diamond' => Icons.diamond,
        'crown' => Icons.workspace_premium,
        'gift' => Icons.card_giftcard,
        'chat' => Icons.chat_bubble,
        _ => Icons.emoji_events,
      };

  String _formatDate(DateTime d) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month]} ${d.day}, ${d.year}';
  }
}

class _BadgeCell extends StatelessWidget {
  const _BadgeCell({required this.badge, required this.onTap});
  final BadgeEntity badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final rarityColor = switch (badge.rarity.toLowerCase()) {
      'common' => LoloColors.gray3,
      'uncommon' => LoloColors.colorSuccess,
      'rare' => LoloColors.colorPrimary,
      'epic' => LoloColors.colorEpicPurple,
      'legendary' => LoloColors.colorAccent,
      _ => LoloColors.gray3,
    };

    final iconData = switch (badge.icon) {
      'streak' => Icons.local_fire_department,
      'star' => Icons.star,
      'heart' => Icons.favorite,
      'trophy' => Icons.emoji_events,
      'diamond' => Icons.diamond,
      'crown' => Icons.workspace_premium,
      'gift' => Icons.card_giftcard,
      'chat' => Icons.chat_bubble,
      _ => Icons.emoji_events,
    };

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: badge.isEarned
                  ? rarityColor.withValues(alpha: 0.15)
                  : (isDark ? LoloColors.darkBgTertiary : LoloColors.lightBgTertiary),
              border: badge.isEarned
                  ? Border.all(color: rarityColor, width: 2)
                  : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  iconData,
                  size: 28,
                  color: badge.isEarned
                      ? rarityColor
                      : (isDark ? LoloColors.darkTextDisabled : LoloColors.lightTextDisabled),
                ),
                if (!badge.isEarned)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Icon(Icons.lock, size: 14,
                        color: isDark
                            ? LoloColors.darkTextTertiary
                            : LoloColors.lightTextTertiary),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            badge.name,
            style: theme.textTheme.labelSmall?.copyWith(
              color: badge.isEarned
                  ? null
                  : (isDark ? LoloColors.darkTextTertiary : LoloColors.lightTextTertiary),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
