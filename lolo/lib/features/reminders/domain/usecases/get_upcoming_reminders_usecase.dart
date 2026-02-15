import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';
import 'package:lolo/features/reminders/domain/repositories/reminders_repository.dart';

/// Fetches upcoming reminders sorted by date ascending.
class GetUpcomingRemindersUseCase {
  final RemindersRepository _repository;
  const GetUpcomingRemindersUseCase(this._repository);

  Future<Either<Failure, List<ReminderEntity>>> call({int days = 7}) =>
      _repository.getUpcomingReminders(days: days);
}
