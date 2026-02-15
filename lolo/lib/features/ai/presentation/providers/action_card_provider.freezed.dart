// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_card_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActionCardsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ActionCard> cards, ActionCardSummary summary)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ActionCard> cards, ActionCardSummary summary)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ActionCard> cards, ActionCardSummary summary)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CardsLoading value) loading,
    required TResult Function(_CardsLoaded value) loaded,
    required TResult Function(_CardsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CardsLoading value)? loading,
    TResult? Function(_CardsLoaded value)? loaded,
    TResult? Function(_CardsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CardsLoading value)? loading,
    TResult Function(_CardsLoaded value)? loaded,
    TResult Function(_CardsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionCardsStateCopyWith<$Res> {
  factory $ActionCardsStateCopyWith(
          ActionCardsState value, $Res Function(ActionCardsState) then) =
      _$ActionCardsStateCopyWithImpl<$Res, ActionCardsState>;
}

/// @nodoc
class _$ActionCardsStateCopyWithImpl<$Res, $Val extends ActionCardsState>
    implements $ActionCardsStateCopyWith<$Res> {
  _$ActionCardsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionCardsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CardsLoadingImplCopyWith<$Res> {
  factory _$$CardsLoadingImplCopyWith(
          _$CardsLoadingImpl value, $Res Function(_$CardsLoadingImpl) then) =
      __$$CardsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CardsLoadingImplCopyWithImpl<$Res>
    extends _$ActionCardsStateCopyWithImpl<$Res, _$CardsLoadingImpl>
    implements _$$CardsLoadingImplCopyWith<$Res> {
  __$$CardsLoadingImplCopyWithImpl(
      _$CardsLoadingImpl _value, $Res Function(_$CardsLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionCardsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CardsLoadingImpl implements _CardsLoading {
  const _$CardsLoadingImpl();

  @override
  String toString() {
    return 'ActionCardsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CardsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ActionCard> cards, ActionCardSummary summary)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ActionCard> cards, ActionCardSummary summary)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ActionCard> cards, ActionCardSummary summary)? loaded,
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
    required TResult Function(_CardsLoading value) loading,
    required TResult Function(_CardsLoaded value) loaded,
    required TResult Function(_CardsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CardsLoading value)? loading,
    TResult? Function(_CardsLoaded value)? loaded,
    TResult? Function(_CardsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CardsLoading value)? loading,
    TResult Function(_CardsLoaded value)? loaded,
    TResult Function(_CardsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _CardsLoading implements ActionCardsState {
  const factory _CardsLoading() = _$CardsLoadingImpl;
}

/// @nodoc
abstract class _$$CardsLoadedImplCopyWith<$Res> {
  factory _$$CardsLoadedImplCopyWith(
          _$CardsLoadedImpl value, $Res Function(_$CardsLoadedImpl) then) =
      __$$CardsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ActionCard> cards, ActionCardSummary summary});

  $ActionCardSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$CardsLoadedImplCopyWithImpl<$Res>
    extends _$ActionCardsStateCopyWithImpl<$Res, _$CardsLoadedImpl>
    implements _$$CardsLoadedImplCopyWith<$Res> {
  __$$CardsLoadedImplCopyWithImpl(
      _$CardsLoadedImpl _value, $Res Function(_$CardsLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionCardsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? summary = null,
  }) {
    return _then(_$CardsLoadedImpl(
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<ActionCard>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ActionCardSummary,
    ));
  }

  /// Create a copy of ActionCardsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActionCardSummaryCopyWith<$Res> get summary {
    return $ActionCardSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value));
    });
  }
}

/// @nodoc

class _$CardsLoadedImpl implements _CardsLoaded {
  const _$CardsLoadedImpl(
      {required final List<ActionCard> cards, required this.summary})
      : _cards = cards;

  final List<ActionCard> _cards;
  @override
  List<ActionCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final ActionCardSummary summary;

  @override
  String toString() {
    return 'ActionCardsState.loaded(cards: $cards, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardsLoadedImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cards), summary);

  /// Create a copy of ActionCardsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardsLoadedImplCopyWith<_$CardsLoadedImpl> get copyWith =>
      __$$CardsLoadedImplCopyWithImpl<_$CardsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ActionCard> cards, ActionCardSummary summary)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(cards, summary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ActionCard> cards, ActionCardSummary summary)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(cards, summary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ActionCard> cards, ActionCardSummary summary)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cards, summary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CardsLoading value) loading,
    required TResult Function(_CardsLoaded value) loaded,
    required TResult Function(_CardsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CardsLoading value)? loading,
    TResult? Function(_CardsLoaded value)? loaded,
    TResult? Function(_CardsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CardsLoading value)? loading,
    TResult Function(_CardsLoaded value)? loaded,
    TResult Function(_CardsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _CardsLoaded implements ActionCardsState {
  const factory _CardsLoaded(
      {required final List<ActionCard> cards,
      required final ActionCardSummary summary}) = _$CardsLoadedImpl;

  List<ActionCard> get cards;
  ActionCardSummary get summary;

  /// Create a copy of ActionCardsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardsLoadedImplCopyWith<_$CardsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CardsErrorImplCopyWith<$Res> {
  factory _$$CardsErrorImplCopyWith(
          _$CardsErrorImpl value, $Res Function(_$CardsErrorImpl) then) =
      __$$CardsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CardsErrorImplCopyWithImpl<$Res>
    extends _$ActionCardsStateCopyWithImpl<$Res, _$CardsErrorImpl>
    implements _$$CardsErrorImplCopyWith<$Res> {
  __$$CardsErrorImplCopyWithImpl(
      _$CardsErrorImpl _value, $Res Function(_$CardsErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionCardsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CardsErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CardsErrorImpl implements _CardsError {
  const _$CardsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ActionCardsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ActionCardsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardsErrorImplCopyWith<_$CardsErrorImpl> get copyWith =>
      __$$CardsErrorImplCopyWithImpl<_$CardsErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ActionCard> cards, ActionCardSummary summary)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ActionCard> cards, ActionCardSummary summary)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ActionCard> cards, ActionCardSummary summary)? loaded,
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
    required TResult Function(_CardsLoading value) loading,
    required TResult Function(_CardsLoaded value) loaded,
    required TResult Function(_CardsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CardsLoading value)? loading,
    TResult? Function(_CardsLoaded value)? loaded,
    TResult? Function(_CardsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CardsLoading value)? loading,
    TResult Function(_CardsLoaded value)? loaded,
    TResult Function(_CardsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _CardsError implements ActionCardsState {
  const factory _CardsError(final String message) = _$CardsErrorImpl;

  String get message;

  /// Create a copy of ActionCardsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardsErrorImplCopyWith<_$CardsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
