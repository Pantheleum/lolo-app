// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_assessment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SosAssessment {
  String get sessionId => throw _privateConstructorUsedError;
  int get severityScore => throw _privateConstructorUsedError;
  String get severityLabel => throw _privateConstructorUsedError;
  SosCoachingPlan get coachingPlan => throw _privateConstructorUsedError;

  /// Create a copy of SosAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosAssessmentCopyWith<SosAssessment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosAssessmentCopyWith<$Res> {
  factory $SosAssessmentCopyWith(
          SosAssessment value, $Res Function(SosAssessment) then) =
      _$SosAssessmentCopyWithImpl<$Res, SosAssessment>;
  @useResult
  $Res call(
      {String sessionId,
      int severityScore,
      String severityLabel,
      SosCoachingPlan coachingPlan});

  $SosCoachingPlanCopyWith<$Res> get coachingPlan;
}

/// @nodoc
class _$SosAssessmentCopyWithImpl<$Res, $Val extends SosAssessment>
    implements $SosAssessmentCopyWith<$Res> {
  _$SosAssessmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? severityScore = null,
    Object? severityLabel = null,
    Object? coachingPlan = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      severityScore: null == severityScore
          ? _value.severityScore
          : severityScore // ignore: cast_nullable_to_non_nullable
              as int,
      severityLabel: null == severityLabel
          ? _value.severityLabel
          : severityLabel // ignore: cast_nullable_to_non_nullable
              as String,
      coachingPlan: null == coachingPlan
          ? _value.coachingPlan
          : coachingPlan // ignore: cast_nullable_to_non_nullable
              as SosCoachingPlan,
    ) as $Val);
  }

  /// Create a copy of SosAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosCoachingPlanCopyWith<$Res> get coachingPlan {
    return $SosCoachingPlanCopyWith<$Res>(_value.coachingPlan, (value) {
      return _then(_value.copyWith(coachingPlan: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SosAssessmentImplCopyWith<$Res>
    implements $SosAssessmentCopyWith<$Res> {
  factory _$$SosAssessmentImplCopyWith(
          _$SosAssessmentImpl value, $Res Function(_$SosAssessmentImpl) then) =
      __$$SosAssessmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      int severityScore,
      String severityLabel,
      SosCoachingPlan coachingPlan});

  @override
  $SosCoachingPlanCopyWith<$Res> get coachingPlan;
}

/// @nodoc
class __$$SosAssessmentImplCopyWithImpl<$Res>
    extends _$SosAssessmentCopyWithImpl<$Res, _$SosAssessmentImpl>
    implements _$$SosAssessmentImplCopyWith<$Res> {
  __$$SosAssessmentImplCopyWithImpl(
      _$SosAssessmentImpl _value, $Res Function(_$SosAssessmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosAssessment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? severityScore = null,
    Object? severityLabel = null,
    Object? coachingPlan = null,
  }) {
    return _then(_$SosAssessmentImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      severityScore: null == severityScore
          ? _value.severityScore
          : severityScore // ignore: cast_nullable_to_non_nullable
              as int,
      severityLabel: null == severityLabel
          ? _value.severityLabel
          : severityLabel // ignore: cast_nullable_to_non_nullable
              as String,
      coachingPlan: null == coachingPlan
          ? _value.coachingPlan
          : coachingPlan // ignore: cast_nullable_to_non_nullable
              as SosCoachingPlan,
    ));
  }
}

/// @nodoc

class _$SosAssessmentImpl implements _SosAssessment {
  const _$SosAssessmentImpl(
      {required this.sessionId,
      required this.severityScore,
      required this.severityLabel,
      required this.coachingPlan});

  @override
  final String sessionId;
  @override
  final int severityScore;
  @override
  final String severityLabel;
  @override
  final SosCoachingPlan coachingPlan;

  @override
  String toString() {
    return 'SosAssessment(sessionId: $sessionId, severityScore: $severityScore, severityLabel: $severityLabel, coachingPlan: $coachingPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosAssessmentImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.severityScore, severityScore) ||
                other.severityScore == severityScore) &&
            (identical(other.severityLabel, severityLabel) ||
                other.severityLabel == severityLabel) &&
            (identical(other.coachingPlan, coachingPlan) ||
                other.coachingPlan == coachingPlan));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, sessionId, severityScore, severityLabel, coachingPlan);

  /// Create a copy of SosAssessment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosAssessmentImplCopyWith<_$SosAssessmentImpl> get copyWith =>
      __$$SosAssessmentImplCopyWithImpl<_$SosAssessmentImpl>(this, _$identity);
}

abstract class _SosAssessment implements SosAssessment {
  const factory _SosAssessment(
      {required final String sessionId,
      required final int severityScore,
      required final String severityLabel,
      required final SosCoachingPlan coachingPlan}) = _$SosAssessmentImpl;

