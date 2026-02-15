import 'package:json_annotation/json_annotation.dart';
import 'package:lolo/features/reminders/domain/entities/reminder_entity.dart';

part 'reminder_model.g.dart';

/// DTO for reminders with JSON serialization and recurrence rule handling.
@JsonSerializable()
class ReminderModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String type;
  final String date;
  final String? time;
  final bool isRecurring;
  final String recurrenceRule;
  final List<int> reminderTiers;
  final String status;
  final String? snoozedUntil;
  final String? linkedProfileId;
  final bool linkedGiftSuggestion;
  final String? notes;
  final String? completedAt;
  final String createdAt;
  final String updatedAt;

  const ReminderModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.type,
    required this.date,
    this.time,
    this.isRecurring = false,
    this.recurrenceRule = 'none',
    this.reminderTiers = const [7, 3, 1, 0],
    this.status = 'active',
    this.snoozedUntil,
    this.linkedProfileId,
    this.linkedGiftSuggestion = false,
    this.notes,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) =>
      _$ReminderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderModelToJson(this);

  ReminderEntity toEntity() => ReminderEntity(
        id: id,
        userId: userId,
        title: title,
        description: description,
        type: type,
        date: DateTime.parse(date),
        time: time,
        isRecurring: isRecurring,
        recurrenceRule: recurrenceRule,
        reminderTiers: reminderTiers,
        status: status,
        snoozedUntil:
            snoozedUntil != null ? DateTime.tryParse(snoozedUntil!) : null,
        linkedProfileId: linkedProfileId,
        linkedGiftSuggestion: linkedGiftSuggestion,
        notes: notes,
        completedAt:
            completedAt != null ? DateTime.tryParse(completedAt!) : null,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
      );

  /// Create from domain entity for API submission.
  factory ReminderModel.fromEntity(ReminderEntity entity) => ReminderModel(
        id: entity.id,
        userId: entity.userId,
        title: entity.title,
        description: entity.description,
        type: entity.type,
        date: entity.date.toIso8601String(),
        time: entity.time,
        isRecurring: entity.isRecurring,
        recurrenceRule: entity.recurrenceRule,
        reminderTiers: entity.reminderTiers,
        status: entity.status,
        snoozedUntil: entity.snoozedUntil?.toIso8601String(),
        linkedProfileId: entity.linkedProfileId,
        linkedGiftSuggestion: entity.linkedGiftSuggestion,
        notes: entity.notes,
        completedAt: entity.completedAt?.toIso8601String(),
        createdAt: entity.createdAt.toIso8601String(),
        updatedAt: entity.updatedAt.toIso8601String(),
      );

  /// Payload for POST /reminders (create).
  Map<String, dynamic> toCreatePayload() => {
        'title': title,
        if (description != null) 'description': description,
        'type': type,
        'date': date,
        if (time != null) 'time': time,
        'isRecurring': isRecurring,
        'recurrenceRule': recurrenceRule,
        'reminderTiers': reminderTiers,
        if (linkedProfileId != null) 'linkedProfileId': linkedProfileId,
      };
}
