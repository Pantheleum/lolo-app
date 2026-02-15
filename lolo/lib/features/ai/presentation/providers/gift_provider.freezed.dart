// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GiftRecommendationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(GiftRecommendationResponse data) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationResponse data)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(GiftRecommendationResponse data)? success,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GiftIdle value) idle,
    required TResult Function(_GiftLoading value) loading,
    required TResult Function(_GiftSuccess value) success,
    required TResult Function(_GiftTierLimit value) tierLimitReached,
    required TResult Function(_GiftError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GiftIdle value)? idle,
    TResult? Function(_GiftLoading value)? loading,
    TResult? Function(_GiftSuccess value)? success,
    TResult? Function(_GiftTierLimit value)? tierLimitReached,
    TResult? Function(_GiftError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GiftIdle value)? idle,
    TResult Function(_GiftLoading value)? loading,
    TResult Function(_GiftSuccess value)? success,
    TResult Function(_GiftTierLimit value)? tierLimitReached,
    TResult Function(_GiftError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftRecommendationStateCopyWith<$Res> {
  factory $GiftRecommendationStateCopyWith(GiftRecommendationState value,
          $Res Function(GiftRecommendationState) then) =
      _$GiftRecommendationStateCopyWithImpl<$Res, GiftRecommendationState>;
}

/// @nodoc
class _$GiftRecommendationStateCopyWithImpl<$Res,
        $Val extends GiftRecommendationState>
    implements $GiftRecommendationStateCopyWith<$Res> {
  _$GiftRecommendationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GiftIdleImplCopyWith<$Res> {
  factory _$$GiftIdleImplCopyWith(
          _$GiftIdleImpl value, $Res Function(_$GiftIdleImpl) then) =
      __$$GiftIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GiftIdleImplCopyWithImpl<$Res>
    extends _$GiftRecommendationStateCopyWithImpl<$Res, _$GiftIdleImpl>
    implements _$$GiftIdleImplCopyWith<$Res> {
  __$$GiftIdleImplCopyWithImpl(
      _$GiftIdleImpl _value, $Res Function(_$GiftIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GiftIdleImpl implements _GiftIdle {
  const _$GiftIdleImpl();

  @override
  String toString() {
    return 'GiftRecommendationState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GiftIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(GiftRecommendationResponse data) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationResponse data)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(GiftRecommendationResponse data)? success,
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
    required TResult Function(_GiftIdle value) idle,
    required TResult Function(_GiftLoading value) loading,
    required TResult Function(_GiftSuccess value) success,
    required TResult Function(_GiftTierLimit value) tierLimitReached,
    required TResult Function(_GiftError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GiftIdle value)? idle,
    TResult? Function(_GiftLoading value)? loading,
    TResult? Function(_GiftSuccess value)? success,
    TResult? Function(_GiftTierLimit value)? tierLimitReached,
    TResult? Function(_GiftError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GiftIdle value)? idle,
    TResult Function(_GiftLoading value)? loading,
    TResult Function(_GiftSuccess value)? success,
    TResult Function(_GiftTierLimit value)? tierLimitReached,
    TResult Function(_GiftError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _GiftIdle implements GiftRecommendationState {
  const factory _GiftIdle() = _$GiftIdleImpl;
}

/// @nodoc
abstract class _$$GiftLoadingImplCopyWith<$Res> {
  factory _$$GiftLoadingImplCopyWith(
          _$GiftLoadingImpl value, $Res Function(_$GiftLoadingImpl) then) =
      __$$GiftLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GiftLoadingImplCopyWithImpl<$Res>
    extends _$GiftRecommendationStateCopyWithImpl<$Res, _$GiftLoadingImpl>
    implements _$$GiftLoadingImplCopyWith<$Res> {
  __$$GiftLoadingImplCopyWithImpl(
      _$GiftLoadingImpl _value, $Res Function(_$GiftLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GiftLoadingImpl implements _GiftLoading {
  const _$GiftLoadingImpl();

  @override
  String toString() {
    return 'GiftRecommendationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GiftLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(GiftRecommendationResponse data) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationResponse data)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(GiftRecommendationResponse data)? success,
    TResult Function(int used, int limit)? tierLimitReached,
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
    required TResult Function(_GiftIdle value) idle,
    required TResult Function(_GiftLoading value) loading,
    required TResult Function(_GiftSuccess value) success,
    required TResult Function(_GiftTierLimit value) tierLimitReached,
    required TResult Function(_GiftError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GiftIdle value)? idle,
    TResult? Function(_GiftLoading value)? loading,
    TResult? Function(_GiftSuccess value)? success,
    TResult? Function(_GiftTierLimit value)? tierLimitReached,
    TResult? Function(_GiftError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GiftIdle value)? idle,
    TResult Function(_GiftLoading value)? loading,
    TResult Function(_GiftSuccess value)? success,
    TResult Function(_GiftTierLimit value)? tierLimitReached,
    TResult Function(_GiftError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _GiftLoading implements GiftRecommendationState {
  const factory _GiftLoading() = _$GiftLoadingImpl;
}

/// @nodoc
abstract class _$$GiftSuccessImplCopyWith<$Res> {
  factory _$$GiftSuccessImplCopyWith(
          _$GiftSuccessImpl value, $Res Function(_$GiftSuccessImpl) then) =
      __$$GiftSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GiftRecommendationResponse data});

  $GiftRecommendationResponseCopyWith<$Res> get data;
}

/// @nodoc
class __$$GiftSuccessImplCopyWithImpl<$Res>
    extends _$GiftRecommendationStateCopyWithImpl<$Res, _$GiftSuccessImpl>
    implements _$$GiftSuccessImplCopyWith<$Res> {
  __$$GiftSuccessImplCopyWithImpl(
      _$GiftSuccessImpl _value, $Res Function(_$GiftSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$GiftSuccessImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GiftRecommendationResponse,
    ));
  }

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GiftRecommendationResponseCopyWith<$Res> get data {
    return $GiftRecommendationResponseCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc

class _$GiftSuccessImpl implements _GiftSuccess {
  const _$GiftSuccessImpl(this.data);

  @override
  final GiftRecommendationResponse data;

  @override
  String toString() {
    return 'GiftRecommendationState.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftSuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftSuccessImplCopyWith<_$GiftSuccessImpl> get copyWith =>
      __$$GiftSuccessImplCopyWithImpl<_$GiftSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(GiftRecommendationResponse data) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationResponse data)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(GiftRecommendationResponse data)? success,
    TResult Function(int used, int limit)? tierLimitReached,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GiftIdle value) idle,
    required TResult Function(_GiftLoading value) loading,
    required TResult Function(_GiftSuccess value) success,
    required TResult Function(_GiftTierLimit value) tierLimitReached,
    required TResult Function(_GiftError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GiftIdle value)? idle,
    TResult? Function(_GiftLoading value)? loading,
    TResult? Function(_GiftSuccess value)? success,
    TResult? Function(_GiftTierLimit value)? tierLimitReached,
    TResult? Function(_GiftError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GiftIdle value)? idle,
    TResult Function(_GiftLoading value)? loading,
    TResult Function(_GiftSuccess value)? success,
    TResult Function(_GiftTierLimit value)? tierLimitReached,
    TResult Function(_GiftError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _GiftSuccess implements GiftRecommendationState {
  const factory _GiftSuccess(final GiftRecommendationResponse data) =
      _$GiftSuccessImpl;

  GiftRecommendationResponse get data;

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftSuccessImplCopyWith<_$GiftSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GiftTierLimitImplCopyWith<$Res> {
  factory _$$GiftTierLimitImplCopyWith(
          _$GiftTierLimitImpl value, $Res Function(_$GiftTierLimitImpl) then) =
      __$$GiftTierLimitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int used, int limit});
}

/// @nodoc
class __$$GiftTierLimitImplCopyWithImpl<$Res>
    extends _$GiftRecommendationStateCopyWithImpl<$Res, _$GiftTierLimitImpl>
    implements _$$GiftTierLimitImplCopyWith<$Res> {
  __$$GiftTierLimitImplCopyWithImpl(
      _$GiftTierLimitImpl _value, $Res Function(_$GiftTierLimitImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? used = null,
    Object? limit = null,
  }) {
    return _then(_$GiftTierLimitImpl(
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

class _$GiftTierLimitImpl implements _GiftTierLimit {
  const _$GiftTierLimitImpl(this.used, this.limit);

  @override
  final int used;
  @override
  final int limit;

  @override
  String toString() {
    return 'GiftRecommendationState.tierLimitReached(used: $used, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftTierLimitImpl &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, used, limit);

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftTierLimitImplCopyWith<_$GiftTierLimitImpl> get copyWith =>
      __$$GiftTierLimitImplCopyWithImpl<_$GiftTierLimitImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(GiftRecommendationResponse data) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return tierLimitReached(used, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationResponse data)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return tierLimitReached?.call(used, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(GiftRecommendationResponse data)? success,
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
    required TResult Function(_GiftIdle value) idle,
    required TResult Function(_GiftLoading value) loading,
    required TResult Function(_GiftSuccess value) success,
    required TResult Function(_GiftTierLimit value) tierLimitReached,
    required TResult Function(_GiftError value) error,
  }) {
    return tierLimitReached(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GiftIdle value)? idle,
    TResult? Function(_GiftLoading value)? loading,
    TResult? Function(_GiftSuccess value)? success,
    TResult? Function(_GiftTierLimit value)? tierLimitReached,
    TResult? Function(_GiftError value)? error,
  }) {
    return tierLimitReached?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GiftIdle value)? idle,
    TResult Function(_GiftLoading value)? loading,
    TResult Function(_GiftSuccess value)? success,
    TResult Function(_GiftTierLimit value)? tierLimitReached,
    TResult Function(_GiftError value)? error,
    required TResult orElse(),
  }) {
    if (tierLimitReached != null) {
      return tierLimitReached(this);
    }
    return orElse();
  }
}

abstract class _GiftTierLimit implements GiftRecommendationState {
  const factory _GiftTierLimit(final int used, final int limit) =
      _$GiftTierLimitImpl;

  int get used;
  int get limit;

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftTierLimitImplCopyWith<_$GiftTierLimitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GiftErrorImplCopyWith<$Res> {
  factory _$$GiftErrorImplCopyWith(
          _$GiftErrorImpl value, $Res Function(_$GiftErrorImpl) then) =
      __$$GiftErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GiftErrorImplCopyWithImpl<$Res>
    extends _$GiftRecommendationStateCopyWithImpl<$Res, _$GiftErrorImpl>
    implements _$$GiftErrorImplCopyWith<$Res> {
  __$$GiftErrorImplCopyWithImpl(
      _$GiftErrorImpl _value, $Res Function(_$GiftErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$GiftErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GiftErrorImpl implements _GiftError {
  const _$GiftErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'GiftRecommendationState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftErrorImplCopyWith<_$GiftErrorImpl> get copyWith =>
      __$$GiftErrorImplCopyWithImpl<_$GiftErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(GiftRecommendationResponse data) success,
    required TResult Function(int used, int limit) tierLimitReached,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationResponse data)? success,
    TResult? Function(int used, int limit)? tierLimitReached,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(GiftRecommendationResponse data)? success,
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
    required TResult Function(_GiftIdle value) idle,
    required TResult Function(_GiftLoading value) loading,
    required TResult Function(_GiftSuccess value) success,
    required TResult Function(_GiftTierLimit value) tierLimitReached,
    required TResult Function(_GiftError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GiftIdle value)? idle,
    TResult? Function(_GiftLoading value)? loading,
    TResult? Function(_GiftSuccess value)? success,
    TResult? Function(_GiftTierLimit value)? tierLimitReached,
    TResult? Function(_GiftError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GiftIdle value)? idle,
    TResult Function(_GiftLoading value)? loading,
    TResult Function(_GiftSuccess value)? success,
    TResult Function(_GiftTierLimit value)? tierLimitReached,
    TResult Function(_GiftError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _GiftError implements GiftRecommendationState {
  const factory _GiftError(final String message) = _$GiftErrorImpl;

  String get message;

  /// Create a copy of GiftRecommendationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftErrorImplCopyWith<_$GiftErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
