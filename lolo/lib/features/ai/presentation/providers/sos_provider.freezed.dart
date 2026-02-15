// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SosSessionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosSessionStateCopyWith<$Res> {
  factory $SosSessionStateCopyWith(
          SosSessionState value, $Res Function(SosSessionState) then) =
      _$SosSessionStateCopyWithImpl<$Res, SosSessionState>;
}

/// @nodoc
class _$SosSessionStateCopyWithImpl<$Res, $Val extends SosSessionState>
    implements $SosSessionStateCopyWith<$Res> {
  _$SosSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SosInactiveImplCopyWith<$Res> {
  factory _$$SosInactiveImplCopyWith(
          _$SosInactiveImpl value, $Res Function(_$SosInactiveImpl) then) =
      __$$SosInactiveImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SosInactiveImplCopyWithImpl<$Res>
    extends _$SosSessionStateCopyWithImpl<$Res, _$SosInactiveImpl>
    implements _$$SosInactiveImplCopyWith<$Res> {
  __$$SosInactiveImplCopyWithImpl(
      _$SosInactiveImpl _value, $Res Function(_$SosInactiveImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SosInactiveImpl implements _SosInactive {
  const _$SosInactiveImpl();

  @override
  String toString() {
    return 'SosSessionState.inactive()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SosInactiveImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return inactive();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return inactive?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) {
    return inactive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) {
    return inactive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive(this);
    }
    return orElse();
  }
}

abstract class _SosInactive implements SosSessionState {
  const factory _SosInactive() = _$SosInactiveImpl;
}

/// @nodoc
abstract class _$$SosActivatingImplCopyWith<$Res> {
  factory _$$SosActivatingImplCopyWith(
          _$SosActivatingImpl value, $Res Function(_$SosActivatingImpl) then) =
      __$$SosActivatingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SosActivatingImplCopyWithImpl<$Res>
    extends _$SosSessionStateCopyWithImpl<$Res, _$SosActivatingImpl>
    implements _$$SosActivatingImplCopyWith<$Res> {
  __$$SosActivatingImplCopyWithImpl(
      _$SosActivatingImpl _value, $Res Function(_$SosActivatingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SosActivatingImpl implements _SosActivating {
  const _$SosActivatingImpl();

  @override
  String toString() {
    return 'SosSessionState.activating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SosActivatingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return activating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return activating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
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
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) {
    return activating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) {
    return activating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) {
    if (activating != null) {
      return activating(this);
    }
    return orElse();
  }
}

abstract class _SosActivating implements SosSessionState {
  const factory _SosActivating() = _$SosActivatingImpl;
}

/// @nodoc
abstract class _$$SosActivatedImplCopyWith<$Res> {
  factory _$$SosActivatedImplCopyWith(
          _$SosActivatedImpl value, $Res Function(_$SosActivatedImpl) then) =
      __$$SosActivatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SosActivateResponse data});

  $SosActivateResponseCopyWith<$Res> get data;
}

/// @nodoc
class __$$SosActivatedImplCopyWithImpl<$Res>
    extends _$SosSessionStateCopyWithImpl<$Res, _$SosActivatedImpl>
    implements _$$SosActivatedImplCopyWith<$Res> {
  __$$SosActivatedImplCopyWithImpl(
      _$SosActivatedImpl _value, $Res Function(_$SosActivatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SosActivatedImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SosActivateResponse,
    ));
  }

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosActivateResponseCopyWith<$Res> get data {
    return $SosActivateResponseCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc

class _$SosActivatedImpl implements _SosActivated {
  const _$SosActivatedImpl(this.data);

  @override
  final SosActivateResponse data;

  @override
  String toString() {
    return 'SosSessionState.activated(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosActivatedImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosActivatedImplCopyWith<_$SosActivatedImpl> get copyWith =>
      __$$SosActivatedImplCopyWithImpl<_$SosActivatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return activated(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return activated?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (activated != null) {
      return activated(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) {
    return activated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) {
    return activated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) {
    if (activated != null) {
      return activated(this);
    }
    return orElse();
  }
}

abstract class _SosActivated implements SosSessionState {
  const factory _SosActivated(final SosActivateResponse data) =
      _$SosActivatedImpl;

  SosActivateResponse get data;

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosActivatedImplCopyWith<_$SosActivatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SosAssessingImplCopyWith<$Res> {
  factory _$$SosAssessingImplCopyWith(
          _$SosAssessingImpl value, $Res Function(_$SosAssessingImpl) then) =
      __$$SosAssessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SosAssessingImplCopyWithImpl<$Res>
    extends _$SosSessionStateCopyWithImpl<$Res, _$SosAssessingImpl>
    implements _$$SosAssessingImplCopyWith<$Res> {
  __$$SosAssessingImplCopyWithImpl(
      _$SosAssessingImpl _value, $Res Function(_$SosAssessingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SosAssessingImpl implements _SosAssessing {
  const _$SosAssessingImpl();

  @override
  String toString() {
    return 'SosSessionState.assessing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SosAssessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return assessing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return assessing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (assessing != null) {
      return assessing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) {
    return assessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) {
    return assessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) {
    if (assessing != null) {
      return assessing(this);
    }
    return orElse();
  }
}

abstract class _SosAssessing implements SosSessionState {
  const factory _SosAssessing() = _$SosAssessingImpl;
}

/// @nodoc
abstract class _$$SosAssessedImplCopyWith<$Res> {
  factory _$$SosAssessedImplCopyWith(
          _$SosAssessedImpl value, $Res Function(_$SosAssessedImpl) then) =
      __$$SosAssessedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SosAssessResponse assessment});

  $SosAssessResponseCopyWith<$Res> get assessment;
}

/// @nodoc
class __$$SosAssessedImplCopyWithImpl<$Res>
    extends _$SosSessionStateCopyWithImpl<$Res, _$SosAssessedImpl>
    implements _$$SosAssessedImplCopyWith<$Res> {
  __$$SosAssessedImplCopyWithImpl(
      _$SosAssessedImpl _value, $Res Function(_$SosAssessedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assessment = null,
  }) {
    return _then(_$SosAssessedImpl(
      null == assessment
          ? _value.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as SosAssessResponse,
    ));
  }

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosAssessResponseCopyWith<$Res> get assessment {
    return $SosAssessResponseCopyWith<$Res>(_value.assessment, (value) {
      return _then(_value.copyWith(assessment: value));
    });
  }
}

/// @nodoc

class _$SosAssessedImpl implements _SosAssessed {
  const _$SosAssessedImpl(this.assessment);

  @override
  final SosAssessResponse assessment;

  @override
  String toString() {
    return 'SosSessionState.assessed(assessment: $assessment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosAssessedImpl &&
            (identical(other.assessment, assessment) ||
                other.assessment == assessment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, assessment);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosAssessedImplCopyWith<_$SosAssessedImpl> get copyWith =>
      __$$SosAssessedImplCopyWithImpl<_$SosAssessedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return assessed(assessment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return assessed?.call(assessment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (assessed != null) {
      return assessed(assessment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) {
    return assessed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) {
    return assessed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) {
    if (assessed != null) {
      return assessed(this);
    }
    return orElse();
  }
}

abstract class _SosAssessed implements SosSessionState {
  const factory _SosAssessed(final SosAssessResponse assessment) =
      _$SosAssessedImpl;

  SosAssessResponse get assessment;

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosAssessedImplCopyWith<_$SosAssessedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SosCoachingImplCopyWith<$Res> {
  factory _$$SosCoachingImplCopyWith(
          _$SosCoachingImpl value, $Res Function(_$SosCoachingImpl) then) =
      __$$SosCoachingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SosCoachResponse step});

  $SosCoachResponseCopyWith<$Res> get step;
}

/// @nodoc
class __$$SosCoachingImplCopyWithImpl<$Res>
    extends _$SosSessionStateCopyWithImpl<$Res, _$SosCoachingImpl>
    implements _$$SosCoachingImplCopyWith<$Res> {
  __$$SosCoachingImplCopyWithImpl(
      _$SosCoachingImpl _value, $Res Function(_$SosCoachingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
  }) {
    return _then(_$SosCoachingImpl(
      null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as SosCoachResponse,
    ));
  }

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosCoachResponseCopyWith<$Res> get step {
    return $SosCoachResponseCopyWith<$Res>(_value.step, (value) {
      return _then(_value.copyWith(step: value));
    });
  }
}

/// @nodoc

class _$SosCoachingImpl implements _SosCoaching {
  const _$SosCoachingImpl(this.step);

  @override
  final SosCoachResponse step;

  @override
  String toString() {
    return 'SosSessionState.coaching(step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosCoachingImpl &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, step);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosCoachingImplCopyWith<_$SosCoachingImpl> get copyWith =>
      __$$SosCoachingImplCopyWithImpl<_$SosCoachingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return coaching(step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return coaching?.call(step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (coaching != null) {
      return coaching(step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) {
    return coaching(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) {
    return coaching?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) {
    if (coaching != null) {
      return coaching(this);
    }
    return orElse();
  }
}

abstract class _SosCoaching implements SosSessionState {
  const factory _SosCoaching(final SosCoachResponse step) = _$SosCoachingImpl;

  SosCoachResponse get step;

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosCoachingImplCopyWith<_$SosCoachingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SosStreamingCoachImplCopyWith<$Res> {
  factory _$$SosStreamingCoachImplCopyWith(_$SosStreamingCoachImpl value,
          $Res Function(_$SosStreamingCoachImpl) then) =
      __$$SosStreamingCoachImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int stepNumber,
      String? sayThis,
      String? bodyLanguage,
      List<String>? doNotSay,
      bool isComplete});
}

/// @nodoc
class __$$SosStreamingCoachImplCopyWithImpl<$Res>
    extends _$SosSessionStateCopyWithImpl<$Res, _$SosStreamingCoachImpl>
    implements _$$SosStreamingCoachImplCopyWith<$Res> {
  __$$SosStreamingCoachImplCopyWithImpl(_$SosStreamingCoachImpl _value,
      $Res Function(_$SosStreamingCoachImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepNumber = null,
    Object? sayThis = freezed,
    Object? bodyLanguage = freezed,
    Object? doNotSay = freezed,
    Object? isComplete = null,
  }) {
    return _then(_$SosStreamingCoachImpl(
      stepNumber: null == stepNumber
          ? _value.stepNumber
          : stepNumber // ignore: cast_nullable_to_non_nullable
              as int,
      sayThis: freezed == sayThis
          ? _value.sayThis
          : sayThis // ignore: cast_nullable_to_non_nullable
              as String?,
      bodyLanguage: freezed == bodyLanguage
          ? _value.bodyLanguage
          : bodyLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      doNotSay: freezed == doNotSay
          ? _value._doNotSay
          : doNotSay // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SosStreamingCoachImpl implements _SosStreamingCoach {
  const _$SosStreamingCoachImpl(
      {required this.stepNumber,
      this.sayThis,
      this.bodyLanguage,
      final List<String>? doNotSay,
      this.isComplete = false})
      : _doNotSay = doNotSay;

  @override
  final int stepNumber;
  @override
  final String? sayThis;
  @override
  final String? bodyLanguage;
  final List<String>? _doNotSay;
  @override
  List<String>? get doNotSay {
    final value = _doNotSay;
    if (value == null) return null;
    if (_doNotSay is EqualUnmodifiableListView) return _doNotSay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isComplete;

  @override
  String toString() {
    return 'SosSessionState.streamingCoach(stepNumber: $stepNumber, sayThis: $sayThis, bodyLanguage: $bodyLanguage, doNotSay: $doNotSay, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosStreamingCoachImpl &&
            (identical(other.stepNumber, stepNumber) ||
                other.stepNumber == stepNumber) &&
            (identical(other.sayThis, sayThis) || other.sayThis == sayThis) &&
            (identical(other.bodyLanguage, bodyLanguage) ||
                other.bodyLanguage == bodyLanguage) &&
            const DeepCollectionEquality().equals(other._doNotSay, _doNotSay) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stepNumber, sayThis,
      bodyLanguage, const DeepCollectionEquality().hash(_doNotSay), isComplete);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosStreamingCoachImplCopyWith<_$SosStreamingCoachImpl> get copyWith =>
      __$$SosStreamingCoachImplCopyWithImpl<_$SosStreamingCoachImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return streamingCoach(
        stepNumber, sayThis, bodyLanguage, doNotSay, isComplete);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return streamingCoach?.call(
        stepNumber, sayThis, bodyLanguage, doNotSay, isComplete);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (streamingCoach != null) {
      return streamingCoach(
          stepNumber, sayThis, bodyLanguage, doNotSay, isComplete);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) {
    return streamingCoach(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) {
    return streamingCoach?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) {
    if (streamingCoach != null) {
      return streamingCoach(this);
    }
    return orElse();
  }
}

abstract class _SosStreamingCoach implements SosSessionState {
  const factory _SosStreamingCoach(
      {required final int stepNumber,
      final String? sayThis,
      final String? bodyLanguage,
      final List<String>? doNotSay,
      final bool isComplete}) = _$SosStreamingCoachImpl;

  int get stepNumber;
  String? get sayThis;
  String? get bodyLanguage;
  List<String>? get doNotSay;
  bool get isComplete;

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosStreamingCoachImplCopyWith<_$SosStreamingCoachImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SosTierLimitImplCopyWith<$Res> {
  factory _$$SosTierLimitImplCopyWith(
          _$SosTierLimitImpl value, $Res Function(_$SosTierLimitImpl) then) =
      __$$SosTierLimitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int used, int limit});
}

/// @nodoc
class __$$SosTierLimitImplCopyWithImpl<$Res>
    extends _$SosSessionStateCopyWithImpl<$Res, _$SosTierLimitImpl>
    implements _$$SosTierLimitImplCopyWith<$Res> {
  __$$SosTierLimitImplCopyWithImpl(
      _$SosTierLimitImpl _value, $Res Function(_$SosTierLimitImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? used = null,
    Object? limit = null,
  }) {
    return _then(_$SosTierLimitImpl(
      null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as int,
      null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SosTierLimitImpl implements _SosTierLimit {
  const _$SosTierLimitImpl(this.used, this.limit);

  @override
  final int used;
  @override
  final int limit;

  @override
  String toString() {
    return 'SosSessionState.tierLimitReached(used: $used, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosTierLimitImpl &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, used, limit);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosTierLimitImplCopyWith<_$SosTierLimitImpl> get copyWith =>
      __$$SosTierLimitImplCopyWithImpl<_$SosTierLimitImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return tierLimitReached(used, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return tierLimitReached?.call(used, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (tierLimitReached != null) {
      return tierLimitReached(used, limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) {
    return tierLimitReached(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) {
    return tierLimitReached?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) {
    if (tierLimitReached != null) {
      return tierLimitReached(this);
    }
    return orElse();
  }
}

abstract class _SosTierLimit implements SosSessionState {
  const factory _SosTierLimit(final int used, final int limit) =
      _$SosTierLimitImpl;

  int get used;
  int get limit;

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosTierLimitImplCopyWith<_$SosTierLimitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SosErrorImplCopyWith<$Res> {
  factory _$$SosErrorImplCopyWith(
          _$SosErrorImpl value, $Res Function(_$SosErrorImpl) then) =
      __$$SosErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SosErrorImplCopyWithImpl<$Res>
    extends _$SosSessionStateCopyWithImpl<$Res, _$SosErrorImpl>
    implements _$$SosErrorImplCopyWith<$Res> {
  __$$SosErrorImplCopyWithImpl(
      _$SosErrorImpl _value, $Res Function(_$SosErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SosErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SosErrorImpl implements _SosError {
  const _$SosErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SosSessionState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosErrorImplCopyWith<_$SosErrorImpl> get copyWith =>
      __$$SosErrorImplCopyWithImpl<_$SosErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inactive,
    required TResult Function() activating,
    required TResult Function(SosActivateResponse data) activated,
    required TResult Function() assessing,
    required TResult Function(SosAssessResponse assessment) assessed,
    required TResult Function(SosCoachResponse step) coaching,
    required TResult Function(int stepNumber, String? sayThis,
            String? bodyLanguage, List<String>? doNotSay, bool isComplete)
        streamingCoach,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? inactive,
    TResult? Function()? activating,
    TResult? Function(SosActivateResponse data)? activated,
    TResult? Function()? assessing,
    TResult? Function(SosAssessResponse assessment)? assessed,
    TResult? Function(SosCoachResponse step)? coaching,
    TResult? Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inactive,
    TResult Function()? activating,
    TResult Function(SosActivateResponse data)? activated,
    TResult Function()? assessing,
    TResult Function(SosAssessResponse assessment)? assessed,
    TResult Function(SosCoachResponse step)? coaching,
    TResult Function(int stepNumber, String? sayThis, String? bodyLanguage,
            List<String>? doNotSay, bool isComplete)?
        streamingCoach,
    TResult Function(int used, int limit)? tierLimitReached,
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
    required TResult Function(_SosInactive value) inactive,
    required TResult Function(_SosActivating value) activating,
    required TResult Function(_SosActivated value) activated,
    required TResult Function(_SosAssessing value) assessing,
    required TResult Function(_SosAssessed value) assessed,
    required TResult Function(_SosCoaching value) coaching,
    required TResult Function(_SosStreamingCoach value) streamingCoach,
    required TResult Function(_SosTierLimit value) tierLimitReached,
    required TResult Function(_SosError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SosInactive value)? inactive,
    TResult? Function(_SosActivating value)? activating,
    TResult? Function(_SosActivated value)? activated,
    TResult? Function(_SosAssessing value)? assessing,
    TResult? Function(_SosAssessed value)? assessed,
    TResult? Function(_SosCoaching value)? coaching,
    TResult? Function(_SosStreamingCoach value)? streamingCoach,
    TResult? Function(_SosTierLimit value)? tierLimitReached,
    TResult? Function(_SosError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SosInactive value)? inactive,
    TResult Function(_SosActivating value)? activating,
    TResult Function(_SosActivated value)? activated,
    TResult Function(_SosAssessing value)? assessing,
    TResult Function(_SosAssessed value)? assessed,
    TResult Function(_SosCoaching value)? coaching,
    TResult Function(_SosStreamingCoach value)? streamingCoach,
    TResult Function(_SosTierLimit value)? tierLimitReached,
    TResult Function(_SosError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _SosError implements SosSessionState {
  const factory _SosError(final String message) = _$SosErrorImpl;

  String get message;

  /// Create a copy of SosSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosErrorImplCopyWith<_$SosErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
