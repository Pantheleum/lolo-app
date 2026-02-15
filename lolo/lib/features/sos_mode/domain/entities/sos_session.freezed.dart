// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SosSession {
  String get sessionId => throw _privateConstructorUsedError;
  SosScenario get scenario => throw _privateConstructorUsedError;
  SosUrgency get urgency => throw _privateConstructorUsedError;
  SosImmediateAdvice get immediateAdvice => throw _privateConstructorUsedError;
  bool get severityAssessmentRequired => throw _privateConstructorUsedError;
  int get estimatedResolutionSteps => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;
  int? get userRating => throw _privateConstructorUsedError;
  String? get resolution => throw _privateConstructorUsedError;

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosSessionCopyWith<SosSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosSessionCopyWith<$Res> {
  factory $SosSessionCopyWith(
          SosSession value, $Res Function(SosSession) then) =
      _$SosSessionCopyWithImpl<$Res, SosSession>;
  @useResult
  $Res call(
      {String sessionId,
      SosScenario scenario,
      SosUrgency urgency,
      SosImmediateAdvice immediateAdvice,
      bool severityAssessmentRequired,
      int estimatedResolutionSteps,
      DateTime createdAt,
      bool isComplete,
      int? userRating,
      String? resolution});

  $SosImmediateAdviceCopyWith<$Res> get immediateAdvice;
}

