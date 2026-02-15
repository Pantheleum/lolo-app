// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_generation_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessageGenState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String? statusText) generating,
    required TResult Function(AiMessageResponse response) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? statusText)? generating,
    TResult? Function(AiMessageResponse response)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? statusText)? generating,
    TResult Function(AiMessageResponse response)? success,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Generating value) generating,
    required TResult Function(_Success value) success,
    required TResult Function(_TierLimitReached value) tierLimitReached,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_Success value)? success,
    TResult? Function(_TierLimitReached value)? tierLimitReached,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Generating value)? generating,
    TResult Function(_Success value)? success,
    TResult Function(_TierLimitReached value)? tierLimitReached,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageGenStateCopyWith<$Res> {
  factory $MessageGenStateCopyWith(
          MessageGenState value, $Res Function(MessageGenState) then) =
      _$MessageGenStateCopyWithImpl<$Res, MessageGenState>;
}

/// @nodoc
class _$MessageGenStateCopyWithImpl<$Res, $Val extends MessageGenState>
    implements $MessageGenStateCopyWith<$Res> {
  _$MessageGenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageGenState
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
    extends _$MessageGenStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleImpl implements _Idle {
  const _$IdleImpl();

  @override
  String toString() {
    return 'MessageGenState.idle()';
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
    required TResult Function(String? statusText) generating,
    required TResult Function(AiMessageResponse response) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? statusText)? generating,
    TResult? Function(AiMessageResponse response)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? statusText)? generating,
    TResult Function(AiMessageResponse response)? success,
    TResult Function(int used, int limit)? tierLimitReached,
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
    required TResult Function(_Generating value) generating,
    required TResult Function(_Success value) success,
    required TResult Function(_TierLimitReached value) tierLimitReached,
    required TResult Function(_Error value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_Success value)? success,
    TResult? Function(_TierLimitReached value)? tierLimitReached,
    TResult? Function(_Error value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Generating value)? generating,
    TResult Function(_Success value)? success,
    TResult Function(_TierLimitReached value)? tierLimitReached,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements MessageGenState {
  const factory _Idle() = _$IdleImpl;
}

/// @nodoc
abstract class _$$GeneratingImplCopyWith<$Res> {
  factory _$$GeneratingImplCopyWith(
          _$GeneratingImpl value, $Res Function(_$GeneratingImpl) then) =
      __$$GeneratingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? statusText});
}

/// @nodoc
class __$$GeneratingImplCopyWithImpl<$Res>
    extends _$MessageGenStateCopyWithImpl<$Res, _$GeneratingImpl>
    implements _$$GeneratingImplCopyWith<$Res> {
  __$$GeneratingImplCopyWithImpl(
      _$GeneratingImpl _value, $Res Function(_$GeneratingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusText = freezed,
  }) {
    return _then(_$GeneratingImpl(
      statusText: freezed == statusText
          ? _value.statusText
          : statusText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GeneratingImpl implements _Generating {
  const _$GeneratingImpl({this.statusText});

  @override
  final String? statusText;

  @override
  String toString() {
    return 'MessageGenState.generating(statusText: $statusText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratingImpl &&
            (identical(other.statusText, statusText) ||
                other.statusText == statusText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusText);

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratingImplCopyWith<_$GeneratingImpl> get copyWith =>
      __$$GeneratingImplCopyWithImpl<_$GeneratingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String? statusText) generating,
    required TResult Function(AiMessageResponse response) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return generating(statusText);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? statusText)? generating,
    TResult? Function(AiMessageResponse response)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return generating?.call(statusText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? statusText)? generating,
    TResult Function(AiMessageResponse response)? success,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating(statusText);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Generating value) generating,
    required TResult Function(_Success value) success,
    required TResult Function(_TierLimitReached value) tierLimitReached,
    required TResult Function(_Error value) error,
  }) {
    return generating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_Success value)? success,
    TResult? Function(_TierLimitReached value)? tierLimitReached,
    TResult? Function(_Error value)? error,
  }) {
    return generating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Generating value)? generating,
    TResult Function(_Success value)? success,
    TResult Function(_TierLimitReached value)? tierLimitReached,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating(this);
    }
    return orElse();
  }
}

abstract class _Generating implements MessageGenState {
  const factory _Generating({final String? statusText}) = _$GeneratingImpl;

