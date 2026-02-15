// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StreakEntity {
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  bool get isActiveToday => throw _privateConstructorUsedError;
  int get freezesAvailable => throw _privateConstructorUsedError;
  int get freezesUsedThisMonth => throw _privateConstructorUsedError;
  List<StreakMilestone> get milestones => throw _privateConstructorUsedError;

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreakEntityCopyWith<StreakEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakEntityCopyWith<$Res> {
  factory $StreakEntityCopyWith(
          StreakEntity value, $Res Function(StreakEntity) then) =
      _$StreakEntityCopyWithImpl<$Res, StreakEntity>;
  @useResult
  $Res call(
      {int currentStreak,
      int longestStreak,
      bool isActiveToday,
      int freezesAvailable,
      int freezesUsedThisMonth,
      List<StreakMilestone> milestones});
}

/// @nodoc
class _$StreakEntityCopyWithImpl<$Res, $Val extends StreakEntity>
    implements $StreakEntityCopyWith<$Res> {
  _$StreakEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? isActiveToday = null,
    Object? freezesAvailable = null,
    Object? freezesUsedThisMonth = null,
    Object? milestones = null,
  }) {
    return _then(_value.copyWith(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      isActiveToday: null == isActiveToday
          ? _value.isActiveToday
          : isActiveToday // ignore: cast_nullable_to_non_nullable
              as bool,
      freezesAvailable: null == freezesAvailable
          ? _value.freezesAvailable
          : freezesAvailable // ignore: cast_nullable_to_non_nullable
              as int,
      freezesUsedThisMonth: null == freezesUsedThisMonth
          ? _value.freezesUsedThisMonth
          : freezesUsedThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _value.milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<StreakMilestone>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreakEntityImplCopyWith<$Res>
    implements $StreakEntityCopyWith<$Res> {
  factory _$$StreakEntityImplCopyWith(
          _$StreakEntityImpl value, $Res Function(_$StreakEntityImpl) then) =
      __$$StreakEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentStreak,
      int longestStreak,
      bool isActiveToday,
      int freezesAvailable,
      int freezesUsedThisMonth,
      List<StreakMilestone> milestones});
}

/// @nodoc
class __$$StreakEntityImplCopyWithImpl<$Res>
    extends _$StreakEntityCopyWithImpl<$Res, _$StreakEntityImpl>
    implements _$$StreakEntityImplCopyWith<$Res> {
  __$$StreakEntityImplCopyWithImpl(
      _$StreakEntityImpl _value, $Res Function(_$StreakEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? isActiveToday = null,
    Object? freezesAvailable = null,
    Object? freezesUsedThisMonth = null,
    Object? milestones = null,
  }) {
    return _then(_$StreakEntityImpl(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      isActiveToday: null == isActiveToday
          ? _value.isActiveToday
          : isActiveToday // ignore: cast_nullable_to_non_nullable
              as bool,
      freezesAvailable: null == freezesAvailable
          ? _value.freezesAvailable
          : freezesAvailable // ignore: cast_nullable_to_non_nullable
              as int,
      freezesUsedThisMonth: null == freezesUsedThisMonth
          ? _value.freezesUsedThisMonth
          : freezesUsedThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _value._milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<StreakMilestone>,
    ));
  }
}

/// @nodoc

class _$StreakEntityImpl implements _StreakEntity {
  const _$StreakEntityImpl(
      {required this.currentStreak,
      required this.longestStreak,
      required this.isActiveToday,
      required this.freezesAvailable,
      required this.freezesUsedThisMonth,
      required final List<StreakMilestone> milestones})
      : _milestones = milestones;

  @override
  final int currentStreak;
  @override
  final int longestStreak;
  @override
  final bool isActiveToday;
  @override
  final int freezesAvailable;
  @override
  final int freezesUsedThisMonth;
  final List<StreakMilestone> _milestones;
  @override
  List<StreakMilestone> get milestones {
    if (_milestones is EqualUnmodifiableListView) return _milestones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_milestones);
  }

  @override
  String toString() {
    return 'StreakEntity(currentStreak: $currentStreak, longestStreak: $longestStreak, isActiveToday: $isActiveToday, freezesAvailable: $freezesAvailable, freezesUsedThisMonth: $freezesUsedThisMonth, milestones: $milestones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakEntityImpl &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.isActiveToday, isActiveToday) ||
                other.isActiveToday == isActiveToday) &&
            (identical(other.freezesAvailable, freezesAvailable) ||
                other.freezesAvailable == freezesAvailable) &&
            (identical(other.freezesUsedThisMonth, freezesUsedThisMonth) ||
                other.freezesUsedThisMonth == freezesUsedThisMonth) &&
            const DeepCollectionEquality()
                .equals(other._milestones, _milestones));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStreak,
      longestStreak,
      isActiveToday,
      freezesAvailable,
      freezesUsedThisMonth,
      const DeepCollectionEquality().hash(_milestones));

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakEntityImplCopyWith<_$StreakEntityImpl> get copyWith =>
      __$$StreakEntityImplCopyWithImpl<_$StreakEntityImpl>(this, _$identity);
}

