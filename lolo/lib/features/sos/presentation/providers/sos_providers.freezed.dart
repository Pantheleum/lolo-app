// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SosFlowState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() activating,
    required TResult Function(SosSession session) activated,
    required TResult Function(SosSession session, SosAssessment assessment)
        assessed,
    required TResult Function(SosSession session, CoachingStep step) coaching,
    required TResult Function() resolved,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? activating,
    TResult? Function(SosSession session)? activated,
    TResult? Function(SosSession session, SosAssessment assessment)? assessed,
    TResult? Function(SosSession session, CoachingStep step)? coaching,
    TResult? Function()? resolved,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? activating,
    TResult Function(SosSession session)? activated,
    TResult Function(SosSession session, SosAssessment assessment)? assessed,
    TResult Function(SosSession session, CoachingStep step)? coaching,
    TResult Function()? resolved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Activating value) activating,
    required TResult Function(_Activated value) activated,
    required TResult Function(_Assessed value) assessed,
    required TResult Function(_Coaching value) coaching,
    required TResult Function(_Resolved value) resolved,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Activating value)? activating,
    TResult? Function(_Activated value)? activated,
    TResult? Function(_Assessed value)? assessed,
    TResult? Function(_Coaching value)? coaching,
    TResult? Function(_Resolved value)? resolved,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Activating value)? activating,
    TResult Function(_Activated value)? activated,
    TResult Function(_Assessed value)? assessed,
    TResult Function(_Coaching value)? coaching,
    TResult Function(_Resolved value)? resolved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosFlowStateCopyWith<$Res> {
  factory $SosFlowStateCopyWith(
          SosFlowState value, $Res Function(SosFlowState) then) =
      _$SosFlowStateCopyWithImpl<$Res, SosFlowState>;
}

/// @nodoc
class _$SosFlowStateCopyWithImpl<$Res, $Val extends SosFlowState>
    implements $SosFlowStateCopyWith<$Res> {
  _$SosFlowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl value, $Res Function(_$IdleImpl) then) =
      __$$IdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$SosFlowStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleImpl implements _Idle {
  const _$IdleImpl();

  @override
  String toString() {
    return 'SosFlowState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() activating,
    required TResult Function(SosSession session) activated,
    required TResult Function(SosSession session, SosAssessment assessment)
        assessed,
    required TResult Function(SosSession session, CoachingStep step) coaching,
    required TResult Function() resolved,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? activating,
    TResult? Function(SosSession session)? activated,
    TResult? Function(SosSession session, SosAssessment assessment)? assessed,
    TResult? Function(SosSession session, CoachingStep step)? coaching,
    TResult? Function()? resolved,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? activating,
    TResult Function(SosSession session)? activated,
    TResult Function(SosSession session, SosAssessment assessment)? assessed,
    TResult Function(SosSession session, CoachingStep step)? coaching,
    TResult Function()? resolved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Activating value) activating,
    required TResult Function(_Activated value) activated,
    required TResult Function(_Assessed value) assessed,
    required TResult Function(_Coaching value) coaching,
    required TResult Function(_Resolved value) resolved,
    required TResult Function(_Error value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Activating value)? activating,
    TResult? Function(_Activated value)? activated,
    TResult? Function(_Assessed value)? assessed,
    TResult? Function(_Coaching value)? coaching,
    TResult? Function(_Resolved value)? resolved,
    TResult? Function(_Error value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Activating value)? activating,
    TResult Function(_Activated value)? activated,
    TResult Function(_Assessed value)? assessed,
    TResult Function(_Coaching value)? coaching,
    TResult Function(_Resolved value)? resolved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements SosFlowState {
  const factory _Idle() = _$IdleImpl;
}

/// @nodoc
abstract class _$$ActivatingImplCopyWith<$Res> {
  factory _$$ActivatingImplCopyWith(
          _$ActivatingImpl value, $Res Function(_$ActivatingImpl) then) =
      __$$ActivatingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActivatingImplCopyWithImpl<$Res>
    extends _$SosFlowStateCopyWithImpl<$Res, _$ActivatingImpl>
    implements _$$ActivatingImplCopyWith<$Res> {
  __$$ActivatingImplCopyWithImpl(
      _$ActivatingImpl _value, $Res Function(_$ActivatingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ActivatingImpl implements _Activating {
  const _$ActivatingImpl();

  @override
  String toString() {
    return 'SosFlowState.activating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ActivatingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() activating,
    required TResult Function(SosSession session) activated,
    required TResult Function(SosSession session, SosAssessment assessment)
        assessed,
    required TResult Function(SosSession session, CoachingStep step) coaching,
    required TResult Function() resolved,
    required TResult Function(String message) error,
  }) {
    return activating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? activating,
    TResult? Function(SosSession session)? activated,
    TResult? Function(SosSession session, SosAssessment assessment)? assessed,
    TResult? Function(SosSession session, CoachingStep step)? coaching,
    TResult? Function()? resolved,
    TResult? Function(String message)? error,
  }) {
    return activating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? activating,
    TResult Function(SosSession session)? activated,
    TResult Function(SosSession session, SosAssessment assessment)? assessed,
    TResult Function(SosSession session, CoachingStep step)? coaching,
    TResult Function()? resolved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (activating != null) {
      return activating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Activating value) activating,
    required TResult Function(_Activated value) activated,
    required TResult Function(_Assessed value) assessed,
    required TResult Function(_Coaching value) coaching,
    required TResult Function(_Resolved value) resolved,
    required TResult Function(_Error value) error,
  }) {
    return activating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Activating value)? activating,
    TResult? Function(_Activated value)? activated,
    TResult? Function(_Assessed value)? assessed,
    TResult? Function(_Coaching value)? coaching,
    TResult? Function(_Resolved value)? resolved,
    TResult? Function(_Error value)? error,
  }) {
    return activating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Activating value)? activating,
    TResult Function(_Activated value)? activated,
    TResult Function(_Assessed value)? assessed,
    TResult Function(_Coaching value)? coaching,
    TResult Function(_Resolved value)? resolved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (activating != null) {
      return activating(this);
    }
    return orElse();
  }
}

