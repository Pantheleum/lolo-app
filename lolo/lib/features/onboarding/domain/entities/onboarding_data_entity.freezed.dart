// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_data_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnboardingDataEntity {
  /// User's preferred language, set on the very first screen.
  String get language => throw _privateConstructorUsedError;

  /// The user's display name (step 4).
  String? get userName => throw _privateConstructorUsedError;

  /// Partner's name (step 5).
  String? get partnerName => throw _privateConstructorUsedError;

  /// Partner's zodiac sign key, e.g. 'scorpio' (step 5).
  String? get partnerZodiac => throw _privateConstructorUsedError;

  /// Relationship status enum: dating, engaged, married (step 6).
  String? get relationshipStatus => throw _privateConstructorUsedError;

  /// The key date value -- anniversary or wedding date (step 7).
  DateTime? get keyDate => throw _privateConstructorUsedError;

  /// What [keyDate] represents: 'dating_anniversary' or 'wedding_date'.
  String? get keyDateType => throw _privateConstructorUsedError;

  /// Email for email/password sign-up (step 3).
  String? get email => throw _privateConstructorUsedError;

  /// Auth provider used: 'email', 'google', 'apple' (step 3).
  String? get authProvider => throw _privateConstructorUsedError;

  /// Firebase UID assigned after successful authentication (step 3).
  String? get firebaseUid => throw _privateConstructorUsedError;

  /// Current step index (0-7) for resume support.
  int get currentStep => throw _privateConstructorUsedError;

  /// Whether the entire flow has been submitted to the backend.
  bool get isComplete => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingDataEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingDataEntityCopyWith<OnboardingDataEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingDataEntityCopyWith<$Res> {
  factory $OnboardingDataEntityCopyWith(OnboardingDataEntity value,
          $Res Function(OnboardingDataEntity) then) =
      _$OnboardingDataEntityCopyWithImpl<$Res, OnboardingDataEntity>;
  @useResult
  $Res call(
      {String language,
      String? userName,
      String? partnerName,
      String? partnerZodiac,
      String? relationshipStatus,
      DateTime? keyDate,
      String? keyDateType,
      String? email,
      String? authProvider,
      String? firebaseUid,
      int currentStep,
      bool isComplete});
}

