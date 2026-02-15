import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/core/services/notification_service.dart';
import 'package:lolo/features/reminders/data/datasources/reminders_remote_datasource.dart';
import 'package:lolo/features/reminders/data/repositories/reminders_repository_impl.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';
import 'package:lolo/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:lolo/features/reminders/domain/usecases/get_upcoming_reminders_usecase.dart';
import 'package:lolo/features/reminders/domain/usecases/create_reminder_usecase.dart';
import 'package:lolo/features/reminders/domain/usecases/complete_reminder_usecase.dart';
import 'package:lolo/features/reminders/domain/usecases/snooze_reminder_usecase.dart';

// ---------------------------------------------------------------------------
// Data source, repository, and use case providers
// ---------------------------------------------------------------------------

final remindersRemoteDataSourceProvider =
    Provider<RemindersRemoteDataSource>((ref) {
  return RemindersRemoteDataSource(ref.watch(dioProvider));
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final remindersRepositoryProvider = Provider<RemindersRepository>((ref) {
  return RemindersRepositoryImpl(
    remote: ref.watch(remindersRemoteDataSourceProvider),
    notificationService: ref.watch(notificationServiceProvider),
  );
});

final getUpcomingRemindersUseCaseProvider =
    Provider<GetUpcomingRemindersUseCase>((ref) {
  return GetUpcomingRemindersUseCase(ref.watch(remindersRepositoryProvider));
});

final createReminderUseCaseProvider = Provider<CreateReminderUseCase>((ref) {
  return CreateReminderUseCase(ref.watch(remindersRepositoryProvider));
});

final completeReminderUseCaseProvider =
    Provider<CompleteReminderUseCase>((ref) {
  return CompleteReminderUseCase(ref.watch(remindersRepositoryProvider));
});

final snoozeReminderUseCaseProvider = Provider<SnoozeReminderUseCase>((ref) {
  return SnoozeReminderUseCase(ref.watch(remindersRepositoryProvider));
});

// ---------------------------------------------------------------------------
// Presentation providers
// ---------------------------------------------------------------------------

/// Provides the list of reminders with filtering and refresh.
class RemindersNotifier extends AsyncNotifier<List<ReminderEntity>> {
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

final remindersNotifierProvider =
    AsyncNotifierProvider<RemindersNotifier, List<ReminderEntity>>(
  RemindersNotifier.new,
);

/// Toggle between calendar and list view modes.
class ReminderViewMode extends Notifier<bool> {
  @override
  bool build() => false; // false = list, true = calendar

  void toggle() => state = !state;
}

final reminderViewModeProvider = NotifierProvider<ReminderViewMode, bool>(
  ReminderViewMode.new,
);
