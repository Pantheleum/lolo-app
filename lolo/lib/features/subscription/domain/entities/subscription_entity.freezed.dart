// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SubscriptionEntity {
  SubscriptionTier get tier => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get currentPeriodEnd => throw _privateConstructorUsedError;
  DateTime? get trialEndsAt => throw _privateConstructorUsedError;
  bool get autoRenew => throw _privateConstructorUsedError;
  SubscriptionUsage get usage => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionEntityCopyWith<SubscriptionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionEntityCopyWith<$Res> {
  factory $SubscriptionEntityCopyWith(
          SubscriptionEntity value, $Res Function(SubscriptionEntity) then) =
      _$SubscriptionEntityCopyWithImpl<$Res, SubscriptionEntity>;
  @useResult
  $Res call(
      {SubscriptionTier tier,
      String status,
      DateTime? currentPeriodEnd,
      DateTime? trialEndsAt,
      bool autoRenew,
      SubscriptionUsage usage});

  $SubscriptionUsageCopyWith<$Res> get usage;
}

/// @nodoc
class _$SubscriptionEntityCopyWithImpl<$Res, $Val extends SubscriptionEntity>
    implements $SubscriptionEntityCopyWith<$Res> {
  _$SubscriptionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tier = null,
    Object? status = null,
    Object? currentPeriodEnd = freezed,
    Object? trialEndsAt = freezed,
    Object? autoRenew = null,
    Object? usage = null,
  }) {
    return _then(_value.copyWith(
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentPeriodEnd: freezed == currentPeriodEnd
          ? _value.currentPeriodEnd
          : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialEndsAt: freezed == trialEndsAt
          ? _value.trialEndsAt
          : trialEndsAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoRenew: null == autoRenew
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as SubscriptionUsage,
    ) as $Val);
  }

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionUsageCopyWith<$Res> get usage {
    return $SubscriptionUsageCopyWith<$Res>(_value.usage, (value) {
      return _then(_value.copyWith(usage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubscriptionEntityImplCopyWith<$Res>
    implements $SubscriptionEntityCopyWith<$Res> {
  factory _$$SubscriptionEntityImplCopyWith(_$SubscriptionEntityImpl value,
          $Res Function(_$SubscriptionEntityImpl) then) =
      __$$SubscriptionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SubscriptionTier tier,
      String status,
      DateTime? currentPeriodEnd,
      DateTime? trialEndsAt,
      bool autoRenew,
      SubscriptionUsage usage});

  @override
  $SubscriptionUsageCopyWith<$Res> get usage;
}

/// @nodoc
class __$$SubscriptionEntityImplCopyWithImpl<$Res>
    extends _$SubscriptionEntityCopyWithImpl<$Res, _$SubscriptionEntityImpl>
    implements _$$SubscriptionEntityImplCopyWith<$Res> {
  __$$SubscriptionEntityImplCopyWithImpl(_$SubscriptionEntityImpl _value,
      $Res Function(_$SubscriptionEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tier = null,
    Object? status = null,
    Object? currentPeriodEnd = freezed,
    Object? trialEndsAt = freezed,
    Object? autoRenew = null,
    Object? usage = null,
  }) {
    return _then(_$SubscriptionEntityImpl(
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      currentPeriodEnd: freezed == currentPeriodEnd
          ? _value.currentPeriodEnd
          : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialEndsAt: freezed == trialEndsAt
          ? _value.trialEndsAt
          : trialEndsAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      autoRenew: null == autoRenew
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as SubscriptionUsage,
    ));
  }
}

/// @nodoc

class _$SubscriptionEntityImpl extends _SubscriptionEntity {
  const _$SubscriptionEntityImpl(
      {required this.tier,
      required this.status,
      this.currentPeriodEnd,
      this.trialEndsAt,
      required this.autoRenew,
      required this.usage})
      : super._();

  @override
  final SubscriptionTier tier;
  @override
  final String status;
  @override
  final DateTime? currentPeriodEnd;
  @override
  final DateTime? trialEndsAt;
  @override
  final bool autoRenew;
  @override
  final SubscriptionUsage usage;

  @override
  String toString() {
    return 'SubscriptionEntity(tier: $tier, status: $status, currentPeriodEnd: $currentPeriodEnd, trialEndsAt: $trialEndsAt, autoRenew: $autoRenew, usage: $usage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionEntityImpl &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentPeriodEnd, currentPeriodEnd) ||
                other.currentPeriodEnd == currentPeriodEnd) &&
            (identical(other.trialEndsAt, trialEndsAt) ||
                other.trialEndsAt == trialEndsAt) &&
            (identical(other.autoRenew, autoRenew) ||
                other.autoRenew == autoRenew) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tier, status, currentPeriodEnd,
      trialEndsAt, autoRenew, usage);

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionEntityImplCopyWith<_$SubscriptionEntityImpl> get copyWith =>
      __$$SubscriptionEntityImplCopyWithImpl<_$SubscriptionEntityImpl>(
          this, _$identity);
}

abstract class _SubscriptionEntity extends SubscriptionEntity {
  const factory _SubscriptionEntity(
      {required final SubscriptionTier tier,
      required final String status,
      final DateTime? currentPeriodEnd,
      final DateTime? trialEndsAt,
      required final bool autoRenew,
      required final SubscriptionUsage usage}) = _$SubscriptionEntityImpl;
  const _SubscriptionEntity._() : super._();

  @override
  SubscriptionTier get tier;
  @override
  String get status;
  @override
  DateTime? get currentPeriodEnd;
  @override
  DateTime? get trialEndsAt;
  @override
  bool get autoRenew;
  @override
  SubscriptionUsage get usage;

  /// Create a copy of SubscriptionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionEntityImplCopyWith<_$SubscriptionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SubscriptionUsage {
  ({int limit, int used}) get aiMessages => throw _privateConstructorUsedError;
  ({int limit, int used}) get sosSessions => throw _privateConstructorUsedError;
  ({int limit, int used}) get actionCardsPerDay =>
      throw _privateConstructorUsedError;
  ({int limit, int used}) get memories => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionUsageCopyWith<SubscriptionUsage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionUsageCopyWith<$Res> {
  factory $SubscriptionUsageCopyWith(
          SubscriptionUsage value, $Res Function(SubscriptionUsage) then) =
      _$SubscriptionUsageCopyWithImpl<$Res, SubscriptionUsage>;
  @useResult
  $Res call(
      {({int limit, int used}) aiMessages,
      ({int limit, int used}) sosSessions,
      ({int limit, int used}) actionCardsPerDay,
      ({int limit, int used}) memories});
}

/// @nodoc
class _$SubscriptionUsageCopyWithImpl<$Res, $Val extends SubscriptionUsage>
    implements $SubscriptionUsageCopyWith<$Res> {
  _$SubscriptionUsageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aiMessages = null,
    Object? sosSessions = null,
    Object? actionCardsPerDay = null,
    Object? memories = null,
  }) {
    return _then(_value.copyWith(
      aiMessages: null == aiMessages
          ? _value.aiMessages
          : aiMessages // ignore: cast_nullable_to_non_nullable
              as ({int limit, int used}),
      sosSessions: null == sosSessions
          ? _value.sosSessions
          : sosSessions // ignore: cast_nullable_to_non_nullable
              as ({int limit, int used}),
      actionCardsPerDay: null == actionCardsPerDay
          ? _value.actionCardsPerDay
          : actionCardsPerDay // ignore: cast_nullable_to_non_nullable
              as ({int limit, int used}),
      memories: null == memories
          ? _value.memories
          : memories // ignore: cast_nullable_to_non_nullable
              as ({int limit, int used}),
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionUsageImplCopyWith<$Res>
    implements $SubscriptionUsageCopyWith<$Res> {
  factory _$$SubscriptionUsageImplCopyWith(_$SubscriptionUsageImpl value,
          $Res Function(_$SubscriptionUsageImpl) then) =
      __$$SubscriptionUsageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {({int limit, int used}) aiMessages,
      ({int limit, int used}) sosSessions,
      ({int limit, int used}) actionCardsPerDay,
      ({int limit, int used}) memories});
}

/// @nodoc
class __$$SubscriptionUsageImplCopyWithImpl<$Res>
    extends _$SubscriptionUsageCopyWithImpl<$Res, _$SubscriptionUsageImpl>
    implements _$$SubscriptionUsageImplCopyWith<$Res> {
  __$$SubscriptionUsageImplCopyWithImpl(_$SubscriptionUsageImpl _value,
      $Res Function(_$SubscriptionUsageImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aiMessages = null,
    Object? sosSessions = null,
    Object? actionCardsPerDay = null,
    Object? memories = null,
  }) {
    return _then(_$SubscriptionUsageImpl(
      aiMessages: null == aiMessages
          ? _value.aiMessages
          : aiMessages // ignore: cast_nullable_to_non_nullable
              as ({int limit, int used}),
      sosSessions: null == sosSessions
          ? _value.sosSessions
          : sosSessions // ignore: cast_nullable_to_non_nullable
              as ({int limit, int used}),
      actionCardsPerDay: null == actionCardsPerDay
          ? _value.actionCardsPerDay
          : actionCardsPerDay // ignore: cast_nullable_to_non_nullable
              as ({int limit, int used}),
      memories: null == memories
          ? _value.memories
          : memories // ignore: cast_nullable_to_non_nullable
              as ({int limit, int used}),
    ));
  }
}

/// @nodoc

class _$SubscriptionUsageImpl implements _SubscriptionUsage {
  const _$SubscriptionUsageImpl(
      {required this.aiMessages,
      required this.sosSessions,
      required this.actionCardsPerDay,
      required this.memories});

  @override
  final ({int limit, int used}) aiMessages;
  @override
  final ({int limit, int used}) sosSessions;
  @override
  final ({int limit, int used}) actionCardsPerDay;
  @override
  final ({int limit, int used}) memories;

  @override
  String toString() {
    return 'SubscriptionUsage(aiMessages: $aiMessages, sosSessions: $sosSessions, actionCardsPerDay: $actionCardsPerDay, memories: $memories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionUsageImpl &&
            (identical(other.aiMessages, aiMessages) ||
                other.aiMessages == aiMessages) &&
            (identical(other.sosSessions, sosSessions) ||
                other.sosSessions == sosSessions) &&
            (identical(other.actionCardsPerDay, actionCardsPerDay) ||
                other.actionCardsPerDay == actionCardsPerDay) &&
            (identical(other.memories, memories) ||
                other.memories == memories));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, aiMessages, sosSessions, actionCardsPerDay, memories);

  /// Create a copy of SubscriptionUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionUsageImplCopyWith<_$SubscriptionUsageImpl> get copyWith =>
      __$$SubscriptionUsageImplCopyWithImpl<_$SubscriptionUsageImpl>(
          this, _$identity);
}

abstract class _SubscriptionUsage implements SubscriptionUsage {
  const factory _SubscriptionUsage(
          {required final ({int limit, int used}) aiMessages,
          required final ({int limit, int used}) sosSessions,
          required final ({int limit, int used}) actionCardsPerDay,
          required final ({int limit, int used}) memories}) =
      _$SubscriptionUsageImpl;

  @override
  ({int limit, int used}) get aiMessages;
  @override
  ({int limit, int used}) get sosSessions;
  @override
  ({int limit, int used}) get actionCardsPerDay;
  @override
  ({int limit, int used}) get memories;

  /// Create a copy of SubscriptionUsage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionUsageImplCopyWith<_$SubscriptionUsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