abstract class _StreakEntity implements StreakEntity {
  const factory _StreakEntity(
      {required final int currentStreak,
      required final int longestStreak,
      required final bool isActiveToday,
      required final int freezesAvailable,
      required final int freezesUsedThisMonth,
      required final List<StreakMilestone> milestones}) = _$StreakEntityImpl;

  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  bool get isActiveToday;
  @override
  int get freezesAvailable;
  @override
  int get freezesUsedThisMonth;
  @override
  List<StreakMilestone> get milestones;

  /// Create a copy of StreakEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreakEntityImplCopyWith<_$StreakEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StreakMilestone {
  int get days => throw _privateConstructorUsedError;
  bool get reached => throw _privateConstructorUsedError;
  DateTime? get reachedAt => throw _privateConstructorUsedError;

  /// Create a copy of StreakMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreakMilestoneCopyWith<StreakMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakMilestoneCopyWith<$Res> {
  factory $StreakMilestoneCopyWith(
          StreakMilestone value, $Res Function(StreakMilestone) then) =
      _$StreakMilestoneCopyWithImpl<$Res, StreakMilestone>;
  @useResult
  $Res call({int days, bool reached, DateTime? reachedAt});
}

/// @nodoc
class _$StreakMilestoneCopyWithImpl<$Res, $Val extends StreakMilestone>
    implements $StreakMilestoneCopyWith<$Res> {
  _$StreakMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreakMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? reached = null,
    Object? reachedAt = freezed,
  }) {
    return _then(_value.copyWith(
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as int,
      reached: null == reached
          ? _value.reached
          : reached // ignore: cast_nullable_to_non_nullable
              as bool,
      reachedAt: freezed == reachedAt
          ? _value.reachedAt
          : reachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreakMilestoneImplCopyWith<$Res>
    implements $StreakMilestoneCopyWith<$Res> {
  factory _$$StreakMilestoneImplCopyWith(_$StreakMilestoneImpl value,
          $Res Function(_$StreakMilestoneImpl) then) =
      __$$StreakMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int days, bool reached, DateTime? reachedAt});
}

/// @nodoc
class __$$StreakMilestoneImplCopyWithImpl<$Res>
    extends _$StreakMilestoneCopyWithImpl<$Res, _$StreakMilestoneImpl>
    implements _$$StreakMilestoneImplCopyWith<$Res> {
  __$$StreakMilestoneImplCopyWithImpl(
      _$StreakMilestoneImpl _value, $Res Function(_$StreakMilestoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreakMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? reached = null,
    Object? reachedAt = freezed,
  }) {
    return _then(_$StreakMilestoneImpl(
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as int,
      reached: null == reached
          ? _value.reached
          : reached // ignore: cast_nullable_to_non_nullable
              as bool,
      reachedAt: freezed == reachedAt
          ? _value.reachedAt
          : reachedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$StreakMilestoneImpl implements _StreakMilestone {
  const _$StreakMilestoneImpl(
      {required this.days, required this.reached, this.reachedAt});

  @override
  final int days;
  @override
  final bool reached;
  @override
  final DateTime? reachedAt;

  @override
  String toString() {
    return 'StreakMilestone(days: $days, reached: $reached, reachedAt: $reachedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakMilestoneImpl &&
            (identical(other.days, days) || other.days == days) &&
            (identical(other.reached, reached) || other.reached == reached) &&
            (identical(other.reachedAt, reachedAt) ||
                other.reachedAt == reachedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, days, reached, reachedAt);

  /// Create a copy of StreakMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakMilestoneImplCopyWith<_$StreakMilestoneImpl> get copyWith =>
      __$$StreakMilestoneImplCopyWithImpl<_$StreakMilestoneImpl>(
          this, _$identity);
}

abstract class _StreakMilestone implements StreakMilestone {
  const factory _StreakMilestone(
      {required final int days,
      required final bool reached,
      final DateTime? reachedAt}) = _$StreakMilestoneImpl;

  @override
  int get days;
  @override
  bool get reached;
  @override
  DateTime? get reachedAt;

  /// Create a copy of StreakMilestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreakMilestoneImplCopyWith<_$StreakMilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
