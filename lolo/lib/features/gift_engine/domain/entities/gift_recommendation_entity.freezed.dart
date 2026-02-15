// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_recommendation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GiftRecommendationEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get priceRange => throw _privateConstructorUsedError;
  GiftCategory get category => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get whySheLoveIt => throw _privateConstructorUsedError;
  List<String> get matchedTraits => throw _privateConstructorUsedError;
  String? get buyUrl => throw _privateConstructorUsedError;
  bool get isSaved => throw _privateConstructorUsedError;
  bool get isLowBudget => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// null = no feedback, true = liked, false = disliked
  bool? get feedback => throw _privateConstructorUsedError;
  String? get learningNote => throw _privateConstructorUsedError;

  /// Create a copy of GiftRecommendationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftRecommendationEntityCopyWith<GiftRecommendationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftRecommendationEntityCopyWith<$Res> {
  factory $GiftRecommendationEntityCopyWith(GiftRecommendationEntity value,
          $Res Function(GiftRecommendationEntity) then) =
      _$GiftRecommendationEntityCopyWithImpl<$Res, GiftRecommendationEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String priceRange,
      GiftCategory category,
      String? imageUrl,
      String? whySheLoveIt,
      List<String> matchedTraits,
      String? buyUrl,
      bool isSaved,
      bool isLowBudget,
      DateTime? createdAt,
      bool? feedback,
      String? learningNote});
}

/// @nodoc
class _$GiftRecommendationEntityCopyWithImpl<$Res,
        $Val extends GiftRecommendationEntity>
    implements $GiftRecommendationEntityCopyWith<$Res> {
  _$GiftRecommendationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftRecommendationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? priceRange = null,
    Object? category = null,
    Object? imageUrl = freezed,
    Object? whySheLoveIt = freezed,
    Object? matchedTraits = null,
    Object? buyUrl = freezed,
    Object? isSaved = null,
    Object? isLowBudget = null,
    Object? createdAt = freezed,
    Object? feedback = freezed,
    Object? learningNote = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      priceRange: null == priceRange
          ? _value.priceRange
          : priceRange // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as GiftCategory,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      whySheLoveIt: freezed == whySheLoveIt
          ? _value.whySheLoveIt
          : whySheLoveIt // ignore: cast_nullable_to_non_nullable
              as String?,
      matchedTraits: null == matchedTraits
          ? _value.matchedTraits
          : matchedTraits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      buyUrl: freezed == buyUrl
          ? _value.buyUrl
          : buyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      isLowBudget: null == isLowBudget
          ? _value.isLowBudget
          : isLowBudget // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as bool?,
      learningNote: freezed == learningNote
          ? _value.learningNote
          : learningNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GiftRecommendationEntityImplCopyWith<$Res>
    implements $GiftRecommendationEntityCopyWith<$Res> {
  factory _$$GiftRecommendationEntityImplCopyWith(
          _$GiftRecommendationEntityImpl value,
          $Res Function(_$GiftRecommendationEntityImpl) then) =
      __$$GiftRecommendationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String priceRange,
      GiftCategory category,
      String? imageUrl,
      String? whySheLoveIt,
      List<String> matchedTraits,
      String? buyUrl,
      bool isSaved,
      bool isLowBudget,
      DateTime? createdAt,
      bool? feedback,
      String? learningNote});
}

