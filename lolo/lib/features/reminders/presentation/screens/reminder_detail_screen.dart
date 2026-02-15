import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/lolo_dialog.dart';
import 'package:lolo/features/reminders/presentation/providers/reminders_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Reminder detail screen: view, edit, snooze, complete, or delete.
class ReminderDetailScreen extends ConsumerWidget {
  const ReminderDetailScreen({required this.reminderId, super.key});

  final String reminderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersNotifierProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: LoloAppBar(
        title: l10n.reminders_detail_title,
        showBackButton: true,
        actions: [
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete_outline, color: LoloColors.colorError),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: remindersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (reminders) {
          final reminder = reminders.where((r) => r.id == reminderId).firstOrNull;
          if (reminder == null) {
            return Center(child: Text(l10n.error_generic));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(reminder.title, style: theme.textTheme.headlineMedium),
                const SizedBox(height: LoloSpacing.spaceXs),

                // Type badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: LoloColors.colorPrimary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    reminder.typeLabel,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: LoloColors.colorPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: LoloSpacing.spaceXl),

                // Date info
                _DetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: l10n.reminders_detail_date,
                  value: '${reminder.date.day}/${reminder.date.month}/${reminder.date.year}',
                ),
                if (reminder.time != null)
                  _DetailRow(
                    icon: Icons.access_time_outlined,
                    label: l10n.reminders_detail_time,
                    value: reminder.time!,
                  ),

                // Days until
                _DetailRow(
                  icon: Icons.timelapse_outlined,
                  label: l10n.reminders_detail_daysUntil,
                  value: reminder.isOverdue
                      ? l10n.reminders_detail_overdue(reminder.daysUntil.abs())
                      : l10n.reminders_detail_inDays(reminder.daysUntil),
                  valueColor:
                      reminder.isOverdue ? LoloColors.colorError : null,
                ),

                // Recurrence
                if (reminder.isRecurring)
                  _DetailRow(
                    icon: Icons.repeat_outlined,
                    label: l10n.reminders_detail_recurrence,
                    value: reminder.recurrenceRule,
                  ),

                // Description
                if (reminder.description != null) ...[
                  const SizedBox(height: LoloSpacing.spaceXl),
                  Text(l10n.reminders_detail_notes,
                      style: theme.textTheme.titleMedium),
                  const SizedBox(height: LoloSpacing.spaceXs),
                  Text(reminder.description!,
                      style: theme.textTheme.bodyMedium),
                ],

                const SizedBox(height: LoloSpacing.space2xl),

                // Action buttons
                if (!reminder.isCompleted) ...[
                  // Complete button
                  LoloPrimaryButton(
                    label: l10n.reminders_detail_button_complete,
                    onPressed: () {
                      ref
                          .read(remindersNotifierProvider.notifier)
                          .completeReminder(reminderId);
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: LoloSpacing.spaceSm),

                  // Snooze button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _showSnoozeSheet(context, ref),
                      child: Text(l10n.reminders_detail_button_snooze),
                    ),
                  ),
                ] else
                  // Completed indicator
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(LoloSpacing.spaceMd),
                    decoration: BoxDecoration(
                      color: LoloColors.colorSuccess.withValues(alpha: 0.12),
                      borderRadius:
                          BorderRadius.circular(LoloSpacing.cardBorderRadius),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle,
                            color: LoloColors.colorSuccess),
                        const SizedBox(width: LoloSpacing.spaceXs),
                        Text(
                          l10n.reminders_detail_completed,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: LoloColors.colorSuccess,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: LoloSpacing.space2xl),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSnoozeSheet(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(LoloSpacing.spaceXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.reminders_snooze_title,
                style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: LoloSpacing.spaceMd),
            ...[
              ('1h', l10n.reminders_snooze_1h),
              ('3h', l10n.reminders_snooze_3h),
              ('1d', l10n.reminders_snooze_1d),
              ('3d', l10n.reminders_snooze_3d),
              ('1w', l10n.reminders_snooze_1w),
            ].map(
              (opt) => ListTile(
                title: Text(opt.$2),
                onTap: () {
                  ref
                      .read(remindersNotifierProvider.notifier)
                      .snoozeReminder(reminderId, opt.$1);
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: LoloSpacing.spaceMd),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await LoloDialog.show(
      context: context,
      title: l10n.reminders_delete_title,
      body: l10n.reminders_delete_message,
      confirmLabel: l10n.common_button_delete,
      variant: DialogVariant.destructive,
    );
    if (confirmed == true && context.mounted) {
      // Delete via provider
      Navigator.of(context).pop();
    }
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: LoloSpacing.spaceSm),
      child: Row(
        children: [
          Icon(icon, size: 20,
              color: isDark
                  ? LoloColors.darkTextSecondary
                  : LoloColors.lightTextSecondary),
          const SizedBox(width: LoloSpacing.spaceSm),
          Text('$label: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? LoloColors.darkTextSecondary
                        : LoloColors.lightTextSecondary,
                  )),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
