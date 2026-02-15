// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_card_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActionCardEntity {
  String get id => throw _privateConstructorUsedError;
  ActionCardType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ActionCardDifficulty get difficulty => throw _privateConstructorUsedError;
  int get estimatedMinutes => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  ActionCardStatus get status => throw _privateConstructorUsedError;
  List<String> get contextTags => throw _privateConstructorUsedError;
  String? get personalizedDetail => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Create a copy of ActionCardEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionCardEntityCopyWith<ActionCardEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionCardEntityCopyWith<$Res> {
  factory $ActionCardEntityCopyWith(
          ActionCardEntity value, $Res Function(ActionCardEntity) then) =
      _$ActionCardEntityCopyWithImpl<$Res, ActionCardEntity>;
  @useResult
  $Res call(
      {String id,
      ActionCardType type,
      String title,
      String description,
      ActionCardDifficulty difficulty,
      int estimatedMinutes,
      int xpReward,
      ActionCardStatus status,
      List<String> contextTags,
      String? personalizedDetail,
      DateTime? expiresAt,
      DateTime? completedAt});
}

/// @nodoc
class _$ActionCardEntityCopyWithImpl<$Res, $Val extends ActionCardEntity>
    implements $ActionCardEntityCopyWith<$Res> {
  _$ActionCardEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionCardEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? description = null,
    Object? difficulty = null,
    Object? estimatedMinutes = null,
    Object? xpReward = null,
    Object? status = null,
    Object? contextTags = null,
    Object? personalizedDetail = freezed,
    Object? expiresAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActionCardType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as ActionCardDifficulty,
      estimatedMinutes: null == estimatedMinutes
          ? _value.estimatedMinutes
          : estimatedMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActionCardStatus,
      contextTags: null == contextTags
          ? _value.contextTags
          : contextTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      personalizedDetail: freezed == personalizedDetail
          ? _value.personalizedDetail
          : personalizedDetail // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActionCardEntityImplCopyWith<$Res>
    implements $ActionCardEntityCopyWith<$Res> {
  factory _$$ActionCardEntityImplCopyWith(_$ActionCardEntityImpl value,
          $Res Function(_$ActionCardEntityImpl) then) =
      __$$ActionCardEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ActionCardType type,
      String title,
      String description,
      ActionCardDifficulty difficulty,
      int estimatedMinutes,
      int xpReward,
      ActionCardStatus status,
      List<String> contextTags,
      String? personalizedDetail,
      DateTime? expiresAt,
      DateTime? completedAt});
}

/// @nodoc
class __$$ActionCardEntityImplCopyWithImpl<$Res>
    extends _$ActionCardEntityCopyWithImpl<$Res, _$ActionCardEntityImpl>
    implements _$$ActionCardEntityImplCopyWith<$Res> {
  __$$ActionCardEntityImplCopyWithImpl(_$ActionCardEntityImpl _value,
      $Res Function(_$ActionCardEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionCardEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? description = null,
    Object? difficulty = null,
    Object? estimatedMinutes = null,
    Object? xpReward = null,
    Object? status = null,
    Object? contextTags = null,
    Object? personalizedDetail = freezed,
    Object? expiresAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_$ActionCardEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActionCardType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as ActionCardDifficulty,
      estimatedMinutes: null == estimatedMinutes
          ? _value.estimatedMinutes
          : estimatedMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActionCardStatus,
      contextTags: null == contextTags
          ? _value._contextTags
          : contextTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      personalizedDetail: freezed == personalizedDetail
          ? _value.personalizedDetail
          : personalizedDetail // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ActionCardEntityImpl implements _ActionCardEntity {
  const _$ActionCardEntityImpl(
      {required this.id,
      required this.type,
      required this.title,
      required this.description,
      required this.difficulty,
      required this.estimatedMinutes,
      required this.xpReward,
      required this.status,
      final List<String> contextTags = const [],
      this.personalizedDetail,
      this.expiresAt,
      this.completedAt})
      : _contextTags = contextTags;

  @override
  final String id;
  @override
  final ActionCardType type;
  @override
  final String title;
  @override
  final String description;
  @override
  final ActionCardDifficulty difficulty;
  @override
  final int estimatedMinutes;
  @override
  final int xpReward;
  @override
  final ActionCardStatus status;
  final List<String> _contextTags;
  @override
  @JsonKey()
  List<String> get contextTags {
    if (_contextTags is EqualUnmodifiableListView) return _contextTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contextTags);
  }

  @override
  final String? personalizedDetail;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'ActionCardEntity(id: $id, type: $type, title: $title, description: $description, difficulty: $difficulty, estimatedMinutes: $estimatedMinutes, xpReward: $xpReward, status: $status, contextTags: $contextTags, personalizedDetail: $personalizedDetail, expiresAt: $expiresAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionCardEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._contextTags, _contextTags) &&
            (identical(other.personalizedDetail, personalizedDetail) ||
                other.personalizedDetail == personalizedDetail) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      title,
      description,
      difficulty,
      estimatedMinutes,
      xpReward,
      status,
      const DeepCollectionEquality().hash(_contextTags),
      personalizedDetail,
      expiresAt,
      completedAt);

  /// Create a copy of ActionCardEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionCardEntityImplCopyWith<_$ActionCardEntityImpl> get copyWith =>
      __$$ActionCardEntityImplCopyWithImpl<_$ActionCardEntityImpl>(
          this, _$identity);
}

