// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderModel _$ReminderModelFromJson(Map<String, dynamic> json) =>
    ReminderModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      date: json['date'] as String,
      time: json['time'] as String?,
      isRecurring: json['isRecurring'] as bool? ?? false,
      recurrenceRule: json['recurrenceRule'] as String? ?? 'none',
      reminderTiers: (json['reminderTiers'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [7, 3, 1, 0],
      status: json['status'] as String? ?? 'active',
      snoozedUntil: json['snoozedUntil'] as String?,
      linkedProfileId: json['linkedProfileId'] as String?,
      linkedGiftSuggestion: json['linkedGiftSuggestion'] as bool? ?? false,
      notes: json['notes'] as String?,
      completedAt: json['completedAt'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ReminderModelToJson(ReminderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'date': instance.date,
      'time': instance.time,
      'isRecurring': instance.isRecurring,
      'recurrenceRule': instance.recurrenceRule,
      'reminderTiers': instance.reminderTiers,
      'status': instance.status,
      'snoozedUntil': instance.snoozedUntil,
      'linkedProfileId': instance.linkedProfileId,
      'linkedGiftSuggestion': instance.linkedGiftSuggestion,
      'notes': instance.notes,
      'completedAt': instance.completedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