/// @nodoc
class _$OnboardingDataEntityCopyWithImpl<$Res,
        $Val extends OnboardingDataEntity>
    implements $OnboardingDataEntityCopyWith<$Res> {
  _$OnboardingDataEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingDataEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? userName = freezed,
    Object? partnerName = freezed,
    Object? partnerZodiac = freezed,
    Object? relationshipStatus = freezed,
    Object? keyDate = freezed,
    Object? keyDateType = freezed,
    Object? email = freezed,
    Object? authProvider = freezed,
    Object? firebaseUid = freezed,
    Object? currentStep = null,
    Object? isComplete = null,
  }) {
    return _then(_value.copyWith(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerName: freezed == partnerName
          ? _value.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerZodiac: freezed == partnerZodiac
          ? _value.partnerZodiac
          : partnerZodiac // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipStatus: freezed == relationshipStatus
          ? _value.relationshipStatus
          : relationshipStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      keyDate: freezed == keyDate
          ? _value.keyDate
          : keyDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      keyDateType: freezed == keyDateType
          ? _value.keyDateType
          : keyDateType // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      authProvider: freezed == authProvider
          ? _value.authProvider
          : authProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      firebaseUid: freezed == firebaseUid
          ? _value.firebaseUid
          : firebaseUid // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingDataEntityImplCopyWith<$Res>
    implements $OnboardingDataEntityCopyWith<$Res> {
  factory _$$OnboardingDataEntityImplCopyWith(_$OnboardingDataEntityImpl value,
          $Res Function(_$OnboardingDataEntityImpl) then) =
      __$$OnboardingDataEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String language,
      String? userName,
      String? partnerName,
      String? partnerZodiac,
      String? relationshipStatus,
      DateTime? keyDate,
      String? keyDateType,
      String? email,
      String? authProvider,
      String? firebaseUid,
      int currentStep,
      bool isComplete});
}

/// @nodoc
class __$$OnboardingDataEntityImplCopyWithImpl<$Res>
    extends _$OnboardingDataEntityCopyWithImpl<$Res, _$OnboardingDataEntityImpl>
    implements _$$OnboardingDataEntityImplCopyWith<$Res> {
  __$$OnboardingDataEntityImplCopyWithImpl(_$OnboardingDataEntityImpl _value,
      $Res Function(_$OnboardingDataEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnboardingDataEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? userName = freezed,
    Object? partnerName = freezed,
    Object? partnerZodiac = freezed,
    Object? relationshipStatus = freezed,
    Object? keyDate = freezed,
    Object? keyDateType = freezed,
    Object? email = freezed,
    Object? authProvider = freezed,
    Object? firebaseUid = freezed,
    Object? currentStep = null,
    Object? isComplete = null,
  }) {
    return _then(_$OnboardingDataEntityImpl(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerName: freezed == partnerName
          ? _value.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerZodiac: freezed == partnerZodiac
          ? _value.partnerZodiac
          : partnerZodiac // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipStatus: freezed == relationshipStatus
          ? _value.relationshipStatus
          : relationshipStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      keyDate: freezed == keyDate
          ? _value.keyDate
          : keyDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      keyDateType: freezed == keyDateType
          ? _value.keyDateType
          : keyDateType // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      authProvider: freezed == authProvider
          ? _value.authProvider
          : authProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      firebaseUid: freezed == firebaseUid
          ? _value.firebaseUid
          : firebaseUid // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OnboardingDataEntityImpl extends _OnboardingDataEntity {
  const _$OnboardingDataEntityImpl(
      {this.language = 'en',
      this.userName,
      this.partnerName,
      this.partnerZodiac,
      this.relationshipStatus,
      this.keyDate,
      this.keyDateType,
      this.email,
      this.authProvider,
      this.firebaseUid,
      this.currentStep = 0,
      this.isComplete = false})
      : super._();

  /// User's preferred language, set on the very first screen.
  @override
  @JsonKey()
  final String language;

  /// The user's display name (step 4).
  @override
  final String? userName;

  /// Partner's name (step 5).
  @override
  final String? partnerName;

  /// Partner's zodiac sign key, e.g. 'scorpio' (step 5).
  @override
  final String? partnerZodiac;

  /// Relationship status enum: dating, engaged, married (step 6).
  @override
  final String? relationshipStatus;

  /// The key date value -- anniversary or wedding date (step 7).
  @override
  final DateTime? keyDate;

  /// What [keyDate] represents: 'dating_anniversary' or 'wedding_date'.
  @override
  final String? keyDateType;

  /// Email for email/password sign-up (step 3).
  @override
  final String? email;

  /// Auth provider used: 'email', 'google', 'apple' (step 3).
  @override
  final String? authProvider;

  /// Firebase UID assigned after successful authentication (step 3).
  @override
  final String? firebaseUid;

  /// Current step index (0-7) for resume support.
  @override
  @JsonKey()
  final int currentStep;

  /// Whether the entire flow has been submitted to the backend.
  @override
  @JsonKey()
  final bool isComplete;

  @override
  String toString() {
    return 'OnboardingDataEntity(language: $language, userName: $userName, partnerName: $partnerName, partnerZodiac: $partnerZodiac, relationshipStatus: $relationshipStatus, keyDate: $keyDate, keyDateType: $keyDateType, email: $email, authProvider: $authProvider, firebaseUid: $firebaseUid, currentStep: $currentStep, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingDataEntityImpl &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.partnerName, partnerName) ||
                other.partnerName == partnerName) &&
            (identical(other.partnerZodiac, partnerZodiac) ||
                other.partnerZodiac == partnerZodiac) &&
            (identical(other.relationshipStatus, relationshipStatus) ||
                other.relationshipStatus == relationshipStatus) &&
            (identical(other.keyDate, keyDate) || other.keyDate == keyDate) &&
            (identical(other.keyDateType, keyDateType) ||
                other.keyDateType == keyDateType) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.authProvider, authProvider) ||
                other.authProvider == authProvider) &&
            (identical(other.firebaseUid, firebaseUid) ||
                other.firebaseUid == firebaseUid) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      language,
      userName,
      partnerName,
      partnerZodiac,
      relationshipStatus,
      keyDate,
      keyDateType,
      email,
      authProvider,
      firebaseUid,
      currentStep,
      isComplete);

  /// Create a copy of OnboardingDataEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingDataEntityImplCopyWith<_$OnboardingDataEntityImpl>
      get copyWith =>
          __$$OnboardingDataEntityImplCopyWithImpl<_$OnboardingDataEntityImpl>(
              this, _$identity);
}

abstract class _OnboardingDataEntity extends OnboardingDataEntity {
  const factory _OnboardingDataEntity(
      {final String language,
      final String? userName,
      final String? partnerName,
      final String? partnerZodiac,
      final String? relationshipStatus,
      final DateTime? keyDate,
      final String? keyDateType,
      final String? email,
      final String? authProvider,
      final String? firebaseUid,
      final int currentStep,
      final bool isComplete}) = _$OnboardingDataEntityImpl;
  const _OnboardingDataEntity._() : super._();

  /// User's preferred language, set on the very first screen.
  @override
  String get language;

  /// The user's display name (step 4).
  @override
  String? get userName;

  /// Partner's name (step 5).
  @override
  String? get partnerName;

  /// Partner's zodiac sign key, e.g. 'scorpio' (step 5).
  @override
  String? get partnerZodiac;

  /// Relationship status enum: dating, engaged, married (step 6).
  @override
  String? get relationshipStatus;

  /// The key date value -- anniversary or wedding date (step 7).
  @override
  DateTime? get keyDate;

  /// What [keyDate] represents: 'dating_anniversary' or 'wedding_date'.
  @override
  String? get keyDateType;

  /// Email for email/password sign-up (step 3).
  @override
  String? get email;

  /// Auth provider used: 'email', 'google', 'apple' (step 3).
  @override
  String? get authProvider;

  /// Firebase UID assigned after successful authentication (step 3).
  @override
  String? get firebaseUid;

  /// Current step index (0-7) for resume support.
  @override
  int get currentStep;

  /// Whether the entire flow has been submitted to the backend.
  @override
  bool get isComplete;

  /// Create a copy of OnboardingDataEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingDataEntityImplCopyWith<_$OnboardingDataEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
