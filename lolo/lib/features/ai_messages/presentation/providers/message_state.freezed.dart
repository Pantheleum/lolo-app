// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessageGenerationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() generating,
    required TResult Function(GeneratedMessageEntity message) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(GeneratedMessageEntity message)? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(GeneratedMessageEntity message)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Generating value) generating,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Generating value)? generating,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Generating value)? generating,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageGenerationStateCopyWith<$Res> {
  factory $MessageGenerationStateCopyWith(MessageGenerationState value,
          $Res Function(MessageGenerationState) then) =
      _$MessageGenerationStateCopyWithImpl<$Res, MessageGenerationState>;
}

/// @nodoc
class _$MessageGenerationStateCopyWithImpl<$Res,
        $Val extends MessageGenerationState>
    implements $MessageGenerationStateCopyWith<$Res> {
  _$MessageGenerationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageGenerationState
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
    extends _$MessageGenerationStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageGenerationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleImpl implements _Idle {
  const _$IdleImpl();

  @override
  String toString() {
    return 'MessageGenerationState.idle()';
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
    required TResult Function() generating,
    required TResult Function(GeneratedMessageEntity message) success,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(GeneratedMessageEntity message)? success,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(GeneratedMessageEntity message)? success,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements MessageGenerationState {
  const factory _Idle() = _$IdleImpl;
}

/// @nodoc
abstract class _$$GeneratingImplCopyWith<$Res> {
  factory _$$GeneratingImplCopyWith(
          _$GeneratingImpl value, $Res Function(_$GeneratingImpl) then) =
      __$$GeneratingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GeneratingImplCopyWithImpl<$Res>
    extends _$MessageGenerationStateCopyWithImpl<$Res, _$GeneratingImpl>
    implements _$$GeneratingImplCopyWith<$Res> {
  __$$GeneratingImplCopyWithImpl(
      _$GeneratingImpl _value, $Res Function(_$GeneratingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageGenerationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GeneratingImpl implements _Generating {
  const _$GeneratingImpl();

  @override
  String toString() {
    return 'MessageGenerationState.generating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GeneratingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() generating,
    required TResult Function(GeneratedMessageEntity message) success,
    required TResult Function(String message) error,
  }) {
    return generating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(GeneratedMessageEntity message)? success,
    TResult? Function(String message)? error,
  }) {
    return generating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(GeneratedMessageEntity message)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Generating value) generating,
    required TResult Function(_Success value) success,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating(this);
    }
    return orElse();
  }
}

abstract class _Generating implements MessageGenerationState {
  const factory _Generating() = _$GeneratingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GeneratedMessageEntity message});

  $GeneratedMessageEntityCopyWith<$Res> get message;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$MessageGenerationStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageGenerationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SuccessImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as GeneratedMessageEntity,
    ));
  }

  /// Create a copy of MessageGenerationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeneratedMessageEntityCopyWith<$Res> get message {
    return $GeneratedMessageEntityCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl({required this.message});

  @override
  final GeneratedMessageEntity message;

  @override
  String toString() {
    return 'MessageGenerationState.success(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MessageGenerationState
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
    required TResult Function() generating,
    required TResult Function(GeneratedMessageEntity message) success,
    required TResult Function(String message) error,
  }) {
    return success(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(GeneratedMessageEntity message)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(GeneratedMessageEntity message)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Generating value) generating,
    required TResult Function(_Success value) success,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements MessageGenerationState {
  const factory _Success({required final GeneratedMessageEntity message}) =
      _$SuccessImpl;

  GeneratedMessageEntity get message;

  /// Create a copy of MessageGenerationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
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
    extends _$MessageGenerationStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageGenerationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'MessageGenerationState.error(message: $message)';
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

  /// Create a copy of MessageGenerationState
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
    required TResult Function() generating,
    required TResult Function(GeneratedMessageEntity message) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(GeneratedMessageEntity message)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(GeneratedMessageEntity message)? success,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements MessageGenerationState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;

  /// Create a copy of MessageGenerationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MessageHistoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GeneratedMessageEntity> messages,
            bool hasMore, int currentPage, bool isLoadingMore)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HistoryInitial value) initial,
    required TResult Function(_HistoryLoading value) loading,
    required TResult Function(_HistoryLoaded value) loaded,
    required TResult Function(_HistoryError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistoryInitial value)? initial,
    TResult? Function(_HistoryLoading value)? loading,
    TResult? Function(_HistoryLoaded value)? loaded,
    TResult? Function(_HistoryError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistoryInitial value)? initial,
    TResult Function(_HistoryLoading value)? loading,
    TResult Function(_HistoryLoaded value)? loaded,
    TResult Function(_HistoryError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageHistoryStateCopyWith<$Res> {
  factory $MessageHistoryStateCopyWith(
          MessageHistoryState value, $Res Function(MessageHistoryState) then) =
      _$MessageHistoryStateCopyWithImpl<$Res, MessageHistoryState>;
}

/// @nodoc
class _$MessageHistoryStateCopyWithImpl<$Res, $Val extends MessageHistoryState>
    implements $MessageHistoryStateCopyWith<$Res> {
  _$MessageHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageHistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HistoryInitialImplCopyWith<$Res> {
  factory _$$HistoryInitialImplCopyWith(_$HistoryInitialImpl value,
          $Res Function(_$HistoryInitialImpl) then) =
      __$$HistoryInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HistoryInitialImplCopyWithImpl<$Res>
    extends _$MessageHistoryStateCopyWithImpl<$Res, _$HistoryInitialImpl>
    implements _$$HistoryInitialImplCopyWith<$Res> {
  __$$HistoryInitialImplCopyWithImpl(
      _$HistoryInitialImpl _value, $Res Function(_$HistoryInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageHistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HistoryInitialImpl implements _HistoryInitial {
  const _$HistoryInitialImpl();

  @override
  String toString() {
    return 'MessageHistoryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HistoryInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GeneratedMessageEntity> messages,
            bool hasMore, int currentPage, bool isLoadingMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HistoryInitial value) initial,
    required TResult Function(_HistoryLoading value) loading,
    required TResult Function(_HistoryLoaded value) loaded,
    required TResult Function(_HistoryError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistoryInitial value)? initial,
    TResult? Function(_HistoryLoading value)? loading,
    TResult? Function(_HistoryLoaded value)? loaded,
    TResult? Function(_HistoryError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistoryInitial value)? initial,
    TResult Function(_HistoryLoading value)? loading,
    TResult Function(_HistoryLoaded value)? loaded,
    TResult Function(_HistoryError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _HistoryInitial implements MessageHistoryState {
  const factory _HistoryInitial() = _$HistoryInitialImpl;
}

/// @nodoc
abstract class _$$HistoryLoadingImplCopyWith<$Res> {
  factory _$$HistoryLoadingImplCopyWith(_$HistoryLoadingImpl value,
          $Res Function(_$HistoryLoadingImpl) then) =
      __$$HistoryLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HistoryLoadingImplCopyWithImpl<$Res>
    extends _$MessageHistoryStateCopyWithImpl<$Res, _$HistoryLoadingImpl>
    implements _$$HistoryLoadingImplCopyWith<$Res> {
  __$$HistoryLoadingImplCopyWithImpl(
      _$HistoryLoadingImpl _value, $Res Function(_$HistoryLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageHistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HistoryLoadingImpl implements _HistoryLoading {
  const _$HistoryLoadingImpl();

  @override
  String toString() {
    return 'MessageHistoryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HistoryLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GeneratedMessageEntity> messages,
            bool hasMore, int currentPage, bool isLoadingMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HistoryInitial value) initial,
    required TResult Function(_HistoryLoading value) loading,
    required TResult Function(_HistoryLoaded value) loaded,
    required TResult Function(_HistoryError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistoryInitial value)? initial,
    TResult? Function(_HistoryLoading value)? loading,
    TResult? Function(_HistoryLoaded value)? loaded,
    TResult? Function(_HistoryError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistoryInitial value)? initial,
    TResult Function(_HistoryLoading value)? loading,
    TResult Function(_HistoryLoaded value)? loaded,
    TResult Function(_HistoryError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _HistoryLoading implements MessageHistoryState {
  const factory _HistoryLoading() = _$HistoryLoadingImpl;
}

/// @nodoc
abstract class _$$HistoryLoadedImplCopyWith<$Res> {
  factory _$$HistoryLoadedImplCopyWith(
          _$HistoryLoadedImpl value, $Res Function(_$HistoryLoadedImpl) then) =
      __$$HistoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<GeneratedMessageEntity> messages,
      bool hasMore,
      int currentPage,
      bool isLoadingMore});
}

/// @nodoc
class __$$HistoryLoadedImplCopyWithImpl<$Res>
    extends _$MessageHistoryStateCopyWithImpl<$Res, _$HistoryLoadedImpl>
    implements _$$HistoryLoadedImplCopyWith<$Res> {
  __$$HistoryLoadedImplCopyWithImpl(
      _$HistoryLoadedImpl _value, $Res Function(_$HistoryLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? isLoadingMore = null,
  }) {
    return _then(_$HistoryLoadedImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<GeneratedMessageEntity>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HistoryLoadedImpl implements _HistoryLoaded {
  const _$HistoryLoadedImpl(
      {required final List<GeneratedMessageEntity> messages,
      required this.hasMore,
      required this.currentPage,
      this.isLoadingMore = false})
      : _messages = messages;

  final List<GeneratedMessageEntity> _messages;
  @override
  List<GeneratedMessageEntity> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final bool hasMore;
  @override
  final int currentPage;
  @override
  @JsonKey()
  final bool isLoadingMore;

  @override
  String toString() {
    return 'MessageHistoryState.loaded(messages: $messages, hasMore: $hasMore, currentPage: $currentPage, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryLoadedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      hasMore,
      currentPage,
      isLoadingMore);

  /// Create a copy of MessageHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryLoadedImplCopyWith<_$HistoryLoadedImpl> get copyWith =>
      __$$HistoryLoadedImplCopyWithImpl<_$HistoryLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GeneratedMessageEntity> messages,
            bool hasMore, int currentPage, bool isLoadingMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(messages, hasMore, currentPage, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(messages, hasMore, currentPage, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(messages, hasMore, currentPage, isLoadingMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HistoryInitial value) initial,
    required TResult Function(_HistoryLoading value) loading,
    required TResult Function(_HistoryLoaded value) loaded,
    required TResult Function(_HistoryError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistoryInitial value)? initial,
    TResult? Function(_HistoryLoading value)? loading,
    TResult? Function(_HistoryLoaded value)? loaded,
    TResult? Function(_HistoryError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistoryInitial value)? initial,
    TResult Function(_HistoryLoading value)? loading,
    TResult Function(_HistoryLoaded value)? loaded,
    TResult Function(_HistoryError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _HistoryLoaded implements MessageHistoryState {
  const factory _HistoryLoaded(
      {required final List<GeneratedMessageEntity> messages,
      required final bool hasMore,
      required final int currentPage,
      final bool isLoadingMore}) = _$HistoryLoadedImpl;

  List<GeneratedMessageEntity> get messages;
  bool get hasMore;
  int get currentPage;
  bool get isLoadingMore;

  /// Create a copy of MessageHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryLoadedImplCopyWith<_$HistoryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HistoryErrorImplCopyWith<$Res> {
  factory _$$HistoryErrorImplCopyWith(
          _$HistoryErrorImpl value, $Res Function(_$HistoryErrorImpl) then) =
      __$$HistoryErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$HistoryErrorImplCopyWithImpl<$Res>
    extends _$MessageHistoryStateCopyWithImpl<$Res, _$HistoryErrorImpl>
    implements _$$HistoryErrorImplCopyWith<$Res> {
  __$$HistoryErrorImplCopyWithImpl(
      _$HistoryErrorImpl _value, $Res Function(_$HistoryErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$HistoryErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HistoryErrorImpl implements _HistoryError {
  const _$HistoryErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'MessageHistoryState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of MessageHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryErrorImplCopyWith<_$HistoryErrorImpl> get copyWith =>
      __$$HistoryErrorImplCopyWithImpl<_$HistoryErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GeneratedMessageEntity> messages,
            bool hasMore, int currentPage, bool isLoadingMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GeneratedMessageEntity> messages, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
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
    required TResult Function(_HistoryInitial value) initial,
    required TResult Function(_HistoryLoading value) loading,
    required TResult Function(_HistoryLoaded value) loaded,
    required TResult Function(_HistoryError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistoryInitial value)? initial,
    TResult? Function(_HistoryLoading value)? loading,
    TResult? Function(_HistoryLoaded value)? loaded,
    TResult? Function(_HistoryError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistoryInitial value)? initial,
    TResult Function(_HistoryLoading value)? loading,
    TResult Function(_HistoryLoaded value)? loaded,
    TResult Function(_HistoryError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _HistoryError implements MessageHistoryState {
  const factory _HistoryError({required final String message}) =
      _$HistoryErrorImpl;

  String get message;

  /// Create a copy of MessageHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryErrorImplCopyWith<_$HistoryErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