  String? get statusText;

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneratingImplCopyWith<_$GeneratingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AiMessageResponse response});

  $AiMessageResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$MessageGenStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$SuccessImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as AiMessageResponse,
    ));
  }

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AiMessageResponseCopyWith<$Res> get response {
    return $AiMessageResponseCopyWith<$Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value));
    });
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.response);

  @override
  final AiMessageResponse response;

  @override
  String toString() {
    return 'MessageGenState.success(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String? statusText) generating,
    required TResult Function(AiMessageResponse response) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return success(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? statusText)? generating,
    TResult? Function(AiMessageResponse response)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return success?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? statusText)? generating,
    TResult Function(AiMessageResponse response)? success,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Generating value) generating,
    required TResult Function(_Success value) success,
    required TResult Function(_TierLimitReached value) tierLimitReached,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_Success value)? success,
    TResult? Function(_TierLimitReached value)? tierLimitReached,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Generating value)? generating,
    TResult Function(_Success value)? success,
    TResult Function(_TierLimitReached value)? tierLimitReached,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements MessageGenState {
  const factory _Success(final AiMessageResponse response) = _$SuccessImpl;

  AiMessageResponse get response;

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TierLimitReachedImplCopyWith<$Res> {
  factory _$$TierLimitReachedImplCopyWith(_$TierLimitReachedImpl value,
          $Res Function(_$TierLimitReachedImpl) then) =
      __$$TierLimitReachedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int used, int limit});
}

/// @nodoc
class __$$TierLimitReachedImplCopyWithImpl<$Res>
    extends _$MessageGenStateCopyWithImpl<$Res, _$TierLimitReachedImpl>
    implements _$$TierLimitReachedImplCopyWith<$Res> {
  __$$TierLimitReachedImplCopyWithImpl(_$TierLimitReachedImpl _value,
      $Res Function(_$TierLimitReachedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? used = null,
    Object? limit = null,
  }) {
    return _then(_$TierLimitReachedImpl(
      used: null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TierLimitReachedImpl implements _TierLimitReached {
  const _$TierLimitReachedImpl({required this.used, required this.limit});

  @override
  final int used;
  @override
  final int limit;

  @override
  String toString() {
    return 'MessageGenState.tierLimitReached(used: $used, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TierLimitReachedImpl &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, used, limit);

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TierLimitReachedImplCopyWith<_$TierLimitReachedImpl> get copyWith =>
      __$$TierLimitReachedImplCopyWithImpl<_$TierLimitReachedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String? statusText) generating,
    required TResult Function(AiMessageResponse response) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return tierLimitReached(used, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? statusText)? generating,
    TResult? Function(AiMessageResponse response)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return tierLimitReached?.call(used, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? statusText)? generating,
    TResult Function(AiMessageResponse response)? success,
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
    required TResult Function(_Idle value) idle,
    required TResult Function(_Generating value) generating,
    required TResult Function(_Success value) success,
    required TResult Function(_TierLimitReached value) tierLimitReached,
    required TResult Function(_Error value) error,
  }) {
    return tierLimitReached(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_Success value)? success,
    TResult? Function(_TierLimitReached value)? tierLimitReached,
    TResult? Function(_Error value)? error,
  }) {
    return tierLimitReached?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Generating value)? generating,
    TResult Function(_Success value)? success,
    TResult Function(_TierLimitReached value)? tierLimitReached,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (tierLimitReached != null) {
      return tierLimitReached(this);
    }
    return orElse();
  }
}

abstract class _TierLimitReached implements MessageGenState {
  const factory _TierLimitReached(
      {required final int used,
      required final int limit}) = _$TierLimitReachedImpl;

  int get used;
  int get limit;

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TierLimitReachedImplCopyWith<_$TierLimitReachedImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$MessageGenStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageGenState
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
    return 'MessageGenState.error(message: $message)';
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

  /// Create a copy of MessageGenState
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
    required TResult Function(String? statusText) generating,
    required TResult Function(AiMessageResponse response) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? statusText)? generating,
    TResult? Function(AiMessageResponse response)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? statusText)? generating,
    TResult Function(AiMessageResponse response)? success,
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
    required TResult Function(_Idle value) idle,
    required TResult Function(_Generating value) generating,
    required TResult Function(_Success value) success,
    required TResult Function(_TierLimitReached value) tierLimitReached,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_Success value)? success,
    TResult? Function(_TierLimitReached value)? tierLimitReached,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Generating value)? generating,
    TResult Function(_Success value)? success,
    TResult Function(_TierLimitReached value)? tierLimitReached,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements MessageGenState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of MessageGenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