/// @nodoc
class _$SosSessionCopyWithImpl<$Res, $Val extends SosSession>
    implements $SosSessionCopyWith<$Res> {
  _$SosSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? scenario = null,
    Object? urgency = null,
    Object? immediateAdvice = null,
    Object? severityAssessmentRequired = null,
    Object? estimatedResolutionSteps = null,
    Object? createdAt = null,
    Object? isComplete = null,
    Object? userRating = freezed,
    Object? resolution = freezed,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      scenario: null == scenario
          ? _value.scenario
          : scenario // ignore: cast_nullable_to_non_nullable
              as SosScenario,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as SosUrgency,
      immediateAdvice: null == immediateAdvice
          ? _value.immediateAdvice
          : immediateAdvice // ignore: cast_nullable_to_non_nullable
              as SosImmediateAdvice,
      severityAssessmentRequired: null == severityAssessmentRequired
          ? _value.severityAssessmentRequired
          : severityAssessmentRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      estimatedResolutionSteps: null == estimatedResolutionSteps
          ? _value.estimatedResolutionSteps
          : estimatedResolutionSteps // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      userRating: freezed == userRating
          ? _value.userRating
          : userRating // ignore: cast_nullable_to_non_nullable
              as int?,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosImmediateAdviceCopyWith<$Res> get immediateAdvice {
    return $SosImmediateAdviceCopyWith<$Res>(_value.immediateAdvice, (value) {
      return _then(_value.copyWith(immediateAdvice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SosSessionImplCopyWith<$Res>
    implements $SosSessionCopyWith<$Res> {
  factory _$$SosSessionImplCopyWith(
          _$SosSessionImpl value, $Res Function(_$SosSessionImpl) then) =
      __$$SosSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      SosScenario scenario,
      SosUrgency urgency,
      SosImmediateAdvice immediateAdvice,
      bool severityAssessmentRequired,
      int estimatedResolutionSteps,
      DateTime createdAt,
      bool isComplete,
      int? userRating,
      String? resolution});

  @override
  $SosImmediateAdviceCopyWith<$Res> get immediateAdvice;
}

/// @nodoc
class __$$SosSessionImplCopyWithImpl<$Res>
    extends _$SosSessionCopyWithImpl<$Res, _$SosSessionImpl>
    implements _$$SosSessionImplCopyWith<$Res> {
  __$$SosSessionImplCopyWithImpl(
      _$SosSessionImpl _value, $Res Function(_$SosSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? scenario = null,
    Object? urgency = null,
    Object? immediateAdvice = null,
    Object? severityAssessmentRequired = null,
    Object? estimatedResolutionSteps = null,
    Object? createdAt = null,
    Object? isComplete = null,
    Object? userRating = freezed,
    Object? resolution = freezed,
  }) {
    return _then(_$SosSessionImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      scenario: null == scenario
          ? _value.scenario
          : scenario // ignore: cast_nullable_to_non_nullable
              as SosScenario,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as SosUrgency,
      immediateAdvice: null == immediateAdvice
          ? _value.immediateAdvice
          : immediateAdvice // ignore: cast_nullable_to_non_nullable
              as SosImmediateAdvice,
      severityAssessmentRequired: null == severityAssessmentRequired
          ? _value.severityAssessmentRequired
          : severityAssessmentRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      estimatedResolutionSteps: null == estimatedResolutionSteps
          ? _value.estimatedResolutionSteps
          : estimatedResolutionSteps // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      userRating: freezed == userRating
          ? _value.userRating
          : userRating // ignore: cast_nullable_to_non_nullable
              as int?,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SosSessionImpl implements _SosSession {
  const _$SosSessionImpl(
      {required this.sessionId,
      required this.scenario,
      required this.urgency,
      required this.immediateAdvice,
      required this.severityAssessmentRequired,
      required this.estimatedResolutionSteps,
      required this.createdAt,
      this.isComplete = false,
      this.userRating,
      this.resolution});

  @override
  final String sessionId;
  @override
  final SosScenario scenario;
  @override
  final SosUrgency urgency;
  @override
  final SosImmediateAdvice immediateAdvice;
  @override
  final bool severityAssessmentRequired;
  @override
  final int estimatedResolutionSteps;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isComplete;
  @override
  final int? userRating;
  @override
  final String? resolution;

  @override
  String toString() {
    return 'SosSession(sessionId: $sessionId, scenario: $scenario, urgency: $urgency, immediateAdvice: $immediateAdvice, severityAssessmentRequired: $severityAssessmentRequired, estimatedResolutionSteps: $estimatedResolutionSteps, createdAt: $createdAt, isComplete: $isComplete, userRating: $userRating, resolution: $resolution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosSessionImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.scenario, scenario) ||
                other.scenario == scenario) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.immediateAdvice, immediateAdvice) ||
                other.immediateAdvice == immediateAdvice) &&
            (identical(other.severityAssessmentRequired,
                    severityAssessmentRequired) ||
                other.severityAssessmentRequired ==
                    severityAssessmentRequired) &&
            (identical(
                    other.estimatedResolutionSteps, estimatedResolutionSteps) ||
                other.estimatedResolutionSteps == estimatedResolutionSteps) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete) &&
            (identical(other.userRating, userRating) ||
                other.userRating == userRating) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionId,
      scenario,
      urgency,
      immediateAdvice,
      severityAssessmentRequired,
      estimatedResolutionSteps,
      createdAt,
      isComplete,
      userRating,
      resolution);

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosSessionImplCopyWith<_$SosSessionImpl> get copyWith =>
      __$$SosSessionImplCopyWithImpl<_$SosSessionImpl>(this, _$identity);
}

abstract class _SosSession implements SosSession {
  const factory _SosSession(
      {required final String sessionId,
      required final SosScenario scenario,
      required final SosUrgency urgency,
      required final SosImmediateAdvice immediateAdvice,
      required final bool severityAssessmentRequired,
      required final int estimatedResolutionSteps,
      required final DateTime createdAt,
      final bool isComplete,
      final int? userRating,
      final String? resolution}) = _$SosSessionImpl;

  @override
  String get sessionId;
  @override
  SosScenario get scenario;
  @override
  SosUrgency get urgency;
  @override
  SosImmediateAdvice get immediateAdvice;
  @override
  bool get severityAssessmentRequired;
  @override
  int get estimatedResolutionSteps;
  @override
  DateTime get createdAt;
  @override
  bool get isComplete;
  @override
  int? get userRating;
  @override
  String? get resolution;

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosSessionImplCopyWith<_$SosSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SosImmediateAdvice {
  String get doNow => throw _privateConstructorUsedError;
  String get doNotDo => throw _privateConstructorUsedError;
  String get bodyLanguage => throw _privateConstructorUsedError;

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosImmediateAdviceCopyWith<SosImmediateAdvice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosImmediateAdviceCopyWith<$Res> {
  factory $SosImmediateAdviceCopyWith(
          SosImmediateAdvice value, $Res Function(SosImmediateAdvice) then) =
      _$SosImmediateAdviceCopyWithImpl<$Res, SosImmediateAdvice>;
  @useResult
  $Res call({String doNow, String doNotDo, String bodyLanguage});
}

/// @nodoc
class _$SosImmediateAdviceCopyWithImpl<$Res, $Val extends SosImmediateAdvice>
    implements $SosImmediateAdviceCopyWith<$Res> {
  _$SosImmediateAdviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doNow = null,
    Object? doNotDo = null,
    Object? bodyLanguage = null,
  }) {
    return _then(_value.copyWith(
      doNow: null == doNow
          ? _value.doNow
          : doNow // ignore: cast_nullable_to_non_nullable
              as String,
      doNotDo: null == doNotDo
          ? _value.doNotDo
          : doNotDo // ignore: cast_nullable_to_non_nullable
              as String,
      bodyLanguage: null == bodyLanguage
          ? _value.bodyLanguage
          : bodyLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosImmediateAdviceImplCopyWith<$Res>
    implements $SosImmediateAdviceCopyWith<$Res> {
  factory _$$SosImmediateAdviceImplCopyWith(_$SosImmediateAdviceImpl value,
          $Res Function(_$SosImmediateAdviceImpl) then) =
      __$$SosImmediateAdviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String doNow, String doNotDo, String bodyLanguage});
}

/// @nodoc
class __$$SosImmediateAdviceImplCopyWithImpl<$Res>
    extends _$SosImmediateAdviceCopyWithImpl<$Res, _$SosImmediateAdviceImpl>
    implements _$$SosImmediateAdviceImplCopyWith<$Res> {
  __$$SosImmediateAdviceImplCopyWithImpl(_$SosImmediateAdviceImpl _value,
      $Res Function(_$SosImmediateAdviceImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doNow = null,
    Object? doNotDo = null,
    Object? bodyLanguage = null,
  }) {
    return _then(_$SosImmediateAdviceImpl(
      doNow: null == doNow
          ? _value.doNow
          : doNow // ignore: cast_nullable_to_non_nullable
              as String,
      doNotDo: null == doNotDo
          ? _value.doNotDo
          : doNotDo // ignore: cast_nullable_to_non_nullable
              as String,
      bodyLanguage: null == bodyLanguage
          ? _value.bodyLanguage
          : bodyLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SosImmediateAdviceImpl implements _SosImmediateAdvice {
  const _$SosImmediateAdviceImpl(
      {required this.doNow, required this.doNotDo, required this.bodyLanguage});

  @override
  final String doNow;
  @override
  final String doNotDo;
  @override
  final String bodyLanguage;

  @override
  String toString() {
    return 'SosImmediateAdvice(doNow: $doNow, doNotDo: $doNotDo, bodyLanguage: $bodyLanguage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosImmediateAdviceImpl &&
            (identical(other.doNow, doNow) || other.doNow == doNow) &&
            (identical(other.doNotDo, doNotDo) || other.doNotDo == doNotDo) &&
            (identical(other.bodyLanguage, bodyLanguage) ||
                other.bodyLanguage == bodyLanguage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, doNow, doNotDo, bodyLanguage);

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosImmediateAdviceImplCopyWith<_$SosImmediateAdviceImpl> get copyWith =>
      __$$SosImmediateAdviceImplCopyWithImpl<_$SosImmediateAdviceImpl>(
          this, _$identity);
}

abstract class _SosImmediateAdvice implements SosImmediateAdvice {
  const factory _SosImmediateAdvice(
      {required final String doNow,
      required final String doNotDo,
      required final String bodyLanguage}) = _$SosImmediateAdviceImpl;

  @override
  String get doNow;
  @override
  String get doNotDo;
  @override
  String get bodyLanguage;

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosImmediateAdviceImplCopyWith<_$SosImmediateAdviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