/// @nodoc
class __$$GiftRecommendationEntityImplCopyWithImpl<$Res>
    extends _$GiftRecommendationEntityCopyWithImpl<$Res,
        _$GiftRecommendationEntityImpl>
    implements _$$GiftRecommendationEntityImplCopyWith<$Res> {
  __$$GiftRecommendationEntityImplCopyWithImpl(
      _$GiftRecommendationEntityImpl _value,
      $Res Function(_$GiftRecommendationEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftRecommendationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? priceRange = null,
    Object? category = null,
    Object? imageUrl = freezed,
    Object? whySheLoveIt = freezed,
    Object? matchedTraits = null,
    Object? buyUrl = freezed,
    Object? isSaved = null,
    Object? isLowBudget = null,
    Object? createdAt = freezed,
    Object? feedback = freezed,
    Object? learningNote = freezed,
  }) {
    return _then(_$GiftRecommendationEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      priceRange: null == priceRange
          ? _value.priceRange
          : priceRange // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as GiftCategory,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      whySheLoveIt: freezed == whySheLoveIt
          ? _value.whySheLoveIt
          : whySheLoveIt // ignore: cast_nullable_to_non_nullable
              as String?,
      matchedTraits: null == matchedTraits
          ? _value._matchedTraits
          : matchedTraits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      buyUrl: freezed == buyUrl
          ? _value.buyUrl
          : buyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      isLowBudget: null == isLowBudget
          ? _value.isLowBudget
          : isLowBudget // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as bool?,
      learningNote: freezed == learningNote
          ? _value.learningNote
          : learningNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GiftRecommendationEntityImpl implements _GiftRecommendationEntity {
  const _$GiftRecommendationEntityImpl(
      {required this.id,
      required this.name,
      required this.priceRange,
      required this.category,
      this.imageUrl,
      this.whySheLoveIt,
      final List<String> matchedTraits = const [],
      this.buyUrl,
      this.isSaved = false,
      this.isLowBudget = false,
      this.createdAt,
      this.feedback,
      this.learningNote})
      : _matchedTraits = matchedTraits;

  @override
  final String id;
  @override
  final String name;
  @override
  final String priceRange;
  @override
  final GiftCategory category;
  @override
  final String? imageUrl;
  @override
  final String? whySheLoveIt;
  final List<String> _matchedTraits;
  @override
  @JsonKey()
  List<String> get matchedTraits {
    if (_matchedTraits is EqualUnmodifiableListView) return _matchedTraits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matchedTraits);
  }

  @override
  final String? buyUrl;
  @override
  @JsonKey()
  final bool isSaved;
  @override
  @JsonKey()
  final bool isLowBudget;
  @override
  final DateTime? createdAt;

  /// null = no feedback, true = liked, false = disliked
  @override
  final bool? feedback;
  @override
  final String? learningNote;

  @override
  String toString() {
    return 'GiftRecommendationEntity(id: $id, name: $name, priceRange: $priceRange, category: $category, imageUrl: $imageUrl, whySheLoveIt: $whySheLoveIt, matchedTraits: $matchedTraits, buyUrl: $buyUrl, isSaved: $isSaved, isLowBudget: $isLowBudget, createdAt: $createdAt, feedback: $feedback, learningNote: $learningNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftRecommendationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.priceRange, priceRange) ||
                other.priceRange == priceRange) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.whySheLoveIt, whySheLoveIt) ||
                other.whySheLoveIt == whySheLoveIt) &&
            const DeepCollectionEquality()
                .equals(other._matchedTraits, _matchedTraits) &&
            (identical(other.buyUrl, buyUrl) || other.buyUrl == buyUrl) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.isLowBudget, isLowBudget) ||
                other.isLowBudget == isLowBudget) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.learningNote, learningNote) ||
                other.learningNote == learningNote));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      priceRange,
      category,
      imageUrl,
      whySheLoveIt,
      const DeepCollectionEquality().hash(_matchedTraits),
      buyUrl,
      isSaved,
      isLowBudget,
      createdAt,
      feedback,
      learningNote);

  /// Create a copy of GiftRecommendationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftRecommendationEntityImplCopyWith<_$GiftRecommendationEntityImpl>
      get copyWith => __$$GiftRecommendationEntityImplCopyWithImpl<
          _$GiftRecommendationEntityImpl>(this, _$identity);
}

abstract class _GiftRecommendationEntity implements GiftRecommendationEntity {
  const factory _GiftRecommendationEntity(
      {required final String id,
      required final String name,
      required final String priceRange,
      required final GiftCategory category,
      final String? imageUrl,
      final String? whySheLoveIt,
      final List<String> matchedTraits,
      final String? buyUrl,
      final bool isSaved,
      final bool isLowBudget,
      final DateTime? createdAt,
      final bool? feedback,
      final String? learningNote}) = _$GiftRecommendationEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get priceRange;
  @override
  GiftCategory get category;
  @override
  String? get imageUrl;
  @override
  String? get whySheLoveIt;
  @override
  List<String> get matchedTraits;
  @override
  String? get buyUrl;
  @override
  bool get isSaved;
  @override
  bool get isLowBudget;
  @override
  DateTime? get createdAt;

  /// null = no feedback, true = liked, false = disliked
  @override
  bool? get feedback;
  @override
  String? get learningNote;

  /// Create a copy of GiftRecommendationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftRecommendationEntityImplCopyWith<_$GiftRecommendationEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
