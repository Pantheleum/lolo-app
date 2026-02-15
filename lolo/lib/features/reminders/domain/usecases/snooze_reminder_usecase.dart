import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';
import 'package:lolo/features/reminders/domain/repositories/reminders_repository.dart';

/// Snoozes a reminder for a given duration.
///
/// Valid durations: '1h', '3h', '1d', '3d', '1w'.
class SnoozeReminderUseCase {
  final RemindersRepository _repository;
  const SnoozeReminderUseCase(this._repository);

  static const validDurations = {'1h', '3h', '1d', '3d', '1w'};

  Future<Either<Failure, ReminderEntity>> call(
    String id,
    String duration,
  ) async {
    if (!validDurations.contains(duration)) {
      return const Left(ValidationFailure(message: 'Invalid snooze duration.'));
    }
    return _repository.snoozeReminder(id, duration);
  }
}
