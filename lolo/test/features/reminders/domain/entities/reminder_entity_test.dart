import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';

void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  ReminderEntity createReminder({
    DateTime? date,
    String status = 'active',
    bool isRecurring = false,
    String type = 'custom',
    DateTime? snoozedUntil,
  }) {
    return ReminderEntity(
      id: 'reminder-1',
      userId: 'user-1',
      title: 'Test Reminder',
      type: type,
      date: date ?? today.add(const Duration(days: 5)),
      status: status,
      isRecurring: isRecurring,
      snoozedUntil: snoozedUntil,
      createdAt: now,
      updatedAt: now,
    );
  }

  group('ReminderEntity creation', () {
    test('creates with required fields', () {
      final reminder = createReminder();
      expect(reminder.id, 'reminder-1');
      expect(reminder.userId, 'user-1');
      expect(reminder.title, 'Test Reminder');
      expect(reminder.type, 'custom');
      expect(reminder.status, 'active');
    });

    test('has correct default values', () {
      final reminder = createReminder();
      expect(reminder.isRecurring, false);
      expect(reminder.recurrenceRule, 'none');
      expect(reminder.reminderTiers, [7, 3, 1, 0]);
      expect(reminder.linkedGiftSuggestion, false);
      expect(reminder.description, isNull);
      expect(reminder.time, isNull);
      expect(reminder.snoozedUntil, isNull);
      expect(reminder.linkedProfileId, isNull);
      expect(reminder.notes, isNull);
      expect(reminder.completedAt, isNull);
    });

    test('creates with all optional fields', () {
      final reminder = ReminderEntity(
        id: 'r1',
        userId: 'u1',
        title: 'Birthday',
        description: 'Her birthday',
        type: 'birthday',
        date: today.add(const Duration(days: 10)),
        time: '09:00',
        isRecurring: true,
        recurrenceRule: 'yearly',
        reminderTiers: [14, 7, 3, 1, 0],
        status: 'active',
        snoozedUntil: null,
        linkedProfileId: 'profile-1',
        linkedGiftSuggestion: true,
        notes: 'Buy flowers',
        completedAt: null,
        createdAt: now,
        updatedAt: now,
      );
      expect(reminder.description, 'Her birthday');
      expect(reminder.time, '09:00');
      expect(reminder.isRecurring, true);
      expect(reminder.recurrenceRule, 'yearly');
      expect(reminder.reminderTiers, [14, 7, 3, 1, 0]);
      expect(reminder.linkedProfileId, 'profile-1');
      expect(reminder.linkedGiftSuggestion, true);
      expect(reminder.notes, 'Buy flowers');
    });
  });

  group('daysUntil', () {
    test('returns positive days for future date', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 5)),
      );
      expect(reminder.daysUntil, 5);
    });

    test('returns 0 for today', () {
      final reminder = createReminder(date: today);
      expect(reminder.daysUntil, 0);
    });

    test('returns negative days for past date', () {
      final reminder = createReminder(
        date: today.subtract(const Duration(days: 3)),
      );
      expect(reminder.daysUntil, -3);
    });

    test('returns 1 for tomorrow', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 1)),
      );
      expect(reminder.daysUntil, 1);
    });
  });

  group('isOverdue', () {
    test('returns true for past date with active status', () {
      final reminder = createReminder(
        date: today.subtract(const Duration(days: 1)),
        status: 'active',
      );
      expect(reminder.isOverdue, true);
    });

    test('returns false for future date with active status', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 1)),
        status: 'active',
      );
      expect(reminder.isOverdue, false);
    });

    test('returns false for today with active status', () {
      final reminder = createReminder(
        date: today,
        status: 'active',
      );
      expect(reminder.isOverdue, false);
    });

    test('returns false for past date with completed status', () {
      final reminder = createReminder(
        date: today.subtract(const Duration(days: 1)),
        status: 'completed',
      );
      expect(reminder.isOverdue, false);
    });

    test('returns false for past date with snoozed status', () {
      final reminder = createReminder(
        date: today.subtract(const Duration(days: 1)),
        status: 'snoozed',
      );
      expect(reminder.isOverdue, false);
    });
  });

  group('isSnoozed', () {
    test('returns true when snoozed with future snoozedUntil', () {
      final reminder = createReminder(
        status: 'snoozed',
        snoozedUntil: now.add(const Duration(hours: 1)),
      );
      expect(reminder.isSnoozed, true);
    });

    test('returns false when snoozed with past snoozedUntil', () {
      final reminder = createReminder(
        status: 'snoozed',
        snoozedUntil: now.subtract(const Duration(hours: 1)),
      );
      expect(reminder.isSnoozed, false);
    });

    test('returns false when status is active', () {
      final reminder = createReminder(
        status: 'active',
        snoozedUntil: now.add(const Duration(hours: 1)),
      );
      expect(reminder.isSnoozed, false);
    });

    test('returns false when snoozedUntil is null', () {
      final reminder = createReminder(status: 'snoozed');
      expect(reminder.isSnoozed, false);
    });
  });

  group('isCompleted', () {
    test('returns true when status is completed', () {
      final reminder = createReminder(status: 'completed');
      expect(reminder.isCompleted, true);
    });

    test('returns false when status is active', () {
      final reminder = createReminder(status: 'active');
      expect(reminder.isCompleted, false);
    });

    test('returns false when status is snoozed', () {
      final reminder = createReminder(status: 'snoozed');
      expect(reminder.isCompleted, false);
    });
  });

  group('urgencyLevel', () {
    test('returns critical for overdue dates', () {
      final reminder = createReminder(
        date: today.subtract(const Duration(days: 1)),
      );
      expect(reminder.urgencyLevel, 'critical');
    });

    test('returns critical for today', () {
      final reminder = createReminder(date: today);
      expect(reminder.urgencyLevel, 'critical');
    });

    test('returns critical for tomorrow', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 1)),
      );
      expect(reminder.urgencyLevel, 'critical');
    });

    test('returns high for 2 days out', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 2)),
      );
      expect(reminder.urgencyLevel, 'high');
    });

    test('returns high for 3 days out', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 3)),
      );
      expect(reminder.urgencyLevel, 'high');
    });

    test('returns medium for 4 days out', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 4)),
      );
      expect(reminder.urgencyLevel, 'medium');
    });

    test('returns medium for 7 days out', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 7)),
      );
      expect(reminder.urgencyLevel, 'medium');
    });

    test('returns low for 8+ days out', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 8)),
      );
      expect(reminder.urgencyLevel, 'low');
    });

    test('returns low for 30 days out', () {
      final reminder = createReminder(
        date: today.add(const Duration(days: 30)),
      );
      expect(reminder.urgencyLevel, 'low');
    });
  });

  group('typeLabel', () {
    test('returns Birthday for birthday type', () {
      final reminder = createReminder(type: 'birthday');
      expect(reminder.typeLabel, 'Birthday');
    });

    test('returns Anniversary for anniversary type', () {
      final reminder = createReminder(type: 'anniversary');
      expect(reminder.typeLabel, 'Anniversary');
    });

    test('returns Islamic Holiday for islamic_holiday type', () {
      final reminder = createReminder(type: 'islamic_holiday');
      expect(reminder.typeLabel, 'Islamic Holiday');
    });

    test('returns Cultural for cultural type', () {
      final reminder = createReminder(type: 'cultural');
      expect(reminder.typeLabel, 'Cultural');
    });

    test('returns Custom for custom type', () {
      final reminder = createReminder(type: 'custom');
      expect(reminder.typeLabel, 'Custom');
    });

    test('returns Promise for promise type', () {
      final reminder = createReminder(type: 'promise');
      expect(reminder.typeLabel, 'Promise');
    });

    test('returns raw type string for unknown type', () {
      final reminder = createReminder(type: 'other');
      expect(reminder.typeLabel, 'other');
    });
  });

  group('copyWith', () {
    test('copies with updated title', () {
      final original = createReminder();
      final copy = original.copyWith(title: 'Updated Title');
      expect(copy.title, 'Updated Title');
      expect(copy.id, original.id); // other fields unchanged
    });

    test('copies with updated status', () {
      final original = createReminder(status: 'active');
      final copy = original.copyWith(status: 'completed');
      expect(copy.status, 'completed');
    });
  });

  group('equality', () {
    test('two reminders with same values are equal', () {
      final date = today.add(const Duration(days: 5));
      final r1 = ReminderEntity(
        id: 'r1',
        userId: 'u1',
        title: 'Test',
        type: 'custom',
        date: date,
        createdAt: now,
        updatedAt: now,
      );
      final r2 = ReminderEntity(
        id: 'r1',
        userId: 'u1',
        title: 'Test',
        type: 'custom',
        date: date,
        createdAt: now,
        updatedAt: now,
      );
      expect(r1, equals(r2));
    });

    test('two reminders with different ids are not equal', () {
      final date = today.add(const Duration(days: 5));
      final r1 = ReminderEntity(
        id: 'r1',
        userId: 'u1',
        title: 'Test',
        type: 'custom',
        date: date,
        createdAt: now,
        updatedAt: now,
      );
      final r2 = ReminderEntity(
        id: 'r2',
        userId: 'u1',
        title: 'Test',
        type: 'custom',
        date: date,
        createdAt: now,
        updatedAt: now,
      );
      expect(r1, isNot(equals(r2)));
    });
  });
}
