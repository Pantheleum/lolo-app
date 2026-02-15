// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PartnerProfileEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime? get birthday => throw _privateConstructorUsedError;
  String? get zodiacSign => throw _privateConstructorUsedError;
  ZodiacProfileEntity? get zodiacTraits => throw _privateConstructorUsedError;
  String? get loveLanguage => throw _privateConstructorUsedError;
  String? get communicationStyle => throw _privateConstructorUsedError;
  String get relationshipStatus => throw _privateConstructorUsedError;
  DateTime? get anniversaryDate => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  PartnerPreferencesEntity? get preferences =>
      throw _privateConstructorUsedError;
  CulturalContextEntity? get culturalContext =>
      throw _privateConstructorUsedError;
  int get profileCompletionPercent => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of PartnerProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerProfileEntityCopyWith<PartnerProfileEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerProfileEntityCopyWith<$Res> {
  factory $PartnerProfileEntityCopyWith(PartnerProfileEntity value,
          $Res Function(PartnerProfileEntity) then) =
      _$PartnerProfileEntityCopyWithImpl<$Res, PartnerProfileEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      DateTime? birthday,
      String? zodiacSign,
      ZodiacProfileEntity? zodiacTraits,
      String? loveLanguage,
      String? communicationStyle,
      String relationshipStatus,
      DateTime? anniversaryDate,
      String? photoUrl,
      PartnerPreferencesEntity? preferences,
      CulturalContextEntity? culturalContext,
      int profileCompletionPercent,
      DateTime createdAt,
      DateTime updatedAt});

  $ZodiacProfileEntityCopyWith<$Res>? get zodiacTraits;
  $PartnerPreferencesEntityCopyWith<$Res>? get preferences;
  $CulturalContextEntityCopyWith<$Res>? get culturalContext;
}

