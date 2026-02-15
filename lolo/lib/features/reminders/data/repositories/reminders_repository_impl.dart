import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/errors/exceptions.dart';
import 'package:lolo/core/services/notification_service.dart';
import 'package:lolo/features/reminders/data/datasources/reminders_remote_datasource.dart';
import 'package:lolo/features/reminders/data/models/reminder_model.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';
import 'package:lolo/features/reminders/domain/repositories/reminders_repository.dart';

/// Implementation of [RemindersRepository].
///
/// Syncs with Firestore via API and schedules local notifications
/// via flutter_local_notifications for each reminder tier.
class RemindersRepositoryImpl implements RemindersRepository {
  final RemindersRemoteDataSource _remote;
  final NotificationService _notificationService;

  const RemindersRepositoryImpl({
    required RemindersRemoteDataSource remote,
    required NotificationService notificationService,
  })  : _remote = remote,
        _notificationService = notificationService;

  @override
  Future<Either<Failure, List<ReminderEntity>>> getReminders({
    String? type,
    String status = 'active',
    int limit = 20,
    String? lastDocId,
  }) async {
    try {
      final models = await _remote.getReminders(
        type: type,
        status: status,
        limit: limit,
        lastDocId: lastDocId,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ReminderEntity>>> getUpcomingReminders({
    int days = 7,
  }) async {
    try {
      final models = await _remote.getUpcomingReminders(days: days);
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ReminderEntity>> createReminder(
    ReminderEntity reminder,
  ) async {
    try {
      final model = ReminderModel.fromEntity(reminder);
      final created = await _remote.createReminder(model);
      final entity = created.toEntity();

      // Schedule local notifications for each tier
      await _scheduleNotifications(entity);

      return Right(entity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ReminderEntity>> updateReminder(
    String id,
    Map<String, dynamic> updates,
  ) async {
    try {
      final updated = await _remote.updateReminder(id, updates);
      final entity = updated.toEntity();

      // Reschedule notifications
      await _notificationService.cancelReminder(id);
      await _scheduleNotifications(entity);

      return Right(entity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReminder(String id) async {
    try {
      await _remote.deleteReminder(id);
      await _notificationService.cancelReminder(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ReminderEntity>> completeReminder(
    String id, {
    String? notes,
  }) async {
    try {
      final completed = await _remote.completeReminder(id, notes: notes);
      await _notificationService.cancelReminder(id);
      return Right(completed.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ReminderEntity>> snoozeReminder(
    String id,
    String duration,
  ) async {
    try {
      final snoozed = await _remote.snoozeReminder(id, duration);
      return Right(snoozed.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  /// Schedule local notifications for each reminder tier.
  Future<void> _scheduleNotifications(ReminderEntity entity) async {
    for (final tier in entity.reminderTiers) {
      final notifyDate = entity.date.subtract(Duration(days: tier));
      if (notifyDate.isAfter(DateTime.now())) {
        await _notificationService.scheduleReminder(
          id: '${entity.id}_$tier',
          title: entity.title,
          body: tier == 0
              ? 'Today is the day!'
              : '$tier days until ${entity.title}',
          scheduledDate: notifyDate,
        );
      }
    }
  }
}