abstract class _Activating implements SosFlowState {
  const factory _Activating() = _$ActivatingImpl;
}

/// @nodoc
abstract class _$$ActivatedImplCopyWith<$Res> {
  factory _$$ActivatedImplCopyWith(
          _$ActivatedImpl value, $Res Function(_$ActivatedImpl) then) =
      __$$ActivatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SosSession session});

  $SosSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$ActivatedImplCopyWithImpl<$Res>
    extends _$SosFlowStateCopyWithImpl<$Res, _$ActivatedImpl>
    implements _$$ActivatedImplCopyWith<$Res> {
  __$$ActivatedImplCopyWithImpl(
      _$ActivatedImpl _value, $Res Function(_$ActivatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
  }) {
    return _then(_$ActivatedImpl(
      null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as SosSession,
    ));
  }

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosSessionCopyWith<$Res> get session {
    return $SosSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$ActivatedImpl implements _Activated {
  const _$ActivatedImpl(this.session);

  @override
  final SosSession session;

  @override
  String toString() {
    return 'SosFlowState.activated(session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivatedImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivatedImplCopyWith<_$ActivatedImpl> get copyWith =>
      __$$ActivatedImplCopyWithImpl<_$ActivatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() activating,
    required TResult Function(SosSession session) activated,
    required TResult Function(SosSession session, SosAssessment assessment)
        assessed,
    required TResult Function(SosSession session, CoachingStep step) coaching,
    required TResult Function() resolved,
    required TResult Function(String message) error,
  }) {
    return activated(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? activating,
    TResult? Function(SosSession session)? activated,
    TResult? Function(SosSession session, SosAssessment assessment)? assessed,
    TResult? Function(SosSession session, CoachingStep step)? coaching,
    TResult? Function()? resolved,
    TResult? Function(String message)? error,
  }) {
    return activated?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? activating,
    TResult Function(SosSession session)? activated,
    TResult Function(SosSession session, SosAssessment assessment)? assessed,
    TResult Function(SosSession session, CoachingStep step)? coaching,
    TResult Function()? resolved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (activated != null) {
      return activated(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Activating value) activating,
    required TResult Function(_Activated value) activated,
    required TResult Function(_Assessed value) assessed,
    required TResult Function(_Coaching value) coaching,
    required TResult Function(_Resolved value) resolved,
    required TResult Function(_Error value) error,
  }) {
    return activated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Activating value)? activating,
    TResult? Function(_Activated value)? activated,
    TResult? Function(_Assessed value)? assessed,
    TResult? Function(_Coaching value)? coaching,
    TResult? Function(_Resolved value)? resolved,
    TResult? Function(_Error value)? error,
  }) {
    return activated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Activating value)? activating,
    TResult Function(_Activated value)? activated,
    TResult Function(_Assessed value)? assessed,
    TResult Function(_Coaching value)? coaching,
    TResult Function(_Resolved value)? resolved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (activated != null) {
      return activated(this);
    }
    return orElse();
  }
}

