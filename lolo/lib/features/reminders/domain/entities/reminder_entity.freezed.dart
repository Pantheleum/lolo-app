// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReminderEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  bool get isRecurring => throw _privateConstructorUsedError;
  String get recurrenceRule => throw _privateConstructorUsedError;
  List<int> get reminderTiers => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get snoozedUntil => throw _privateConstructorUsedError;
  String? get linkedProfileId => throw _privateConstructorUsedError;
  bool get linkedGiftSuggestion => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderEntityCopyWith<ReminderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderEntityCopyWith<$Res> {
  factory $ReminderEntityCopyWith(
          ReminderEntity value, $Res Function(ReminderEntity) then) =
      _$ReminderEntityCopyWithImpl<$Res, ReminderEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      String type,
      DateTime date,
      String? time,
      bool isRecurring,
      String recurrenceRule,
      List<int> reminderTiers,
      String status,
      DateTime? snoozedUntil,
      String? linkedProfileId,
      bool linkedGiftSuggestion,
      String? notes,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$ReminderEntityCopyWithImpl<$Res, $Val extends ReminderEntity>
    implements $ReminderEntityCopyWith<$Res> {
  _$ReminderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? date = null,
    Object? time = freezed,
    Object? isRecurring = null,
    Object? recurrenceRule = null,
    Object? reminderTiers = null,
    Object? status = null,
    Object? snoozedUntil = freezed,
    Object? linkedProfileId = freezed,
    Object? linkedGiftSuggestion = null,
    Object? notes = freezed,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      recurrenceRule: null == recurrenceRule
          ? _value.recurrenceRule
          : recurrenceRule // ignore: cast_nullable_to_non_nullable
              as String,
      reminderTiers: null == reminderTiers
          ? _value.reminderTiers
          : reminderTiers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      snoozedUntil: freezed == snoozedUntil
          ? _value.snoozedUntil
          : snoozedUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      linkedProfileId: freezed == linkedProfileId
          ? _value.linkedProfileId
          : linkedProfileId // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedGiftSuggestion: null == linkedGiftSuggestion
          ? _value.linkedGiftSuggestion
          : linkedGiftSuggestion // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReminderEntityImplCopyWith<$Res>
    implements $ReminderEntityCopyWith<$Res> {
  factory _$$ReminderEntityImplCopyWith(_$ReminderEntityImpl value,
          $Res Function(_$ReminderEntityImpl) then) =
      __$$ReminderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      String type,
      DateTime date,
      String? time,
      bool isRecurring,
      String recurrenceRule,
      List<int> reminderTiers,
      String status,
      DateTime? snoozedUntil,
      String? linkedProfileId,
      bool linkedGiftSuggestion,
      String? notes,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$ReminderEntityImplCopyWithImpl<$Res>
    extends _$ReminderEntityCopyWithImpl<$Res, _$ReminderEntityImpl>
    implements _$$ReminderEntityImplCopyWith<$Res> {
  __$$ReminderEntityImplCopyWithImpl(
      _$ReminderEntityImpl _value, $Res Function(_$ReminderEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? date = null,
    Object? time = freezed,
    Object? isRecurring = null,
    Object? recurrenceRule = null,
    Object? reminderTiers = null,
    Object? status = null,
    Object? snoozedUntil = freezed,
    Object? linkedProfileId = freezed,
    Object? linkedGiftSuggestion = null,
    Object? notes = freezed,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ReminderEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      recurrenceRule: null == recurrenceRule
          ? _value.recurrenceRule
          : recurrenceRule // ignore: cast_nullable_to_non_nullable
              as String,
      reminderTiers: null == reminderTiers
          ? _value._reminderTiers
          : reminderTiers // ignore: cast_nullable_to_non_nullable
              as List<int>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      snoozedUntil: freezed == snoozedUntil
          ? _value.snoozedUntil
          : snoozedUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      linkedProfileId: freezed == linkedProfileId
          ? _value.linkedProfileId
          : linkedProfileId // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedGiftSuggestion: null == linkedGiftSuggestion
          ? _value.linkedGiftSuggestion
          : linkedGiftSuggestion // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$ReminderEntityImpl extends _ReminderEntity {
  const _$ReminderEntityImpl(
      {required this.id,
      required this.userId,
      required this.title,
      this.description,
      required this.type,
      required this.date,
      this.time,
      this.isRecurring = false,
      this.recurrenceRule = 'none',
      final List<int> reminderTiers = const [7, 3, 1, 0],
      this.status = 'active',
      this.snoozedUntil,
      this.linkedProfileId,
      this.linkedGiftSuggestion = false,
      this.notes,
      this.completedAt,
      required this.createdAt,
      required this.updatedAt})
      : _reminderTiers = reminderTiers,
        super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String type;
  @override
  final DateTime date;
  @override
  final String? time;
  @override
  @JsonKey()
  final bool isRecurring;
  @override
  @JsonKey()
  final String recurrenceRule;
  final List<int> _reminderTiers;
  @override
  @JsonKey()
  List<int> get reminderTiers {
    if (_reminderTiers is EqualUnmodifiableListView) return _reminderTiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reminderTiers);
  }

  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? snoozedUntil;
  @override
  final String? linkedProfileId;
  @override
  @JsonKey()
  final bool linkedGiftSuggestion;
  @override
  final String? notes;
  @override
  final DateTime? completedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ReminderEntity(id: $id, userId: $userId, title: $title, description: $description, type: $type, date: $date, time: $time, isRecurring: $isRecurring, recurrenceRule: $recurrenceRule, reminderTiers: $reminderTiers, status: $status, snoozedUntil: $snoozedUntil, linkedProfileId: $linkedProfileId, linkedGiftSuggestion: $linkedGiftSuggestion, notes: $notes, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                other.recurrenceRule == recurrenceRule) &&
            const DeepCollectionEquality()
                .equals(other._reminderTiers, _reminderTiers) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.snoozedUntil, snoozedUntil) ||
                other.snoozedUntil == snoozedUntil) &&
            (identical(other.linkedProfileId, linkedProfileId) ||
                other.linkedProfileId == linkedProfileId) &&
            (identical(other.linkedGiftSuggestion, linkedGiftSuggestion) ||
                other.linkedGiftSuggestion == linkedGiftSuggestion) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      description,
      type,
      date,
      time,
      isRecurring,
      recurrenceRule,
      const DeepCollectionEquality().hash(_reminderTiers),
      status,
      snoozedUntil,
      linkedProfileId,
      linkedGiftSuggestion,
      notes,
      completedAt,
      createdAt,
      updatedAt);

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderEntityImplCopyWith<_$ReminderEntityImpl> get copyWith =>
      __$$ReminderEntityImplCopyWithImpl<_$ReminderEntityImpl>(
          this, _$identity);
}

abstract class _ReminderEntity extends ReminderEntity {
  const factory _ReminderEntity(
      {required final String id,
      required final String userId,
      required final String title,
      final String? description,
      required final String type,
      required final DateTime date,
      final String? time,
      final bool isRecurring,
      final String recurrenceRule,
      final List<int> reminderTiers,
      final String status,
      final DateTime? snoozedUntil,
      final String? linkedProfileId,
      final bool linkedGiftSuggestion,
      final String? notes,
      final DateTime? completedAt,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ReminderEntityImpl;
  const _ReminderEntity._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String? get description;
  @override
  String get type;
  @override
  DateTime get date;
  @override
  String? get time;
  @override
  bool get isRecurring;
  @override
  String get recurrenceRule;
  @override
  List<int> get reminderTiers;
  @override
  String get status;
  @override
  DateTime? get snoozedUntil;
  @override
  String? get linkedProfileId;
  @override
  bool get linkedGiftSuggestion;
  @override
  String? get notes;
  @override
  DateTime? get completedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of ReminderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderEntityImplCopyWith<_$ReminderEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
