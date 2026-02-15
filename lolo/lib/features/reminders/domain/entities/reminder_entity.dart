import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_entity.freezed.dart';

/// Core reminder entity for the Smart Reminders module.
///
/// Supports multiple types (birthday, anniversary, islamic_holiday,
/// cultural, custom, promise) with recurrence rules and multi-tier
/// notification scheduling.
@freezed
class ReminderEntity with _$ReminderEntity {
  const factory ReminderEntity({
    required String id,
    required String userId,
    required String title,
    String? description,
    required String type,
    required DateTime date,
    String? time,
    @Default(false) bool isRecurring,
    @Default('none') String recurrenceRule,
    @Default([7, 3, 1, 0]) List<int> reminderTiers,
    @Default('active') String status,
    DateTime? snoozedUntil,
    String? linkedProfileId,
    @Default(false) bool linkedGiftSuggestion,
    String? notes,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReminderEntity;

  const ReminderEntity._();

  /// Days until this reminder's date from now.
  int get daysUntil {
    final now = DateTime.now();
    final target = DateTime(date.year, date.month, date.day);
    final today = DateTime(now.year, now.month, now.day);
    return target.difference(today).inDays;
  }

  /// Whether this reminder is overdue (past date, not completed).
  bool get isOverdue => daysUntil < 0 && status == 'active';

  /// Whether this reminder is snoozed and the snooze period is still active.
  bool get isSnoozed =>
      status == 'snoozed' &&
      snoozedUntil != null &&
      snoozedUntil!.isAfter(DateTime.now());

  /// Whether this reminder has been completed.
  bool get isCompleted => status == 'completed';

  /// Urgency level based on days until the event.
  String get urgencyLevel {
    final days = daysUntil;
    if (days < 0) return 'critical';
    if (days <= 1) return 'critical';
    if (days <= 3) return 'high';
    if (days <= 7) return 'medium';
    return 'low';
  }

  /// Display-friendly type label.
  String get typeLabel => switch (type) {
        'birthday' => 'Birthday',
        'anniversary' => 'Anniversary',
        'islamic_holiday' => 'Islamic Holiday',
        'cultural' => 'Cultural',
        'custom' => 'Custom',
        'promise' => 'Promise',
        _ => type,
      };
}