abstract class _Activated implements SosFlowState {
  const factory _Activated(final SosSession session) = _$ActivatedImpl;

  SosSession get session;

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivatedImplCopyWith<_$ActivatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssessedImplCopyWith<$Res> {
  factory _$$AssessedImplCopyWith(
          _$AssessedImpl value, $Res Function(_$AssessedImpl) then) =
      __$$AssessedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SosSession session, SosAssessment assessment});

  $SosSessionCopyWith<$Res> get session;
  $SosAssessmentCopyWith<$Res> get assessment;
}

/// @nodoc
class __$$AssessedImplCopyWithImpl<$Res>
    extends _$SosFlowStateCopyWithImpl<$Res, _$AssessedImpl>
    implements _$$AssessedImplCopyWith<$Res> {
  __$$AssessedImplCopyWithImpl(
      _$AssessedImpl _value, $Res Function(_$AssessedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? assessment = null,
  }) {
    return _then(_$AssessedImpl(
      null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as SosSession,
      null == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as SosAssessment,
    ));
  }

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosSessionCopyWith<$Res> get session {
    return $SosSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosAssessmentCopyWith<$Res> get assessment {
    return $SosAssessmentCopyWith<$Res>(_value.assessment, (value) {
      return _then(_value.copyWith(assessment: value));
    });
  }
}

/// @nodoc

class _$AssessedImpl implements _Assessed {
  const _$AssessedImpl(this.session, this.assessment);

  @override
  final SosSession session;
  @override
  final SosAssessment assessment;

  @override
  String toString() {
    return 'SosFlowState.assessed(session: $session, assessment: $assessment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessedImpl &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.assessment, assessment) ||
                other.assessment == assessment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session, assessment);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessedImplCopyWith<_$AssessedImpl> get copyWith =>
      __$$AssessedImplCopyWithImpl<_$AssessedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() activating,
    required TResult Function(SosSession session) activated,
    required TResult Function(SosSession session, SosAssessment assessment)
        assessed,
    required TResult Function(SosSession session, CoachingStep step) coaching,
    required TResult Function() resolved,
    required TResult Function(String message) error,
  }) {
    return assessed(session, assessment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? activating,
    TResult? Function(SosSession session)? activated,
    TResult? Function(SosSession session, SosAssessment assessment)? assessed,
    TResult? Function(SosSession session, CoachingStep step)? coaching,
    TResult? Function()? resolved,
    TResult? Function(String message)? error,
  }) {
    return assessed?.call(session, assessment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? activating,
    TResult Function(SosSession session)? activated,
    TResult Function(SosSession session, SosAssessment assessment)? assessed,
    TResult Function(SosSession session, CoachingStep step)? coaching,
    TResult Function()? resolved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (assessed != null) {
      return assessed(session, assessment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Activating value) activating,
    required TResult Function(_Activated value) activated,
    required TResult Function(_Assessed value) assessed,
    required TResult Function(_Coaching value) coaching,
    required TResult Function(_Resolved value) resolved,
    required TResult Function(_Error value) error,
  }) {
    return assessed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Activating value)? activating,
    TResult? Function(_Activated value)? activated,
    TResult? Function(_Assessed value)? assessed,
    TResult? Function(_Coaching value)? coaching,
    TResult? Function(_Resolved value)? resolved,
    TResult? Function(_Error value)? error,
  }) {
    return assessed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Activating value)? activating,
    TResult Function(_Activated value)? activated,
    TResult Function(_Assessed value)? assessed,
    TResult Function(_Coaching value)? coaching,
    TResult Function(_Resolved value)? resolved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (assessed != null) {
      return assessed(this);
    }
    return orElse();
  }
}