  @override
  String get sessionId;
  @override
  int get severityScore;
  @override
  String get severityLabel;
  @override
  SosCoachingPlan get coachingPlan;

  /// Create a copy of SosAssessment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosAssessmentImplCopyWith<_$SosAssessmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SosCoachingPlan {
  int get totalSteps => throw _privateConstructorUsedError;
  int get estimatedMinutes => throw _privateConstructorUsedError;
  String get approach => throw _privateConstructorUsedError;
  String get keyInsight => throw _privateConstructorUsedError;

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosCoachingPlanCopyWith<SosCoachingPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosCoachingPlanCopyWith<$Res> {
  factory $SosCoachingPlanCopyWith(
          SosCoachingPlan value, $Res Function(SosCoachingPlan) then) =
      _$SosCoachingPlanCopyWithImpl<$Res, SosCoachingPlan>;
  @useResult
  $Res call(
      {int totalSteps,
      int estimatedMinutes,
      String approach,
      String keyInsight});
}

/// @nodoc
class _$SosCoachingPlanCopyWithImpl<$Res, $Val extends SosCoachingPlan>
    implements $SosCoachingPlanCopyWith<$Res> {
  _$SosCoachingPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSteps = null,
    Object? estimatedMinutes = null,
    Object? approach = null,
    Object? keyInsight = null,
  }) {
    return _then(_value.copyWith(
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedMinutes: null == estimatedMinutes
          ? _value.estimatedMinutes
          : estimatedMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      approach: null == approach
          ? _value.approach
          : approach // ignore: cast_nullable_to_non_nullable
              as String,
      keyInsight: null == keyInsight
          ? _value.keyInsight
          : keyInsight // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosCoachingPlanImplCopyWith<$Res>
    implements $SosCoachingPlanCopyWith<$Res> {
  factory _$$SosCoachingPlanImplCopyWith(_$SosCoachingPlanImpl value,
          $Res Function(_$SosCoachingPlanImpl) then) =
      __$$SosCoachingPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalSteps,
      int estimatedMinutes,
      String approach,
      String keyInsight});
}

/// @nodoc
class __$$SosCoachingPlanImplCopyWithImpl<$Res>
    extends _$SosCoachingPlanCopyWithImpl<$Res, _$SosCoachingPlanImpl>
    implements _$$SosCoachingPlanImplCopyWith<$Res> {
  __$$SosCoachingPlanImplCopyWithImpl(
      _$SosCoachingPlanImpl _value, $Res Function(_$SosCoachingPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSteps = null,
    Object? estimatedMinutes = null,
    Object? approach = null,
    Object? keyInsight = null,
  }) {
    return _then(_$SosCoachingPlanImpl(
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedMinutes: null == estimatedMinutes
          ? _value.estimatedMinutes
          : estimatedMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      approach: null == approach
          ? _value.approach
          : approach // ignore: cast_nullable_to_non_nullable
              as String,
      keyInsight: null == keyInsight
          ? _value.keyInsight
          : keyInsight // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SosCoachingPlanImpl implements _SosCoachingPlan {
  const _$SosCoachingPlanImpl(
      {required this.totalSteps,
      required this.estimatedMinutes,
      required this.approach,
      required this.keyInsight});

  @override
  final int totalSteps;
  @override
  final int estimatedMinutes;
  @override
  final String approach;
  @override
  final String keyInsight;

  @override
  String toString() {
    return 'SosCoachingPlan(totalSteps: $totalSteps, estimatedMinutes: $estimatedMinutes, approach: $approach, keyInsight: $keyInsight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosCoachingPlanImpl &&
            (identical(other.totalSteps, totalSteps) ||
                other.totalSteps == totalSteps) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes) &&
            (identical(other.approach, approach) ||
                other.approach == approach) &&
            (identical(other.keyInsight, keyInsight) ||
                other.keyInsight == keyInsight));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, totalSteps, estimatedMinutes, approach, keyInsight);

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosCoachingPlanImplCopyWith<_$SosCoachingPlanImpl> get copyWith =>
      __$$SosCoachingPlanImplCopyWithImpl<_$SosCoachingPlanImpl>(
          this, _$identity);
}

abstract class _SosCoachingPlan implements SosCoachingPlan {
  const factory _SosCoachingPlan(
      {required final int totalSteps,
      required final int estimatedMinutes,
      required final String approach,
      required final String keyInsight}) = _$SosCoachingPlanImpl;

  @override
  int get totalSteps;
  @override
  int get estimatedMinutes;
  @override
  String get approach;
  @override
  String get keyInsight;

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosCoachingPlanImplCopyWith<_$SosCoachingPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
