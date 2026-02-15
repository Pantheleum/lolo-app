import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_empty_state.dart';
import 'package:lolo/core/widgets/lolo_skeleton.dart';
import 'package:lolo/core/widgets/reminder_tile.dart';
import 'package:lolo/features/reminders/presentation/providers/reminders_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Alternative reminders list screen (flat list, no calendar toggle).
class RemindersListScreen extends ConsumerWidget {
  const RemindersListScreen({super.key});

  static ReminderCategory _mapCategory(String type) => switch (type) {
        'birthday' => ReminderCategory.birthday,
        'anniversary' => ReminderCategory.anniversary,
        'islamic_holiday' || 'cultural' => ReminderCategory.holiday,
        _ => ReminderCategory.custom,
      };

  static IconData _iconForType(String type) => switch (type) {
        'birthday' => Icons.cake_outlined,
        'anniversary' => Icons.favorite_outline,
        'islamic_holiday' => Icons.mosque_outlined,
        'cultural' => Icons.public_outlined,
        'promise' => Icons.handshake_outlined,
        _ => Icons.event_outlined,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersNotifierProvider);
    final isCalendarView = ref.watch(reminderViewModeProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: LoloAppBar(
        title: l10n.reminders_title,
        actions: [
          IconButton(
            icon: Icon(
              isCalendarView
                  ? Icons.view_list_outlined
                  : Icons.calendar_month_outlined,
            ),
            onPressed: () =>
                ref.read(reminderViewModeProvider.notifier).toggle(),
            tooltip: isCalendarView
                ? l10n.reminders_view_list
                : l10n.reminders_view_calendar,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/reminders/create'),
        backgroundColor: LoloColors.colorPrimary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: remindersAsync.when(
        loading: () => _RemindersSkeleton(),
        error: (error, _) => Center(child: Text('$error')),
        data: (reminders) {
          if (reminders.isEmpty) {
            return LoloEmptyState(
              icon: Icons.notifications_none_outlined,
              title: l10n.empty_reminders_title,
              subtitle: l10n.empty_reminders_subtitle,
            );
          }

          // Separate overdue from upcoming
          final overdue = reminders.where((r) => r.isOverdue).toList();
          final upcoming = reminders.where((r) => !r.isOverdue).toList();

          return RefreshIndicator(
            onRefresh: () => ref.refresh(remindersNotifierProvider.future),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: LoloSpacing.screenHorizontalPadding,
                vertical: LoloSpacing.spaceMd,
              ),
              children: [
                // Overdue section
                if (overdue.isNotEmpty) ...[
                  _SectionHeader(
                    label: l10n.reminders_section_overdue,
                    color: LoloColors.colorError,
                    count: overdue.length,
                  ),
                  ...overdue.map(
                    (r) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: LoloSpacing.spaceXs,
                      ),
                      child: ReminderTile(
                        title: r.title,
                        date: r.date,
                        category: _mapCategory(r.type),
                        icon: _iconForType(r.type),
                        onTap: () => context.push('/reminders/${r.id}'),
                      ),
                    ),
                  ),
                  const SizedBox(height: LoloSpacing.spaceMd),
                ],

                // Upcoming section
                _SectionHeader(
                  label: l10n.reminders_section_upcoming,
                  count: upcoming.length,
                ),
                ...upcoming.map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: LoloSpacing.spaceXs,
                    ),
                    child: ReminderTile(
                      title: r.title,
                      date: r.date,
                      category: _mapCategory(r.type),
                      icon: _iconForType(r.type),
                      onTap: () => context.push('/reminders/${r.id}'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.label,
    required this.count,
    this.color,
  });

  final String label;
  final int count;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: LoloSpacing.spaceSm),
        child: Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                  ),
            ),
            const SizedBox(width: LoloSpacing.spaceXs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: (color ?? LoloColors.colorPrimary)
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color ?? LoloColors.colorPrimary,
                    ),
              ),
            ),
          ],
        ),
      );
}

class _RemindersSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            5,
            (_) => const Padding(
              padding: EdgeInsets.only(bottom: LoloSpacing.spaceXs),
              child: LoloSkeleton(width: double.infinity, height: 72),
            ),
          ),
        ),
      );
}
