import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';
import 'package:lolo/features/reminders/domain/usecases/get_upcoming_reminders_usecase.dart';
import 'package:lolo/features/reminders/domain/usecases/create_reminder_usecase.dart';
import 'package:lolo/features/reminders/domain/usecases/complete_reminder_usecase.dart';
import 'package:lolo/features/reminders/domain/usecases/snooze_reminder_usecase.dart';

part 'reminders_provider.g.dart';

/// Provides the list of reminders with filtering and refresh.
@riverpod
class RemindersNotifier extends _$RemindersNotifier {
  @override
  Future<List<ReminderEntity>> build() async {
    final getUpcoming = ref.watch(getUpcomingRemindersUseCaseProvider);
    final result = await getUpcoming(days: 30);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (reminders) => reminders,
    );
  }

  /// Create a new reminder and refresh the list.
  Future<void> createReminder(ReminderEntity reminder) async {
    final createUseCase = ref.read(createReminderUseCaseProvider);
    final result = await createUseCase(reminder);
    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }

  /// Complete a reminder.
  Future<void> completeReminder(String id, {String? notes}) async {
    final completeUseCase = ref.read(completeReminderUseCaseProvider);
    await completeUseCase(id, notes: notes);
    ref.invalidateSelf();
  }

  /// Snooze a reminder.
  Future<void> snoozeReminder(String id, String duration) async {
    final snoozeUseCase = ref.read(snoozeReminderUseCaseProvider);
    await snoozeUseCase(id, duration);
    ref.invalidateSelf();
  }
}

/// Toggle between calendar and list view modes.
@riverpod
class ReminderViewMode extends _$ReminderViewMode {
  @override
  bool build() => false; // false = list, true = calendar

  void toggle() => state = !state;
}
