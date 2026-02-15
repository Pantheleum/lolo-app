// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GiftBrowseState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
            bool hasMore, int currentPage, bool isLoadingMore)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BrowseInitial value) initial,
    required TResult Function(_BrowseLoading value) loading,
    required TResult Function(_BrowseLoaded value) loaded,
    required TResult Function(_BrowseError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BrowseInitial value)? initial,
    TResult? Function(_BrowseLoading value)? loading,
    TResult? Function(_BrowseLoaded value)? loaded,
    TResult? Function(_BrowseError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BrowseInitial value)? initial,
    TResult Function(_BrowseLoading value)? loading,
    TResult Function(_BrowseLoaded value)? loaded,
    TResult Function(_BrowseError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftBrowseStateCopyWith<$Res> {
  factory $GiftBrowseStateCopyWith(
          GiftBrowseState value, $Res Function(GiftBrowseState) then) =
      _$GiftBrowseStateCopyWithImpl<$Res, GiftBrowseState>;
}

/// @nodoc
class _$GiftBrowseStateCopyWithImpl<$Res, $Val extends GiftBrowseState>
    implements $GiftBrowseStateCopyWith<$Res> {
  _$GiftBrowseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftBrowseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BrowseInitialImplCopyWith<$Res> {
  factory _$$BrowseInitialImplCopyWith(
          _$BrowseInitialImpl value, $Res Function(_$BrowseInitialImpl) then) =
      __$$BrowseInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BrowseInitialImplCopyWithImpl<$Res>
    extends _$GiftBrowseStateCopyWithImpl<$Res, _$BrowseInitialImpl>
    implements _$$BrowseInitialImplCopyWith<$Res> {
  __$$BrowseInitialImplCopyWithImpl(
      _$BrowseInitialImpl _value, $Res Function(_$BrowseInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftBrowseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BrowseInitialImpl implements _BrowseInitial {
  const _$BrowseInitialImpl();

  @override
  String toString() {
    return 'GiftBrowseState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BrowseInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
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
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    required TResult Function(_BrowseInitial value) initial,
    required TResult Function(_BrowseLoading value) loading,
    required TResult Function(_BrowseLoaded value) loaded,
    required TResult Function(_BrowseError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BrowseInitial value)? initial,
    TResult? Function(_BrowseLoading value)? loading,
    TResult? Function(_BrowseLoaded value)? loaded,
    TResult? Function(_BrowseError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BrowseInitial value)? initial,
    TResult Function(_BrowseLoading value)? loading,
    TResult Function(_BrowseLoaded value)? loaded,
    TResult Function(_BrowseError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _BrowseInitial implements GiftBrowseState {
  const factory _BrowseInitial() = _$BrowseInitialImpl;
}

/// @nodoc
abstract class _$$BrowseLoadingImplCopyWith<$Res> {
  factory _$$BrowseLoadingImplCopyWith(
          _$BrowseLoadingImpl value, $Res Function(_$BrowseLoadingImpl) then) =
      __$$BrowseLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BrowseLoadingImplCopyWithImpl<$Res>
    extends _$GiftBrowseStateCopyWithImpl<$Res, _$BrowseLoadingImpl>
    implements _$$BrowseLoadingImplCopyWith<$Res> {
  __$$BrowseLoadingImplCopyWithImpl(
      _$BrowseLoadingImpl _value, $Res Function(_$BrowseLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftBrowseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BrowseLoadingImpl implements _BrowseLoading {
  const _$BrowseLoadingImpl();

  @override
  String toString() {
    return 'GiftBrowseState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BrowseLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
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
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    required TResult Function(_BrowseInitial value) initial,
    required TResult Function(_BrowseLoading value) loading,
    required TResult Function(_BrowseLoaded value) loaded,
    required TResult Function(_BrowseError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BrowseInitial value)? initial,
    TResult? Function(_BrowseLoading value)? loading,
    TResult? Function(_BrowseLoaded value)? loaded,
    TResult? Function(_BrowseError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BrowseInitial value)? initial,
    TResult Function(_BrowseLoading value)? loading,
    TResult Function(_BrowseLoaded value)? loaded,
    TResult Function(_BrowseError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _BrowseLoading implements GiftBrowseState {
  const factory _BrowseLoading() = _$BrowseLoadingImpl;
}

/// @nodoc
abstract class _$$BrowseLoadedImplCopyWith<$Res> {
  factory _$$BrowseLoadedImplCopyWith(
          _$BrowseLoadedImpl value, $Res Function(_$BrowseLoadedImpl) then) =
      __$$BrowseLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<GiftRecommendationEntity> gifts,
      bool hasMore,
      int currentPage,
      bool isLoadingMore});
}

/// @nodoc
class __$$BrowseLoadedImplCopyWithImpl<$Res>
    extends _$GiftBrowseStateCopyWithImpl<$Res, _$BrowseLoadedImpl>
    implements _$$BrowseLoadedImplCopyWith<$Res> {
  __$$BrowseLoadedImplCopyWithImpl(
      _$BrowseLoadedImpl _value, $Res Function(_$BrowseLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftBrowseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gifts = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? isLoadingMore = null,
  }) {
    return _then(_$BrowseLoadedImpl(
      gifts: null == gifts
          ? _value._gifts
          : gifts // ignore: cast_nullable_to_non_nullable
              as List<GiftRecommendationEntity>,
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

class _$BrowseLoadedImpl implements _BrowseLoaded {
  const _$BrowseLoadedImpl(
      {required final List<GiftRecommendationEntity> gifts,
      required this.hasMore,
      required this.currentPage,
      this.isLoadingMore = false})
      : _gifts = gifts;

  final List<GiftRecommendationEntity> _gifts;
  @override
  List<GiftRecommendationEntity> get gifts {
    if (_gifts is EqualUnmodifiableListView) return _gifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gifts);
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
    return 'GiftBrowseState.loaded(gifts: $gifts, hasMore: $hasMore, currentPage: $currentPage, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowseLoadedImpl &&
            const DeepCollectionEquality().equals(other._gifts, _gifts) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_gifts),
      hasMore,
      currentPage,
      isLoadingMore);

  /// Create a copy of GiftBrowseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowseLoadedImplCopyWith<_$BrowseLoadedImpl> get copyWith =>
      __$$BrowseLoadedImplCopyWithImpl<_$BrowseLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
            bool hasMore, int currentPage, bool isLoadingMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(gifts, hasMore, currentPage, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(gifts, hasMore, currentPage, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(gifts, hasMore, currentPage, isLoadingMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BrowseInitial value) initial,
    required TResult Function(_BrowseLoading value) loading,
    required TResult Function(_BrowseLoaded value) loaded,
    required TResult Function(_BrowseError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BrowseInitial value)? initial,
    TResult? Function(_BrowseLoading value)? loading,
    TResult? Function(_BrowseLoaded value)? loaded,
    TResult? Function(_BrowseError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BrowseInitial value)? initial,
    TResult Function(_BrowseLoading value)? loading,
    TResult Function(_BrowseLoaded value)? loaded,
    TResult Function(_BrowseError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _BrowseLoaded implements GiftBrowseState {
  const factory _BrowseLoaded(
      {required final List<GiftRecommendationEntity> gifts,
      required final bool hasMore,
      required final int currentPage,
      final bool isLoadingMore}) = _$BrowseLoadedImpl;

  List<GiftRecommendationEntity> get gifts;
  bool get hasMore;
  int get currentPage;
  bool get isLoadingMore;

  /// Create a copy of GiftBrowseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowseLoadedImplCopyWith<_$BrowseLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BrowseErrorImplCopyWith<$Res> {
  factory _$$BrowseErrorImplCopyWith(
          _$BrowseErrorImpl value, $Res Function(_$BrowseErrorImpl) then) =
      __$$BrowseErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BrowseErrorImplCopyWithImpl<$Res>
    extends _$GiftBrowseStateCopyWithImpl<$Res, _$BrowseErrorImpl>
    implements _$$BrowseErrorImplCopyWith<$Res> {
  __$$BrowseErrorImplCopyWithImpl(
      _$BrowseErrorImpl _value, $Res Function(_$BrowseErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftBrowseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$BrowseErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BrowseErrorImpl implements _BrowseError {
  const _$BrowseErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'GiftBrowseState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowseErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of GiftBrowseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowseErrorImplCopyWith<_$BrowseErrorImpl> get copyWith =>
      __$$BrowseErrorImplCopyWithImpl<_$BrowseErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
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
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    required TResult Function(_BrowseInitial value) initial,
    required TResult Function(_BrowseLoading value) loading,
    required TResult Function(_BrowseLoaded value) loaded,
    required TResult Function(_BrowseError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BrowseInitial value)? initial,
    TResult? Function(_BrowseLoading value)? loading,
    TResult? Function(_BrowseLoaded value)? loaded,
    TResult? Function(_BrowseError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BrowseInitial value)? initial,
    TResult Function(_BrowseLoading value)? loading,
    TResult Function(_BrowseLoaded value)? loaded,
    TResult Function(_BrowseError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _BrowseError implements GiftBrowseState {
  const factory _BrowseError({required final String message}) =
      _$BrowseErrorImpl;

  String get message;

  /// Create a copy of GiftBrowseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowseErrorImplCopyWith<_$BrowseErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GiftDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DetailLoading value) loading,
    required TResult Function(_DetailLoaded value) loaded,
    required TResult Function(_DetailError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DetailLoading value)? loading,
    TResult? Function(_DetailLoaded value)? loaded,
    TResult? Function(_DetailError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DetailLoading value)? loading,
    TResult Function(_DetailLoaded value)? loaded,
    TResult Function(_DetailError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftDetailStateCopyWith<$Res> {
  factory $GiftDetailStateCopyWith(
          GiftDetailState value, $Res Function(GiftDetailState) then) =
      _$GiftDetailStateCopyWithImpl<$Res, GiftDetailState>;
}

/// @nodoc
class _$GiftDetailStateCopyWithImpl<$Res, $Val extends GiftDetailState>
    implements $GiftDetailStateCopyWith<$Res> {
  _$GiftDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DetailLoadingImplCopyWith<$Res> {
  factory _$$DetailLoadingImplCopyWith(
          _$DetailLoadingImpl value, $Res Function(_$DetailLoadingImpl) then) =
      __$$DetailLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DetailLoadingImplCopyWithImpl<$Res>
    extends _$GiftDetailStateCopyWithImpl<$Res, _$DetailLoadingImpl>
    implements _$$DetailLoadingImplCopyWith<$Res> {
  __$$DetailLoadingImplCopyWithImpl(
      _$DetailLoadingImpl _value, $Res Function(_$DetailLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DetailLoadingImpl implements _DetailLoading {
  const _$DetailLoadingImpl();

  @override
  String toString() {
    return 'GiftDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DetailLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)?
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
    required TResult Function(_DetailLoading value) loading,
    required TResult Function(_DetailLoaded value) loaded,
    required TResult Function(_DetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DetailLoading value)? loading,
    TResult? Function(_DetailLoaded value)? loaded,
    TResult? Function(_DetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DetailLoading value)? loading,
    TResult Function(_DetailLoaded value)? loaded,
    TResult Function(_DetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _DetailLoading implements GiftDetailState {
  const factory _DetailLoading() = _$DetailLoadingImpl;
}

/// @nodoc
abstract class _$$DetailLoadedImplCopyWith<$Res> {
  factory _$$DetailLoadedImplCopyWith(
          _$DetailLoadedImpl value, $Res Function(_$DetailLoadedImpl) then) =
      __$$DetailLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {GiftRecommendationEntity gift,
      List<GiftRecommendationEntity> relatedGifts});

  $GiftRecommendationEntityCopyWith<$Res> get gift;
}

/// @nodoc
class __$$DetailLoadedImplCopyWithImpl<$Res>
    extends _$GiftDetailStateCopyWithImpl<$Res, _$DetailLoadedImpl>
    implements _$$DetailLoadedImplCopyWith<$Res> {
  __$$DetailLoadedImplCopyWithImpl(
      _$DetailLoadedImpl _value, $Res Function(_$DetailLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gift = null,
    Object? relatedGifts = null,
  }) {
    return _then(_$DetailLoadedImpl(
      gift: null == gift
          ? _value.gift
          : gift // ignore: cast_nullable_to_non_nullable
              as GiftRecommendationEntity,
      relatedGifts: null == relatedGifts
          ? _value._relatedGifts
          : relatedGifts // ignore: cast_nullable_to_non_nullable
              as List<GiftRecommendationEntity>,
    ));
  }

  /// Create a copy of GiftDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GiftRecommendationEntityCopyWith<$Res> get gift {
    return $GiftRecommendationEntityCopyWith<$Res>(_value.gift, (value) {
      return _then(_value.copyWith(gift: value));
    });
  }
}

/// @nodoc

class _$DetailLoadedImpl implements _DetailLoaded {
  const _$DetailLoadedImpl(
      {required this.gift,
      required final List<GiftRecommendationEntity> relatedGifts})
      : _relatedGifts = relatedGifts;

  @override
  final GiftRecommendationEntity gift;
  final List<GiftRecommendationEntity> _relatedGifts;
  @override
  List<GiftRecommendationEntity> get relatedGifts {
    if (_relatedGifts is EqualUnmodifiableListView) return _relatedGifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedGifts);
  }

  @override
  String toString() {
    return 'GiftDetailState.loaded(gift: $gift, relatedGifts: $relatedGifts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailLoadedImpl &&
            (identical(other.gift, gift) || other.gift == gift) &&
            const DeepCollectionEquality()
                .equals(other._relatedGifts, _relatedGifts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, gift, const DeepCollectionEquality().hash(_relatedGifts));

  /// Create a copy of GiftDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailLoadedImplCopyWith<_$DetailLoadedImpl> get copyWith =>
      __$$DetailLoadedImplCopyWithImpl<_$DetailLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(gift, relatedGifts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(gift, relatedGifts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(gift, relatedGifts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DetailLoading value) loading,
    required TResult Function(_DetailLoaded value) loaded,
    required TResult Function(_DetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DetailLoading value)? loading,
    TResult? Function(_DetailLoaded value)? loaded,
    TResult? Function(_DetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DetailLoading value)? loading,
    TResult Function(_DetailLoaded value)? loaded,
    TResult Function(_DetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _DetailLoaded implements GiftDetailState {
  const factory _DetailLoaded(
          {required final GiftRecommendationEntity gift,
          required final List<GiftRecommendationEntity> relatedGifts}) =
      _$DetailLoadedImpl;

  GiftRecommendationEntity get gift;
  List<GiftRecommendationEntity> get relatedGifts;

  /// Create a copy of GiftDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailLoadedImplCopyWith<_$DetailLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DetailErrorImplCopyWith<$Res> {
  factory _$$DetailErrorImplCopyWith(
          _$DetailErrorImpl value, $Res Function(_$DetailErrorImpl) then) =
      __$$DetailErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$DetailErrorImplCopyWithImpl<$Res>
    extends _$GiftDetailStateCopyWithImpl<$Res, _$DetailErrorImpl>
    implements _$$DetailErrorImplCopyWith<$Res> {
  __$$DetailErrorImplCopyWithImpl(
      _$DetailErrorImpl _value, $Res Function(_$DetailErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$DetailErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DetailErrorImpl implements _DetailError {
  const _$DetailErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'GiftDetailState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of GiftDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailErrorImplCopyWith<_$DetailErrorImpl> get copyWith =>
      __$$DetailErrorImplCopyWithImpl<_$DetailErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(GiftRecommendationEntity gift,
            List<GiftRecommendationEntity> relatedGifts)?
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
    required TResult Function(_DetailLoading value) loading,
    required TResult Function(_DetailLoaded value) loaded,
    required TResult Function(_DetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DetailLoading value)? loading,
    TResult? Function(_DetailLoaded value)? loaded,
    TResult? Function(_DetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DetailLoading value)? loading,
    TResult Function(_DetailLoaded value)? loaded,
    TResult Function(_DetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _DetailError implements GiftDetailState {
  const factory _DetailError({required final String message}) =
      _$DetailErrorImpl;

  String get message;

  /// Create a copy of GiftDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetailErrorImplCopyWith<_$DetailErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GiftHistoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
            bool hasMore, int currentPage, bool isLoadingMore)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HistInitial value) initial,
    required TResult Function(_HistLoading value) loading,
    required TResult Function(_HistLoaded value) loaded,
    required TResult Function(_HistError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistInitial value)? initial,
    TResult? Function(_HistLoading value)? loading,
    TResult? Function(_HistLoaded value)? loaded,
    TResult? Function(_HistError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistInitial value)? initial,
    TResult Function(_HistLoading value)? loading,
    TResult Function(_HistLoaded value)? loaded,
    TResult Function(_HistError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftHistoryStateCopyWith<$Res> {
  factory $GiftHistoryStateCopyWith(
          GiftHistoryState value, $Res Function(GiftHistoryState) then) =
      _$GiftHistoryStateCopyWithImpl<$Res, GiftHistoryState>;
}

/// @nodoc
class _$GiftHistoryStateCopyWithImpl<$Res, $Val extends GiftHistoryState>
    implements $GiftHistoryStateCopyWith<$Res> {
  _$GiftHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftHistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HistInitialImplCopyWith<$Res> {
  factory _$$HistInitialImplCopyWith(
          _$HistInitialImpl value, $Res Function(_$HistInitialImpl) then) =
      __$$HistInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HistInitialImplCopyWithImpl<$Res>
    extends _$GiftHistoryStateCopyWithImpl<$Res, _$HistInitialImpl>
    implements _$$HistInitialImplCopyWith<$Res> {
  __$$HistInitialImplCopyWithImpl(
      _$HistInitialImpl _value, $Res Function(_$HistInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftHistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HistInitialImpl implements _HistInitial {
  const _$HistInitialImpl();

  @override
  String toString() {
    return 'GiftHistoryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HistInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
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
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    required TResult Function(_HistInitial value) initial,
    required TResult Function(_HistLoading value) loading,
    required TResult Function(_HistLoaded value) loaded,
    required TResult Function(_HistError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistInitial value)? initial,
    TResult? Function(_HistLoading value)? loading,
    TResult? Function(_HistLoaded value)? loaded,
    TResult? Function(_HistError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistInitial value)? initial,
    TResult Function(_HistLoading value)? loading,
    TResult Function(_HistLoaded value)? loaded,
    TResult Function(_HistError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _HistInitial implements GiftHistoryState {
  const factory _HistInitial() = _$HistInitialImpl;
}

/// @nodoc
abstract class _$$HistLoadingImplCopyWith<$Res> {
  factory _$$HistLoadingImplCopyWith(
          _$HistLoadingImpl value, $Res Function(_$HistLoadingImpl) then) =
      __$$HistLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HistLoadingImplCopyWithImpl<$Res>
    extends _$GiftHistoryStateCopyWithImpl<$Res, _$HistLoadingImpl>
    implements _$$HistLoadingImplCopyWith<$Res> {
  __$$HistLoadingImplCopyWithImpl(
      _$HistLoadingImpl _value, $Res Function(_$HistLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftHistoryState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HistLoadingImpl implements _HistLoading {
  const _$HistLoadingImpl();

  @override
  String toString() {
    return 'GiftHistoryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HistLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
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
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    required TResult Function(_HistInitial value) initial,
    required TResult Function(_HistLoading value) loading,
    required TResult Function(_HistLoaded value) loaded,
    required TResult Function(_HistError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistInitial value)? initial,
    TResult? Function(_HistLoading value)? loading,
    TResult? Function(_HistLoaded value)? loaded,
    TResult? Function(_HistError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistInitial value)? initial,
    TResult Function(_HistLoading value)? loading,
    TResult Function(_HistLoaded value)? loaded,
    TResult Function(_HistError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _HistLoading implements GiftHistoryState {
  const factory _HistLoading() = _$HistLoadingImpl;
}

/// @nodoc
abstract class _$$HistLoadedImplCopyWith<$Res> {
  factory _$$HistLoadedImplCopyWith(
          _$HistLoadedImpl value, $Res Function(_$HistLoadedImpl) then) =
      __$$HistLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<GiftRecommendationEntity> gifts,
      bool hasMore,
      int currentPage,
      bool isLoadingMore});
}

/// @nodoc
class __$$HistLoadedImplCopyWithImpl<$Res>
    extends _$GiftHistoryStateCopyWithImpl<$Res, _$HistLoadedImpl>
    implements _$$HistLoadedImplCopyWith<$Res> {
  __$$HistLoadedImplCopyWithImpl(
      _$HistLoadedImpl _value, $Res Function(_$HistLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gifts = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? isLoadingMore = null,
  }) {
    return _then(_$HistLoadedImpl(
      gifts: null == gifts
          ? _value._gifts
          : gifts // ignore: cast_nullable_to_non_nullable
              as List<GiftRecommendationEntity>,
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

class _$HistLoadedImpl implements _HistLoaded {
  const _$HistLoadedImpl(
      {required final List<GiftRecommendationEntity> gifts,
      required this.hasMore,
      required this.currentPage,
      this.isLoadingMore = false})
      : _gifts = gifts;

  final List<GiftRecommendationEntity> _gifts;
  @override
  List<GiftRecommendationEntity> get gifts {
    if (_gifts is EqualUnmodifiableListView) return _gifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gifts);
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
    return 'GiftHistoryState.loaded(gifts: $gifts, hasMore: $hasMore, currentPage: $currentPage, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistLoadedImpl &&
            const DeepCollectionEquality().equals(other._gifts, _gifts) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_gifts),
      hasMore,
      currentPage,
      isLoadingMore);

  /// Create a copy of GiftHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistLoadedImplCopyWith<_$HistLoadedImpl> get copyWith =>
      __$$HistLoadedImplCopyWithImpl<_$HistLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
            bool hasMore, int currentPage, bool isLoadingMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(gifts, hasMore, currentPage, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(gifts, hasMore, currentPage, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
            int currentPage, bool isLoadingMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(gifts, hasMore, currentPage, isLoadingMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HistInitial value) initial,
    required TResult Function(_HistLoading value) loading,
    required TResult Function(_HistLoaded value) loaded,
    required TResult Function(_HistError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistInitial value)? initial,
    TResult? Function(_HistLoading value)? loading,
    TResult? Function(_HistLoaded value)? loaded,
    TResult? Function(_HistError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistInitial value)? initial,
    TResult Function(_HistLoading value)? loading,
    TResult Function(_HistLoaded value)? loaded,
    TResult Function(_HistError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _HistLoaded implements GiftHistoryState {
  const factory _HistLoaded(
      {required final List<GiftRecommendationEntity> gifts,
      required final bool hasMore,
      required final int currentPage,
      final bool isLoadingMore}) = _$HistLoadedImpl;

  List<GiftRecommendationEntity> get gifts;
  bool get hasMore;
  int get currentPage;
  bool get isLoadingMore;

  /// Create a copy of GiftHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistLoadedImplCopyWith<_$HistLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HistErrorImplCopyWith<$Res> {
  factory _$$HistErrorImplCopyWith(
          _$HistErrorImpl value, $Res Function(_$HistErrorImpl) then) =
      __$$HistErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$HistErrorImplCopyWithImpl<$Res>
    extends _$GiftHistoryStateCopyWithImpl<$Res, _$HistErrorImpl>
    implements _$$HistErrorImplCopyWith<$Res> {
  __$$HistErrorImplCopyWithImpl(
      _$HistErrorImpl _value, $Res Function(_$HistErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$HistErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HistErrorImpl implements _HistError {
  const _$HistErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'GiftHistoryState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of GiftHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistErrorImplCopyWith<_$HistErrorImpl> get copyWith =>
      __$$HistErrorImplCopyWithImpl<_$HistErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<GiftRecommendationEntity> gifts,
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
    TResult? Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    TResult Function(List<GiftRecommendationEntity> gifts, bool hasMore,
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
    required TResult Function(_HistInitial value) initial,
    required TResult Function(_HistLoading value) loading,
    required TResult Function(_HistLoaded value) loaded,
    required TResult Function(_HistError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HistInitial value)? initial,
    TResult? Function(_HistLoading value)? loading,
    TResult? Function(_HistLoaded value)? loaded,
    TResult? Function(_HistError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HistInitial value)? initial,
    TResult Function(_HistLoading value)? loading,
    TResult Function(_HistLoaded value)? loaded,
    TResult Function(_HistError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _HistError implements GiftHistoryState {
  const factory _HistError({required final String message}) = _$HistErrorImpl;

  String get message;

  /// Create a copy of GiftHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistErrorImplCopyWith<_$HistErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
