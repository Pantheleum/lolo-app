import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/features/notifications/domain/entities/notification_item_entity.dart';
import 'package:lolo/features/notifications/presentation/providers/notifications_provider.dart';

/// Full-screen notification center with date-grouped tiles,
/// unread indicators, mark-all-read, and pull-to-refresh.
class NotificationCenterScreen extends ConsumerWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);
    final unreadCount = ref.watch(unreadCountProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(title: 'Notifications'),
      body: notificationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Couldn't load notifications.",
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: LoloSpacing.spaceMd),
              TextButton(
                onPressed: () => ref.invalidate(notificationsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(
              child: LoloEmptyState(
                icon: Icons.notifications_none_outlined,
                title: 'No notifications yet',
                description: "We'll keep you posted!",
              ),
            );
          }

          final groups = _groupByDate(notifications);

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(notificationsProvider),
            color: LoloColors.colorPrimary,
            child: CustomScrollView(
              slivers: [
                // Mark all as read
                if (unreadCount > 0)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: LoloSpacing.screenHorizontalPadding,
                        vertical: LoloSpacing.spaceXs,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap: () => markAllNotificationsRead(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Mark all as read',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: LoloColors.colorPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Date-grouped notification tiles
                for (final group in groups) ...[
                  SliverToBoxAdapter(
                    child: _DateGroupHeader(label: group.label, isDark: isDark),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) {
                        final item = group.items[index];
                        return _NotificationTile(
                          item: item,
                          isDark: isDark,
                          onTap: () => _handleTap(context, ref, item),
                        );
                      },
                      childCount: group.items.length,
                    ),
                  ),
                ],

                // Bottom padding for nav bar clearance
                const SliverToBoxAdapter(
                  child: SizedBox(height: LoloSpacing.screenBottomPadding),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleTap(
      BuildContext context, WidgetRef ref, NotificationItemEntity item) {
    if (!item.isRead) {
      markNotificationRead(item.id);
    }
    if (item.actionType == 'route' && item.actionTarget != null) {
      context.push(item.actionTarget!);
    }
  }

  /// Group notifications by Today / Yesterday / Earlier.
  List<_DateGroup> _groupByDate(List<NotificationItemEntity> items) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final todayItems = <NotificationItemEntity>[];
    final yesterdayItems = <NotificationItemEntity>[];
    final earlierItems = <NotificationItemEntity>[];

    for (final item in items) {
      final date = DateTime(
          item.createdAt.year, item.createdAt.month, item.createdAt.day);
      if (date == today) {
        todayItems.add(item);
      } else if (date == yesterday) {
        yesterdayItems.add(item);
      } else {
        earlierItems.add(item);
      }
    }

    return [
      if (todayItems.isNotEmpty) _DateGroup('Today', todayItems),
      if (yesterdayItems.isNotEmpty) _DateGroup('Yesterday', yesterdayItems),
      if (earlierItems.isNotEmpty) _DateGroup('Earlier', earlierItems),
    ];
  }
}

class _DateGroup {
  const _DateGroup(this.label, this.items);
  final String label;
  final List<NotificationItemEntity> items;
}

// === Private Widgets ===

class _DateGroupHeader extends StatelessWidget {
  const _DateGroupHeader({required this.label, required this.isDark});
  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: LoloSpacing.screenHorizontalPadding,
        vertical: 8,
      ),
      color: isDark ? LoloColors.darkBgPrimary : LoloColors.lightBgPrimary,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isDark
                  ? LoloColors.darkTextTertiary
                  : LoloColors.lightTextTertiary,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.item,
    required this.isDark,
    required this.onTap,
  });

  final NotificationItemEntity item;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typeStyle = _typeStyle(item.type);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: item.isRead
                ? BorderSide.none
                : const BorderSide(
                    width: 3,
                    color: LoloColors.colorPrimary,
                  ),
            bottom: BorderSide(
              color: (isDark
                      ? LoloColors.darkBorderDefault
                      : LoloColors.lightBorderDefault)
                  .withValues(alpha: 0.5),
            ),
          ),
        ),
        padding: EdgeInsetsDirectional.fromSTEB(
          item.isRead
              ? LoloSpacing.screenHorizontalPadding
              : LoloSpacing.screenHorizontalPadding - 3,
          12,
          LoloSpacing.screenHorizontalPadding,
          12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: typeStyle.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(typeStyle.icon, size: 20, color: typeStyle.color),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: item.isRead ? FontWeight.w400 : FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.body,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? LoloColors.darkTextSecondary
                          : LoloColors.lightTextSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Timestamp + chevron
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _relativeTime(item.createdAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? LoloColors.darkTextTertiary
                        : LoloColors.lightTextTertiary,
                  ),
                ),
                if (item.actionType == 'route') ...[
                  const SizedBox(height: 8),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: isDark
                        ? LoloColors.darkTextTertiary
                        : LoloColors.lightTextTertiary,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  _TypeStyle _typeStyle(NotificationType type) => switch (type) {
        NotificationType.reminder => const _TypeStyle(
            Icons.notifications_outlined, LoloColors.colorPrimary),
        NotificationType.message => const _TypeStyle(
            Icons.chat_bubble_outline, LoloColors.colorSuccess),
        NotificationType.streak =>
            const _TypeStyle(Icons.local_fire_department, Color(0xFFD29922)),
        NotificationType.gift =>
            const _TypeStyle(Icons.card_giftcard, LoloColors.colorAccent),
        NotificationType.sos =>
            const _TypeStyle(Icons.warning_amber, LoloColors.colorError),
        NotificationType.gamification =>
            const _TypeStyle(Icons.emoji_events, Color(0xFFD29922)),
        NotificationType.actionCard =>
            const _TypeStyle(Icons.task_alt, LoloColors.colorPrimary),
        NotificationType.subscription =>
            const _TypeStyle(Icons.workspace_premium, LoloColors.colorAccent),
        NotificationType.system =>
            const _TypeStyle(Icons.settings_outlined, Color(0xFF8B949E)),
      };

  String _relativeTime(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    final m = _monthName(dateTime.month);
    return '$m ${dateTime.day}';
  }

  String _monthName(int month) => const [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ][month];
}

class _TypeStyle {
  const _TypeStyle(this.icon, this.color);
  final IconData icon;
  final Color color;
}
