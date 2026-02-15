import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';
import 'package:lolo/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:lolo/features/reminders/domain/usecases/create_reminder_usecase.dart';

class MockRemindersRepository extends Mock implements RemindersRepository {}

void main() {
  late CreateReminderUseCase useCase;
  late MockRemindersRepository mockRepository;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  setUp(() {
    mockRepository = MockRemindersRepository();
    useCase = CreateReminderUseCase(mockRepository);
  });

  setUpAll(() {
    registerFallbackValue(
      ReminderEntity(
        id: '',
        userId: '',
        title: '',
        type: '',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  });

  ReminderEntity createReminder({
    DateTime? date,
    bool isRecurring = false,
  }) {
    return ReminderEntity(
      id: 'r1',
      userId: 'u1',
      title: 'Test Reminder',
      type: 'custom',
      date: date ?? today.add(const Duration(days: 5)),
      isRecurring: isRecurring,
      createdAt: now,
      updatedAt: now,
    );
  }

  group('CreateReminderUseCase', () {
    test('returns ValidationFailure for past date on non-recurring reminder',
        () async {
      final pastReminder = createReminder(
        date: today.subtract(const Duration(days: 1)),
        isRecurring: false,
      );

      final result = await useCase(pastReminder);

      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, 'Reminder date cannot be in the past.');
        },
        (_) => fail('Expected validation failure'),
      );
      verifyNever(() => mockRepository.createReminder(any()));
    });

    test('allows past date for recurring reminder', () async {
      final recurringPastReminder = createReminder(
        date: today.subtract(const Duration(days: 1)),
        isRecurring: true,
      );

      when(() => mockRepository.createReminder(recurringPastReminder))
          .thenAnswer((_) async => Right(recurringPastReminder));

      final result = await useCase(recurringPastReminder);

      result.fold(
        (failure) => fail('Expected success but got: ${failure.message}'),
        (entity) => expect(entity.id, 'r1'),
      );
      verify(() => mockRepository.createReminder(recurringPastReminder))
          .called(1);
    });

    test('calls repository for future date reminder', () async {
      final futureReminder = createReminder(
        date: today.add(const Duration(days: 5)),
      );

      when(() => mockRepository.createReminder(futureReminder))
          .thenAnswer((_) async => Right(futureReminder));

      final result = await useCase(futureReminder);

      result.fold(
        (failure) => fail('Expected success but got: ${failure.message}'),
        (entity) {
          expect(entity.id, 'r1');
          expect(entity.title, 'Test Reminder');
        },
      );
      verify(() => mockRepository.createReminder(futureReminder)).called(1);
    });

    test('calls repository for today date reminder', () async {
      final todayReminder = createReminder(date: today);

      when(() => mockRepository.createReminder(todayReminder))
          .thenAnswer((_) async => Right(todayReminder));

      final result = await useCase(todayReminder);

      result.fold(
        (failure) => fail('Expected success but got: ${failure.message}'),
        (entity) => expect(entity.id, 'r1'),
      );
    });

    test('returns failure when repository fails', () async {
      final futureReminder = createReminder(
        date: today.add(const Duration(days: 5)),
      );
      const serverFailure = ServerFailure(message: 'Server error');

      when(() => mockRepository.createReminder(futureReminder))
          .thenAnswer((_) async => const Left(serverFailure));

      final result = await useCase(futureReminder);

      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Server error');
        },
        (_) => fail('Expected failure'),
      );
    });

    test('does not call repository when validation fails', () async {
      final pastReminder = createReminder(
        date: today.subtract(const Duration(days: 10)),
      );

      await useCase(pastReminder);

      verifyNever(() => mockRepository.createReminder(any()));
    });
  });
}
