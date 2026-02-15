import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';

/// Contract for reminder data access with offline-first support.
abstract class RemindersRepository {
  /// Get all reminders with optional type and status filters.
  Future<Either<Failure, List<ReminderEntity>>> getReminders({
    String? type,
    String status = 'active',
    int limit = 20,
    String? lastDocId,
  });

  /// Get upcoming reminders within a look-ahead window.
  Future<Either<Failure, List<ReminderEntity>>> getUpcomingReminders({
    int days = 7,
  });

  /// Create a new reminder.
  Future<Either<Failure, ReminderEntity>> createReminder(
    ReminderEntity reminder,
  );

  /// Update an existing reminder.
  Future<Either<Failure, ReminderEntity>> updateReminder(
    String id,
    Map<String, dynamic> updates,
  );

  /// Delete a reminder and cancel its notifications.
  Future<Either<Failure, void>> deleteReminder(String id);

  /// Mark a reminder as completed.
  Future<Either<Failure, ReminderEntity>> completeReminder(
    String id, {
    String? notes,
  });

  /// Snooze a reminder for a specified duration.
  Future<Either<Failure, ReminderEntity>> snoozeReminder(
    String id,
    String duration,
  );
}
