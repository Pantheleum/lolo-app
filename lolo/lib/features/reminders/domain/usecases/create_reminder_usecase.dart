import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';
import 'package:lolo/features/reminders/domain/repositories/reminders_repository.dart';

/// Creates a new reminder with automatic notification scheduling.
class CreateReminderUseCase {
  final RemindersRepository _repository;
  const CreateReminderUseCase(this._repository);

  Future<Either<Failure, ReminderEntity>> call(
    ReminderEntity reminder,
  ) async {
    // Validate date is not in the past for non-recurring reminders
    if (!reminder.isRecurring && reminder.daysUntil < 0) {
      return const Left(
        ValidationFailure('Reminder date cannot be in the past.'),
      );
    }
    return _repository.createReminder(reminder);
  }
}
