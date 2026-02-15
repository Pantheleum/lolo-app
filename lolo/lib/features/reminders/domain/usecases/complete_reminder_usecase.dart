import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';
import 'package:lolo/features/reminders/domain/repositories/reminders_repository.dart';

/// Marks a reminder as completed and awards XP.
class CompleteReminderUseCase {
  final RemindersRepository _repository;
  const CompleteReminderUseCase(this._repository);

  Future<Either<Failure, ReminderEntity>> call(
    String id, {
    String? notes,
  }) =>
      _repository.completeReminder(id, notes: notes);
}