abstract class _Assessed implements SosFlowState {
  const factory _Assessed(
          final SosSession session, final SosAssessment assessment) =
      _$AssessedImpl;

  SosSession get session;
  SosAssessment get assessment;

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessedImplCopyWith<_$AssessedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CoachingImplCopyWith<$Res> {
  factory _$$CoachingImplCopyWith(
          _$CoachingImpl value, $Res Function(_$CoachingImpl) then) =
      __$$CoachingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SosSession session, CoachingStep step});

  $SosSessionCopyWith<$Res> get session;
  $CoachingStepCopyWith<$Res> get step;
}

/// @nodoc
class __$$CoachingImplCopyWithImpl<$Res>
    extends _$SosFlowStateCopyWithImpl<$Res, _$CoachingImpl>
    implements _$$CoachingImplCopyWith<$Res> {
  __$$CoachingImplCopyWithImpl(
      _$CoachingImpl _value, $Res Function(_$CoachingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? step = null,
  }) {
    return _then(_$CoachingImpl(
      null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as SosSession,
      null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as CoachingStep,
    ));
  }

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosSessionCopyWith<$Res> get session {
    return $SosSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoachingStepCopyWith<$Res> get step {
    return $CoachingStepCopyWith<$Res>(_value.step, (value) {
      return _then(_value.copyWith(step: value));
    });
  }
}

/// @nodoc

class _$CoachingImpl implements _Coaching {
  const _$CoachingImpl(this.session, this.step);

  @override
  final SosSession session;
  @override
  final CoachingStep step;

  @override
  String toString() {
    return 'SosFlowState.coaching(session: $session, step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoachingImpl &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session, step);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoachingImplCopyWith<_$CoachingImpl> get copyWith =>
      __$$CoachingImplCopyWithImpl<_$CoachingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() activating,
    required TResult Function(SosSession session) activated,
    required TResult Function(SosSession session, SosAssessment assessment)
        assessed,
    required TResult Function(SosSession session, CoachingStep step) coaching,
    required TResult Function() resolved,
    required TResult Function(String message) error,
  }) {
    return coaching(session, step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? activating,
    TResult? Function(SosSession session)? activated,
    TResult? Function(SosSession session, SosAssessment assessment)? assessed,
    TResult? Function(SosSession session, CoachingStep step)? coaching,
    TResult? Function()? resolved,
    TResult? Function(String message)? error,
  }) {
    return coaching?.call(session, step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? activating,
    TResult Function(SosSession session)? activated,
    TResult Function(SosSession session, SosAssessment assessment)? assessed,
    TResult Function(SosSession session, CoachingStep step)? coaching,
    TResult Function()? resolved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (coaching != null) {
      return coaching(session, step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Activating value) activating,
    required TResult Function(_Activated value) activated,
    required TResult Function(_Assessed value) assessed,
    required TResult Function(_Coaching value) coaching,
    required TResult Function(_Resolved value) resolved,
    required TResult Function(_Error value) error,
  }) {
    return coaching(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Activating value)? activating,
    TResult? Function(_Activated value)? activated,
    TResult? Function(_Assessed value)? assessed,
    TResult? Function(_Coaching value)? coaching,
    TResult? Function(_Resolved value)? resolved,
    TResult? Function(_Error value)? error,
  }) {
    return coaching?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Activating value)? activating,
    TResult Function(_Activated value)? activated,
    TResult Function(_Assessed value)? assessed,
    TResult Function(_Coaching value)? coaching,
    TResult Function(_Resolved value)? resolved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (coaching != null) {
      return coaching(this);
    }
    return orElse();
  }
}

abstract class _Coaching implements SosFlowState {
  const factory _Coaching(final SosSession session, final CoachingStep step) =
      _$CoachingImpl;

