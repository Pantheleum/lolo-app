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

/// Main reminders screen with list/calendar toggle, overdue section,
/// upcoming section grouped by date, and FAB for creating reminders.
class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

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

          if (isCalendarView) {
            return _CalendarView(
              reminders: reminders,
              onTap: (r) => context.push('/reminders/${r.id}'),
            );
          }

          // Separate overdue from upcoming
          final overdue = reminders.where((r) => r.isOverdue).toList();
          final upcoming = reminders.where((r) => !r.isOverdue).toList();

          // Group upcoming by date
          final grouped = <String, List<dynamic>>{};
          for (final r in upcoming) {
            final key =
                '${r.date.day}/${r.date.month}/${r.date.year}';
            grouped.putIfAbsent(key, () => []).add(r);
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.refresh(remindersNotifierProvider.future),
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
                      child: Dismissible(
                        key: ValueKey('reminder-${r.id}'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: LoloColors.colorSuccess
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.check,
                              color: LoloColors.colorSuccess),
                        ),
                        confirmDismiss: (_) async {
                          ref
                              .read(remindersNotifierProvider.notifier)
                              .completeReminder(r.id);
                          return false;
                        },
                        child: ReminderTile(
                          title: r.title,
                          date: r.date,
                          category: _mapCategory(r.type),
                          icon: _iconForType(r.type),
                          onTap: () =>
                              context.push('/reminders/${r.id}'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: LoloSpacing.spaceMd),
                ],

                // Upcoming section grouped by date
                ...grouped.entries.expand((entry) => [
                      _SectionHeader(
                        label: entry.key,
                        count: entry.value.length,
                      ),
                      ...entry.value.map(
                        (r) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: LoloSpacing.spaceXs,
                          ),
                          child: Dismissible(
                            key: ValueKey('reminder-${r.id}'),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: LoloColors.colorSuccess
                                    .withValues(alpha: 0.15),
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.check,
                                  color: LoloColors.colorSuccess),
                            ),
                            confirmDismiss: (_) async {
                              ref
                                  .read(remindersNotifierProvider
                                      .notifier)
                                  .completeReminder(r.id);
                              return false;
                            },
                            child: ReminderTile(
                              title: r.title,
                              date: r.date,
                              category: _mapCategory(r.type),
                              icon: _iconForType(r.type),
                              onTap: () =>
                                  context.push('/reminders/${r.id}'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: LoloSpacing.spaceSm),
                    ]),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Calendar view showing reminders on a monthly calendar grid.
class _CalendarView extends StatefulWidget {
  const _CalendarView({required this.reminders, required this.onTap});
  final List<dynamic> reminders;
  final void Function(dynamic) onTap;

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  late DateTime _focusedMonth;

  @override
  void initState() {
    super.initState();
    _focusedMonth = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final now = DateTime.now();
    final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final lastDay = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);
    final startWeekday = firstDay.weekday % 7; // 0=Sun

    // Build set of days that have reminders this month
    final reminderDays = <int, List<dynamic>>{};
    for (final r in widget.reminders) {
      if (r.date.year == _focusedMonth.year &&
          r.date.month == _focusedMonth.month) {
        reminderDays.putIfAbsent(r.date.day, () => []).add(r);
      }
    }

    return Column(
      children: [
        // Month navigation
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LoloSpacing.screenHorizontalPadding,
            vertical: LoloSpacing.spaceSm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(() {
                  _focusedMonth = DateTime(
                      _focusedMonth.year, _focusedMonth.month - 1);
                }),
              ),
              Text(
                '${_monthName(_focusedMonth.month)} ${_focusedMonth.year}',
                style: theme.textTheme.titleMedium,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => setState(() {
                  _focusedMonth = DateTime(
                      _focusedMonth.year, _focusedMonth.month + 1);
                }),
              ),
            ],
          ),
        ),
        // Day headers
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: LoloSpacing.screenHorizontalPadding),
          child: Row(
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(d,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isDark
                                  ? LoloColors.darkTextSecondary
                                  : LoloColors.lightTextSecondary,
                            )),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: LoloSpacing.spaceXs),
        // Calendar grid
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: LoloSpacing.screenHorizontalPadding),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: startWeekday + lastDay.day,
            itemBuilder: (_, i) {
              if (i < startWeekday) return const SizedBox.shrink();
              final day = i - startWeekday + 1;
              final hasReminder = reminderDays.containsKey(day);
              final isToday = now.year == _focusedMonth.year &&
                  now.month == _focusedMonth.month &&
                  now.day == day;

              return GestureDetector(
                onTap: hasReminder
                    ? () {
                        for (final r in reminderDays[day]!) {
                          widget.onTap(r);
                        }
                      }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: isToday
                        ? LoloColors.colorPrimary.withValues(alpha: 0.2)
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$day',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (hasReminder)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: const BoxDecoration(
                            color: LoloColors.colorAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: LoloSpacing.spaceMd),
        // Reminders for selected month below calendar
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
                horizontal: LoloSpacing.screenHorizontalPadding),
            children: widget.reminders
                .where((r) =>
                    r.date.year == _focusedMonth.year &&
                    r.date.month == _focusedMonth.month)
                .map((r) => Padding(
                      padding: const EdgeInsets.only(
                          bottom: LoloSpacing.spaceXs),
                      child: ReminderTile(
                        title: r.title,
                        date: r.date,
                        category: RemindersScreen._mapCategory(r.type),
                        icon: RemindersScreen._iconForType(r.type),
                        onTap: () => widget.onTap(r),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  String _monthName(int month) => const [
        '', 'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December',
      ][month];
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
        padding:
            const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            5,
            (_) => const Padding(
              padding: EdgeInsets.only(bottom: LoloSpacing.spaceXs),
              child:
                  LoloSkeleton(width: double.infinity, height: 72),
            ),
          ),
        ),
      );
}