/// @nodoc
class _$PartnerProfileEntityCopyWithImpl<$Res,
        $Val extends PartnerProfileEntity>
    implements $PartnerProfileEntityCopyWith<$Res> {
  _$PartnerProfileEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartnerProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? birthday = freezed,
    Object? zodiacSign = freezed,
    Object? zodiacTraits = freezed,
    Object? loveLanguage = freezed,
    Object? communicationStyle = freezed,
    Object? relationshipStatus = null,
    Object? anniversaryDate = freezed,
    Object? photoUrl = freezed,
    Object? preferences = freezed,
    Object? culturalContext = freezed,
    Object? profileCompletionPercent = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      zodiacSign: freezed == zodiacSign
          ? _value.zodiacSign
          : zodiacSign // ignore: cast_nullable_to_non_nullable
              as String?,
      zodiacTraits: freezed == zodiacTraits
          ? _value.zodiacTraits
          : zodiacTraits // ignore: cast_nullable_to_non_nullable
              as ZodiacProfileEntity?,
      loveLanguage: freezed == loveLanguage
          ? _value.loveLanguage
          : loveLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      communicationStyle: freezed == communicationStyle
          ? _value.communicationStyle
          : communicationStyle // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipStatus: null == relationshipStatus
          ? _value.relationshipStatus
          : relationshipStatus // ignore: cast_nullable_to_non_nullable
              as String,
      anniversaryDate: freezed == anniversaryDate
          ? _value.anniversaryDate
          : anniversaryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as PartnerPreferencesEntity?,
      culturalContext: freezed == culturalContext
          ? _value.culturalContext
          : culturalContext // ignore: cast_nullable_to_non_nullable
              as CulturalContextEntity?,
      profileCompletionPercent: null == profileCompletionPercent
          ? _value.profileCompletionPercent
          : profileCompletionPercent // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of PartnerProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ZodiacProfileEntityCopyWith<$Res>? get zodiacTraits {
    if (_value.zodiacTraits == null) {
      return null;
    }

    return $ZodiacProfileEntityCopyWith<$Res>(_value.zodiacTraits!, (value) {
      return _then(_value.copyWith(zodiacTraits: value) as $Val);
    });
  }

  /// Create a copy of PartnerProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PartnerPreferencesEntityCopyWith<$Res>? get preferences {
    if (_value.preferences == null) {
      return null;
    }

    return $PartnerPreferencesEntityCopyWith<$Res>(_value.preferences!,
        (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }

  /// Create a copy of PartnerProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CulturalContextEntityCopyWith<$Res>? get culturalContext {
    if (_value.culturalContext == null) {
      return null;
    }

    return $CulturalContextEntityCopyWith<$Res>(_value.culturalContext!,
        (value) {
      return _then(_value.copyWith(culturalContext: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartnerProfileEntityImplCopyWith<$Res>
    implements $PartnerProfileEntityCopyWith<$Res> {
  factory _$$PartnerProfileEntityImplCopyWith(_$PartnerProfileEntityImpl value,
          $Res Function(_$PartnerProfileEntityImpl) then) =
      __$$PartnerProfileEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      DateTime? birthday,
      String? zodiacSign,
      ZodiacProfileEntity? zodiacTraits,
      String? loveLanguage,
      String? communicationStyle,
      String relationshipStatus,
      DateTime? anniversaryDate,
      String? photoUrl,
      PartnerPreferencesEntity? preferences,
      CulturalContextEntity? culturalContext,
      int profileCompletionPercent,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $ZodiacProfileEntityCopyWith<$Res>? get zodiacTraits;
  @override
  $PartnerPreferencesEntityCopyWith<$Res>? get preferences;
  @override
  $CulturalContextEntityCopyWith<$Res>? get culturalContext;
}

/// @nodoc
class __$$PartnerProfileEntityImplCopyWithImpl<$Res>
    extends _$PartnerProfileEntityCopyWithImpl<$Res, _$PartnerProfileEntityImpl>
    implements _$$PartnerProfileEntityImplCopyWith<$Res> {
  __$$PartnerProfileEntityImplCopyWithImpl(_$PartnerProfileEntityImpl _value,
      $Res Function(_$PartnerProfileEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartnerProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? birthday = freezed,
    Object? zodiacSign = freezed,
    Object? zodiacTraits = freezed,
    Object? loveLanguage = freezed,
    Object? communicationStyle = freezed,
    Object? relationshipStatus = null,
    Object? anniversaryDate = freezed,
    Object? photoUrl = freezed,
    Object? preferences = freezed,
    Object? culturalContext = freezed,
    Object? profileCompletionPercent = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$PartnerProfileEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      zodiacSign: freezed == zodiacSign
          ? _value.zodiacSign
          : zodiacSign // ignore: cast_nullable_to_non_nullable
              as String?,
      zodiacTraits: freezed == zodiacTraits
          ? _value.zodiacTraits
          : zodiacTraits // ignore: cast_nullable_to_non_nullable
              as ZodiacProfileEntity?,
      loveLanguage: freezed == loveLanguage
          ? _value.loveLanguage
          : loveLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      communicationStyle: freezed == communicationStyle
          ? _value.communicationStyle
          : communicationStyle // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipStatus: null == relationshipStatus
          ? _value.relationshipStatus
          : relationshipStatus // ignore: cast_nullable_to_non_nullable
              as String,
      anniversaryDate: freezed == anniversaryDate
          ? _value.anniversaryDate
          : anniversaryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as PartnerPreferencesEntity?,
      culturalContext: freezed == culturalContext
          ? _value.culturalContext
          : culturalContext // ignore: cast_nullable_to_non_nullable
              as CulturalContextEntity?,
      profileCompletionPercent: null == profileCompletionPercent
          ? _value.profileCompletionPercent
          : profileCompletionPercent // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$PartnerProfileEntityImpl extends _PartnerProfileEntity {
  const _$PartnerProfileEntityImpl(
      {required this.id,
      required this.userId,
      required this.name,
      this.birthday,
      this.zodiacSign,
      this.zodiacTraits,
      this.loveLanguage,
      this.communicationStyle,
      required this.relationshipStatus,
      this.anniversaryDate,
      this.photoUrl,
      this.preferences,
      this.culturalContext,
      this.profileCompletionPercent = 0,
      required this.createdAt,
      required this.updatedAt})
      : super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final DateTime? birthday;
  @override
  final String? zodiacSign;
  @override
  final ZodiacProfileEntity? zodiacTraits;
  @override
  final String? loveLanguage;
  @override
  final String? communicationStyle;
  @override
  final String relationshipStatus;
  @override
  final DateTime? anniversaryDate;
  @override
  final String? photoUrl;
  @override
  final PartnerPreferencesEntity? preferences;
  @override
  final CulturalContextEntity? culturalContext;
  @override
  @JsonKey()
  final int profileCompletionPercent;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PartnerProfileEntity(id: $id, userId: $userId, name: $name, birthday: $birthday, zodiacSign: $zodiacSign, zodiacTraits: $zodiacTraits, loveLanguage: $loveLanguage, communicationStyle: $communicationStyle, relationshipStatus: $relationshipStatus, anniversaryDate: $anniversaryDate, photoUrl: $photoUrl, preferences: $preferences, culturalContext: $culturalContext, profileCompletionPercent: $profileCompletionPercent, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerProfileEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.zodiacSign, zodiacSign) ||
                other.zodiacSign == zodiacSign) &&
            (identical(other.zodiacTraits, zodiacTraits) ||
                other.zodiacTraits == zodiacTraits) &&
            (identical(other.loveLanguage, loveLanguage) ||
                other.loveLanguage == loveLanguage) &&
            (identical(other.communicationStyle, communicationStyle) ||
                other.communicationStyle == communicationStyle) &&
            (identical(other.relationshipStatus, relationshipStatus) ||
                other.relationshipStatus == relationshipStatus) &&
            (identical(other.anniversaryDate, anniversaryDate) ||
                other.anniversaryDate == anniversaryDate) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            (identical(other.culturalContext, culturalContext) ||
                other.culturalContext == culturalContext) &&
            (identical(
                    other.profileCompletionPercent, profileCompletionPercent) ||
                other.profileCompletionPercent == profileCompletionPercent) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      birthday,
      zodiacSign,
      zodiacTraits,
      loveLanguage,
      communicationStyle,
      relationshipStatus,
      anniversaryDate,
      photoUrl,
      preferences,
      culturalContext,
      profileCompletionPercent,
      createdAt,
      updatedAt);

  /// Create a copy of PartnerProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerProfileEntityImplCopyWith<_$PartnerProfileEntityImpl>
      get copyWith =>
          __$$PartnerProfileEntityImplCopyWithImpl<_$PartnerProfileEntityImpl>(
              this, _$identity);
}

abstract class _PartnerProfileEntity extends PartnerProfileEntity {
  const factory _PartnerProfileEntity(
      {required final String id,
      required final String userId,
      required final String name,
      final DateTime? birthday,
      final String? zodiacSign,
      final ZodiacProfileEntity? zodiacTraits,
      final String? loveLanguage,
      final String? communicationStyle,
      required final String relationshipStatus,
      final DateTime? anniversaryDate,
      final String? photoUrl,
      final PartnerPreferencesEntity? preferences,
      final CulturalContextEntity? culturalContext,
      final int profileCompletionPercent,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$PartnerProfileEntityImpl;
  const _PartnerProfileEntity._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  DateTime? get birthday;
  @override
  String? get zodiacSign;
  @override
  ZodiacProfileEntity? get zodiacTraits;
  @override
  String? get loveLanguage;
  @override
  String? get communicationStyle;
  @override
  String get relationshipStatus;
  @override
  DateTime? get anniversaryDate;
  @override
  String? get photoUrl;
  @override
  PartnerPreferencesEntity? get preferences;
  @override
  CulturalContextEntity? get culturalContext;
  @override
  int get profileCompletionPercent;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of PartnerProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerProfileEntityImplCopyWith<_$PartnerProfileEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