  SosSession get session;
  CoachingStep get step;

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoachingImplCopyWith<_$CoachingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResolvedImplCopyWith<$Res> {
  factory _$$ResolvedImplCopyWith(
          _$ResolvedImpl value, $Res Function(_$ResolvedImpl) then) =
      __$$ResolvedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResolvedImplCopyWithImpl<$Res>
    extends _$SosFlowStateCopyWithImpl<$Res, _$ResolvedImpl>
    implements _$$ResolvedImplCopyWith<$Res> {
  __$$ResolvedImplCopyWithImpl(
      _$ResolvedImpl _value, $Res Function(_$ResolvedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResolvedImpl implements _Resolved {
  const _$ResolvedImpl();

  @override
  String toString() {
    return 'SosFlowState.resolved()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResolvedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() activating,
    required TResult Function(SosSession session) activated,
    required TResult Function(SosSession session, SosAssessment assessment)
        assessed,
    required TResult Function(SosSession session, CoachingStep step) coaching,
    required TResult Function() resolved,
    required TResult Function(String message) error,
  }) {
    return resolved();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? activating,
    TResult? Function(SosSession session)? activated,
    TResult? Function(SosSession session, SosAssessment assessment)? assessed,
    TResult? Function(SosSession session, CoachingStep step)? coaching,
    TResult? Function()? resolved,
    TResult? Function(String message)? error,
  }) {
    return resolved?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? activating,
    TResult Function(SosSession session)? activated,
    TResult Function(SosSession session, SosAssessment assessment)? assessed,
    TResult Function(SosSession session, CoachingStep step)? coaching,
    TResult Function()? resolved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (resolved != null) {
      return resolved();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Activating value) activating,
    required TResult Function(_Activated value) activated,
    required TResult Function(_Assessed value) assessed,
    required TResult Function(_Coaching value) coaching,
    required TResult Function(_Resolved value) resolved,
    required TResult Function(_Error value) error,
  }) {
    return resolved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Activating value)? activating,
    TResult? Function(_Activated value)? activated,
    TResult? Function(_Assessed value)? assessed,
    TResult? Function(_Coaching value)? coaching,
    TResult? Function(_Resolved value)? resolved,
    TResult? Function(_Error value)? error,
  }) {
    return resolved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Activating value)? activating,
    TResult Function(_Activated value)? activated,
    TResult Function(_Assessed value)? assessed,
    TResult Function(_Coaching value)? coaching,
    TResult Function(_Resolved value)? resolved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (resolved != null) {
      return resolved(this);
    }
    return orElse();
  }
}

abstract class _Resolved implements SosFlowState {
  const factory _Resolved() = _$ResolvedImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SosFlowStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SosFlowState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() activating,
    required TResult Function(SosSession session) activated,
    required TResult Function(SosSession session, SosAssessment assessment)
        assessed,
    required TResult Function(SosSession session, CoachingStep step) coaching,
    required TResult Function() resolved,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? activating,
    TResult? Function(SosSession session)? activated,
    TResult? Function(SosSession session, SosAssessment assessment)? assessed,
    TResult? Function(SosSession session, CoachingStep step)? coaching,
    TResult? Function()? resolved,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? activating,
    TResult Function(SosSession session)? activated,
    TResult Function(SosSession session, SosAssessment assessment)? assessed,
    TResult Function(SosSession session, CoachingStep step)? coaching,
    TResult Function()? resolved,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Activating value) activating,
    required TResult Function(_Activated value) activated,
    required TResult Function(_Assessed value) assessed,
    required TResult Function(_Coaching value) coaching,
    required TResult Function(_Resolved value) resolved,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Activating value)? activating,
    TResult? Function(_Activated value)? activated,
    TResult? Function(_Assessed value)? assessed,
    TResult? Function(_Coaching value)? coaching,
    TResult? Function(_Resolved value)? resolved,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Activating value)? activating,
    TResult Function(_Activated value)? activated,
    TResult Function(_Assessed value)? assessed,
    TResult Function(_Coaching value)? coaching,
    TResult Function(_Resolved value)? resolved,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SosFlowState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of SosFlowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