abstract class _ActionCardEntity implements ActionCardEntity {
  const factory _ActionCardEntity(
      {required final String id,
      required final ActionCardType type,
      required final String title,
      required final String description,
      required final ActionCardDifficulty difficulty,
      required final int estimatedMinutes,
      required final int xpReward,
      required final ActionCardStatus status,
      final List<String> contextTags,
      final String? personalizedDetail,
      final DateTime? expiresAt,
      final DateTime? completedAt}) = _$ActionCardEntityImpl;

  @override
  String get id;
  @override
  ActionCardType get type;
  @override
  String get title;
  @override
  String get description;
  @override
  ActionCardDifficulty get difficulty;
  @override
  int get estimatedMinutes;
  @override
  int get xpReward;
  @override
  ActionCardStatus get status;
  @override
  List<String> get contextTags;
  @override
  String? get personalizedDetail;
  @override
  DateTime? get expiresAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of ActionCardEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionCardEntityImplCopyWith<_$ActionCardEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DailyCardsSummary {
  List<ActionCardEntity> get cards => throw _privateConstructorUsedError;
  int get totalCards => throw _privateConstructorUsedError;
  int get completedToday => throw _privateConstructorUsedError;
  int get totalXpAvailable => throw _privateConstructorUsedError;

  /// Create a copy of DailyCardsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyCardsSummaryCopyWith<DailyCardsSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyCardsSummaryCopyWith<$Res> {
  factory $DailyCardsSummaryCopyWith(
          DailyCardsSummary value, $Res Function(DailyCardsSummary) then) =
      _$DailyCardsSummaryCopyWithImpl<$Res, DailyCardsSummary>;
  @useResult
  $Res call(
      {List<ActionCardEntity> cards,
      int totalCards,
      int completedToday,
      int totalXpAvailable});
}

/// @nodoc
class _$DailyCardsSummaryCopyWithImpl<$Res, $Val extends DailyCardsSummary>
    implements $DailyCardsSummaryCopyWith<$Res> {
  _$DailyCardsSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyCardsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? totalCards = null,
    Object? completedToday = null,
    Object? totalXpAvailable = null,
  }) {
    return _then(_value.copyWith(
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<ActionCardEntity>,
      totalCards: null == totalCards
          ? _value.totalCards
          : totalCards // ignore: cast_nullable_to_non_nullable
              as int,
      completedToday: null == completedToday
          ? _value.completedToday
          : completedToday // ignore: cast_nullable_to_non_nullable
              as int,
      totalXpAvailable: null == totalXpAvailable
          ? _value.totalXpAvailable
          : totalXpAvailable // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyCardsSummaryImplCopyWith<$Res>
    implements $DailyCardsSummaryCopyWith<$Res> {
  factory _$$DailyCardsSummaryImplCopyWith(_$DailyCardsSummaryImpl value,
          $Res Function(_$DailyCardsSummaryImpl) then) =
      __$$DailyCardsSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ActionCardEntity> cards,
      int totalCards,
      int completedToday,
      int totalXpAvailable});
}

/// @nodoc
class __$$DailyCardsSummaryImplCopyWithImpl<$Res>
    extends _$DailyCardsSummaryCopyWithImpl<$Res, _$DailyCardsSummaryImpl>
    implements _$$DailyCardsSummaryImplCopyWith<$Res> {
  __$$DailyCardsSummaryImplCopyWithImpl(_$DailyCardsSummaryImpl _value,
      $Res Function(_$DailyCardsSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyCardsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? totalCards = null,
    Object? completedToday = null,
    Object? totalXpAvailable = null,
  }) {
    return _then(_$DailyCardsSummaryImpl(
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<ActionCardEntity>,
      totalCards: null == totalCards
          ? _value.totalCards
          : totalCards // ignore: cast_nullable_to_non_nullable
              as int,
      completedToday: null == completedToday
          ? _value.completedToday
          : completedToday // ignore: cast_nullable_to_non_nullable
              as int,
      totalXpAvailable: null == totalXpAvailable
          ? _value.totalXpAvailable
          : totalXpAvailable // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DailyCardsSummaryImpl implements _DailyCardsSummary {
  const _$DailyCardsSummaryImpl(
      {required final List<ActionCardEntity> cards,
      required this.totalCards,
      required this.completedToday,
      required this.totalXpAvailable})
      : _cards = cards;

  final List<ActionCardEntity> _cards;
  @override
  List<ActionCardEntity> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final int totalCards;
  @override
  final int completedToday;
  @override
  final int totalXpAvailable;

  @override
  String toString() {
    return 'DailyCardsSummary(cards: $cards, totalCards: $totalCards, completedToday: $completedToday, totalXpAvailable: $totalXpAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyCardsSummaryImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.totalCards, totalCards) ||
                other.totalCards == totalCards) &&
            (identical(other.completedToday, completedToday) ||
                other.completedToday == completedToday) &&
            (identical(other.totalXpAvailable, totalXpAvailable) ||
                other.totalXpAvailable == totalXpAvailable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_cards),
      totalCards,
      completedToday,
      totalXpAvailable);

  /// Create a copy of DailyCardsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyCardsSummaryImplCopyWith<_$DailyCardsSummaryImpl> get copyWith =>
      __$$DailyCardsSummaryImplCopyWithImpl<_$DailyCardsSummaryImpl>(
          this, _$identity);
}

abstract class _DailyCardsSummary implements DailyCardsSummary {
  const factory _DailyCardsSummary(
      {required final List<ActionCardEntity> cards,
      required final int totalCards,
      required final int completedToday,
      required final int totalXpAvailable}) = _$DailyCardsSummaryImpl;

  @override
  List<ActionCardEntity> get cards;
  @override
  int get totalCards;
  @override
  int get completedToday;
  @override
  int get totalXpAvailable;

  /// Create a copy of DailyCardsSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyCardsSummaryImplCopyWith<_$DailyCardsSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
