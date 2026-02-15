import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/theme/lolo_colors.dart';
import 'package:lolo/core/theme/lolo_spacing.dart';
import 'package:lolo/core/widgets/lolo_app_bar.dart';
import 'package:lolo/core/widgets/lolo_primary_button.dart';
import 'package:lolo/core/widgets/lolo_text_field.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';
import 'package:lolo/features/reminders/presentation/providers/reminders_provider.dart';
import 'package:lolo/generated/l10n/app_localizations.dart';

/// Full reminder creation form with category chips, recurrence picker,
/// and date/time selection.
class CreateReminderScreen extends ConsumerStatefulWidget {
  const CreateReminderScreen({super.key});

  @override
  ConsumerState<CreateReminderScreen> createState() =>
      _CreateReminderScreenState();
}

class _CreateReminderScreenState
    extends ConsumerState<CreateReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _type = 'custom';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _recurrence = 'none';
  bool _isSubmitting = false;

  static const _categories = [
    ('birthday', Icons.cake_outlined, 'Birthday'),
    ('anniversary', Icons.favorite_outline, 'Anniversary'),
    ('islamic_holiday', Icons.mosque_outlined, 'Islamic Holiday'),
    ('cultural', Icons.public_outlined, 'Cultural'),
    ('custom', Icons.event_outlined, 'Custom'),
    ('promise', Icons.handshake_outlined, 'Promise'),
  ];

  static const _recurrenceOptions = [
    ('none', 'No repeat'),
    ('weekly', 'Weekly'),
    ('monthly', 'Monthly'),
    ('yearly', 'Yearly'),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: LoloAppBar(
        title: l10n.reminders_create_title,
        showBackButton: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(LoloSpacing.screenHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              LoloTextField(
                controller: _titleController,
                label: l10n.reminders_create_label_title,
                hint: l10n.reminders_create_hint_title,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Title is required'
                    : null,
              ),
              const SizedBox(height: LoloSpacing.spaceMd),

              // Category chips
              Text(l10n.reminders_create_label_category,
                  style: theme.textTheme.titleMedium),
              const SizedBox(height: LoloSpacing.spaceSm),
              Wrap(
                spacing: LoloSpacing.spaceXs,
                runSpacing: LoloSpacing.spaceXs,
                children: _categories.map((cat) {
                  final (key, icon, label) = cat;
                  final isSelected = _type == key;
                  return ChoiceChip(
                    avatar: Icon(icon, size: 18),
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _type = key),
                  );
                }).toList(),
              ),
              const SizedBox(height: LoloSpacing.spaceMd),

              // Date picker
              Text(l10n.reminders_create_label_date,
                  style: theme.textTheme.titleMedium),
              const SizedBox(height: LoloSpacing.spaceSm),
              _DatePickerTile(
                date: _selectedDate,
                onTap: _pickDate,
              ),
              const SizedBox(height: LoloSpacing.spaceMd),

              // Time picker (optional)
              Text(l10n.reminders_create_label_time,
                  style: theme.textTheme.titleMedium),
              const SizedBox(height: LoloSpacing.spaceSm),
              _TimePickerTile(
                time: _selectedTime,
                onTap: _pickTime,
              ),
              const SizedBox(height: LoloSpacing.spaceMd),

              // Recurrence
              Text(l10n.reminders_create_label_recurrence,
                  style: theme.textTheme.titleMedium),
              const SizedBox(height: LoloSpacing.spaceSm),
              DropdownButtonFormField<String>(
                value: _recurrence,
                items: _recurrenceOptions
                    .map((opt) => DropdownMenuItem(
                          value: opt.$1,
                          child: Text(opt.$2),
                        ))
                    .toList(),
                onChanged: (val) =>
                    setState(() => _recurrence = val ?? 'none'),
              ),
              const SizedBox(height: LoloSpacing.spaceMd),

              // Description
              LoloTextField(
                controller: _descriptionController,
                label: l10n.reminders_create_label_notes,
                hint: l10n.reminders_create_hint_notes,
                maxLines: 3,
              ),

              const SizedBox(height: LoloSpacing.space2xl),

              // Submit
              LoloPrimaryButton(
                label: l10n.reminders_create_button_save,
                isLoading: _isSubmitting,
                onPressed: _submit,
              ),
              const SizedBox(height: LoloSpacing.space2xl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_selectedDate == null) return;

    setState(() => _isSubmitting = true);

    final now = DateTime.now();
    final reminder = ReminderEntity(
      id: '',
      userId: '',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isNotEmpty
          ? _descriptionController.text.trim()
          : null,
      type: _type,
      date: _selectedDate!,
      time: _selectedTime != null
          ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
          : null,
      isRecurring: _recurrence != 'none',
      recurrenceRule: _recurrence,
      createdAt: now,
      updatedAt: now,
    );

    try {
      await ref.read(remindersNotifierProvider.notifier).createReminder(
            reminder,
          );
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}

class _DatePickerTile extends StatelessWidget {
  const _DatePickerTile({required this.date, required this.onTap});
  final DateTime? date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(LoloSpacing.spaceMd),
        decoration: BoxDecoration(
          color: isDark
              ? LoloColors.darkSurfaceElevated1
              : LoloColors.lightBgTertiary,
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          border: Border.all(
            color: isDark
                ? LoloColors.darkBorderDefault
                : LoloColors.lightBorderDefault,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 20),
            const SizedBox(width: LoloSpacing.spaceSm),
            Text(
              date != null
                  ? '${date!.day}/${date!.month}/${date!.year}'
                  : 'Select date',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimePickerTile extends StatelessWidget {
  const _TimePickerTile({required this.time, required this.onTap});
  final TimeOfDay? time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(LoloSpacing.spaceMd),
        decoration: BoxDecoration(
          color: isDark
              ? LoloColors.darkSurfaceElevated1
              : LoloColors.lightBgTertiary,
          borderRadius: BorderRadius.circular(LoloSpacing.cardBorderRadius),
          border: Border.all(
            color: isDark
                ? LoloColors.darkBorderDefault
                : LoloColors.lightBorderDefault,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time_outlined, size: 20),
            const SizedBox(width: LoloSpacing.spaceSm),
            Text(
              time != null ? time!.format(context) : 'No time set (optional)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
