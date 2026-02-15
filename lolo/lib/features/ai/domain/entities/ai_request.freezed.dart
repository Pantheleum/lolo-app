// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AiMessageRequest _$AiMessageRequestFromJson(Map<String, dynamic> json) {
  return _AiMessageRequest.fromJson(json);
}

/// @nodoc
mixin _$AiMessageRequest {
  AiMessageMode get mode => throw _privateConstructorUsedError;
  AiTone get tone => throw _privateConstructorUsedError;
  AiLength get length => throw _privateConstructorUsedError;
  String get profileId => throw _privateConstructorUsedError;
  String? get additionalContext => throw _privateConstructorUsedError;
  EmotionalState? get emotionalState => throw _privateConstructorUsedError;
  int? get situationSeverity => throw _privateConstructorUsedError;
  bool get includeAlternatives => throw _privateConstructorUsedError;

  /// Serializes this AiMessageRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiMessageRequestCopyWith<AiMessageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiMessageRequestCopyWith<$Res> {
  factory $AiMessageRequestCopyWith(
          AiMessageRequest value, $Res Function(AiMessageRequest) then) =
      _$AiMessageRequestCopyWithImpl<$Res, AiMessageRequest>;
  @useResult
  $Res call(
      {AiMessageMode mode,
      AiTone tone,
      AiLength length,
      String profileId,
      String? additionalContext,
      EmotionalState? emotionalState,
      int? situationSeverity,
      bool includeAlternatives});
}

/// @nodoc
class _$AiMessageRequestCopyWithImpl<$Res, $Val extends AiMessageRequest>
    implements $AiMessageRequestCopyWith<$Res> {
  _$AiMessageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? tone = null,
    Object? length = null,
    Object? profileId = null,
    Object? additionalContext = freezed,
    Object? emotionalState = freezed,
    Object? situationSeverity = freezed,
    Object? includeAlternatives = null,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AiMessageMode,
      tone: null == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as AiTone,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as AiLength,
      profileId: null == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      additionalContext: freezed == additionalContext
          ? _value.additionalContext
          : additionalContext // ignore: cast_nullable_to_non_nullable
              as String?,
      emotionalState: freezed == emotionalState
          ? _value.emotionalState
          : emotionalState // ignore: cast_nullable_to_non_nullable
              as EmotionalState?,
      situationSeverity: freezed == situationSeverity
          ? _value.situationSeverity
          : situationSeverity // ignore: cast_nullable_to_non_nullable
              as int?,
      includeAlternatives: null == includeAlternatives
          ? _value.includeAlternatives
          : includeAlternatives // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiMessageRequestImplCopyWith<$Res>
    implements $AiMessageRequestCopyWith<$Res> {
  factory _$$AiMessageRequestImplCopyWith(_$AiMessageRequestImpl value,
          $Res Function(_$AiMessageRequestImpl) then) =
      __$$AiMessageRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AiMessageMode mode,
      AiTone tone,
      AiLength length,
      String profileId,
      String? additionalContext,
      EmotionalState? emotionalState,
      int? situationSeverity,
      bool includeAlternatives});
}

/// @nodoc
class __$$AiMessageRequestImplCopyWithImpl<$Res>
    extends _$AiMessageRequestCopyWithImpl<$Res, _$AiMessageRequestImpl>
    implements _$$AiMessageRequestImplCopyWith<$Res> {
  __$$AiMessageRequestImplCopyWithImpl(_$AiMessageRequestImpl _value,
      $Res Function(_$AiMessageRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? tone = null,
    Object? length = null,
    Object? profileId = null,
    Object? additionalContext = freezed,
    Object? emotionalState = freezed,
    Object? situationSeverity = freezed,
    Object? includeAlternatives = null,
  }) {
    return _then(_$AiMessageRequestImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AiMessageMode,
      tone: null == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as AiTone,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as AiLength,
      profileId: null == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      additionalContext: freezed == additionalContext
          ? _value.additionalContext
          : additionalContext // ignore: cast_nullable_to_non_nullable
              as String?,
      emotionalState: freezed == emotionalState
          ? _value.emotionalState
          : emotionalState // ignore: cast_nullable_to_non_nullable
              as EmotionalState?,
      situationSeverity: freezed == situationSeverity
          ? _value.situationSeverity
          : situationSeverity // ignore: cast_nullable_to_non_nullable
              as int?,
      includeAlternatives: null == includeAlternatives
          ? _value.includeAlternatives
          : includeAlternatives // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AiMessageRequestImpl implements _AiMessageRequest {
  const _$AiMessageRequestImpl(
      {required this.mode,
      required this.tone,
      required this.length,
      required this.profileId,
      this.additionalContext,
      this.emotionalState,
      this.situationSeverity,
      this.includeAlternatives = false});

  factory _$AiMessageRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiMessageRequestImplFromJson(json);

  @override
  final AiMessageMode mode;
  @override
  final AiTone tone;
  @override
  final AiLength length;
  @override
  final String profileId;
  @override
  final String? additionalContext;
  @override
  final EmotionalState? emotionalState;
  @override
  final int? situationSeverity;
  @override
  @JsonKey()
  final bool includeAlternatives;

  @override
  String toString() {
    return 'AiMessageRequest(mode: $mode, tone: $tone, length: $length, profileId: $profileId, additionalContext: $additionalContext, emotionalState: $emotionalState, situationSeverity: $situationSeverity, includeAlternatives: $includeAlternatives)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiMessageRequestImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.additionalContext, additionalContext) ||
                other.additionalContext == additionalContext) &&
            (identical(other.emotionalState, emotionalState) ||
                other.emotionalState == emotionalState) &&
            (identical(other.situationSeverity, situationSeverity) ||
                other.situationSeverity == situationSeverity) &&
            (identical(other.includeAlternatives, includeAlternatives) ||
                other.includeAlternatives == includeAlternatives));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mode,
      tone,
      length,
      profileId,
      additionalContext,
      emotionalState,
      situationSeverity,
      includeAlternatives);

  /// Create a copy of AiMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiMessageRequestImplCopyWith<_$AiMessageRequestImpl> get copyWith =>
      __$$AiMessageRequestImplCopyWithImpl<_$AiMessageRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiMessageRequestImplToJson(
      this,
    );
  }
}

abstract class _AiMessageRequest implements AiMessageRequest {
  const factory _AiMessageRequest(
      {required final AiMessageMode mode,
      required final AiTone tone,
      required final AiLength length,
      required final String profileId,
      final String? additionalContext,
      final EmotionalState? emotionalState,
      final int? situationSeverity,
      final bool includeAlternatives}) = _$AiMessageRequestImpl;

  factory _AiMessageRequest.fromJson(Map<String, dynamic> json) =
      _$AiMessageRequestImpl.fromJson;

  @override
  AiMessageMode get mode;
  @override
  AiTone get tone;
  @override
  AiLength get length;
  @override
  String get profileId;
  @override
  String? get additionalContext;
  @override
  EmotionalState? get emotionalState;
  @override
  int? get situationSeverity;
  @override
  bool get includeAlternatives;

  /// Create a copy of AiMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiMessageRequestImplCopyWith<_$AiMessageRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GiftRecommendationRequest _$GiftRecommendationRequestFromJson(
    Map<String, dynamic> json) {
  return _GiftRecommendationRequest.fromJson(json);
}

/// @nodoc
mixin _$GiftRecommendationRequest {
  String get profileId => throw _privateConstructorUsedError;
  GiftOccasion get occasion => throw _privateConstructorUsedError;
  String? get occasionDetails => throw _privateConstructorUsedError;
  double get budgetMin => throw _privateConstructorUsedError;
  double get budgetMax => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  GiftType get giftType => throw _privateConstructorUsedError;
  List<String> get excludeCategories => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this GiftRecommendationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftRecommendationRequestCopyWith<GiftRecommendationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftRecommendationRequestCopyWith<$Res> {
  factory $GiftRecommendationRequestCopyWith(GiftRecommendationRequest value,
          $Res Function(GiftRecommendationRequest) then) =
      _$GiftRecommendationRequestCopyWithImpl<$Res, GiftRecommendationRequest>;
  @useResult
  $Res call(
      {String profileId,
      GiftOccasion occasion,
      String? occasionDetails,
      double budgetMin,
      double budgetMax,
      String currency,
      GiftType giftType,
      List<String> excludeCategories,
      int count});
}

/// @nodoc
class _$GiftRecommendationRequestCopyWithImpl<$Res,
        $Val extends GiftRecommendationRequest>
    implements $GiftRecommendationRequestCopyWith<$Res> {
  _$GiftRecommendationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileId = null,
    Object? occasion = null,
    Object? occasionDetails = freezed,
    Object? budgetMin = null,
    Object? budgetMax = null,
    Object? currency = null,
    Object? giftType = null,
    Object? excludeCategories = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      profileId: null == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      occasion: null == occasion
          ? _value.occasion
          : occasion // ignore: cast_nullable_to_non_nullable
              as GiftOccasion,
      occasionDetails: freezed == occasionDetails
          ? _value.occasionDetails
          : occasionDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetMin: null == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double,
      budgetMax: null == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      giftType: null == giftType
          ? _value.giftType
          : giftType // ignore: cast_nullable_to_non_nullable
              as GiftType,
      excludeCategories: null == excludeCategories
          ? _value.excludeCategories
          : excludeCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GiftRecommendationRequestImplCopyWith<$Res>
    implements $GiftRecommendationRequestCopyWith<$Res> {
  factory _$$GiftRecommendationRequestImplCopyWith(
          _$GiftRecommendationRequestImpl value,
          $Res Function(_$GiftRecommendationRequestImpl) then) =
      __$$GiftRecommendationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String profileId,
      GiftOccasion occasion,
      String? occasionDetails,
      double budgetMin,
      double budgetMax,
      String currency,
      GiftType giftType,
      List<String> excludeCategories,
      int count});
}

/// @nodoc
class __$$GiftRecommendationRequestImplCopyWithImpl<$Res>
    extends _$GiftRecommendationRequestCopyWithImpl<$Res,
        _$GiftRecommendationRequestImpl>
    implements _$$GiftRecommendationRequestImplCopyWith<$Res> {
  __$$GiftRecommendationRequestImplCopyWithImpl(
      _$GiftRecommendationRequestImpl _value,
      $Res Function(_$GiftRecommendationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileId = null,
    Object? occasion = null,
    Object? occasionDetails = freezed,
    Object? budgetMin = null,
    Object? budgetMax = null,
    Object? currency = null,
    Object? giftType = null,
    Object? excludeCategories = null,
    Object? count = null,
  }) {
    return _then(_$GiftRecommendationRequestImpl(
      profileId: null == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      occasion: null == occasion
          ? _value.occasion
          : occasion // ignore: cast_nullable_to_non_nullable
              as GiftOccasion,
      occasionDetails: freezed == occasionDetails
          ? _value.occasionDetails
          : occasionDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      budgetMin: null == budgetMin
          ? _value.budgetMin
          : budgetMin // ignore: cast_nullable_to_non_nullable
              as double,
      budgetMax: null == budgetMax
          ? _value.budgetMax
          : budgetMax // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      giftType: null == giftType
          ? _value.giftType
          : giftType // ignore: cast_nullable_to_non_nullable
              as GiftType,
      excludeCategories: null == excludeCategories
          ? _value._excludeCategories
          : excludeCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftRecommendationRequestImpl implements _GiftRecommendationRequest {
  const _$GiftRecommendationRequestImpl(
      {required this.profileId,
      required this.occasion,
      this.occasionDetails,
      required this.budgetMin,
      required this.budgetMax,
      this.currency = 'USD',
      this.giftType = GiftType.any,
      final List<String> excludeCategories = const [],
      this.count = 5})
      : _excludeCategories = excludeCategories;

  factory _$GiftRecommendationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftRecommendationRequestImplFromJson(json);

  @override
  final String profileId;
  @override
  final GiftOccasion occasion;
  @override
  final String? occasionDetails;
  @override
  final double budgetMin;
  @override
  final double budgetMax;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final GiftType giftType;
  final List<String> _excludeCategories;
  @override
  @JsonKey()
  List<String> get excludeCategories {
    if (_excludeCategories is EqualUnmodifiableListView)
      return _excludeCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_excludeCategories);
  }

  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'GiftRecommendationRequest(profileId: $profileId, occasion: $occasion, occasionDetails: $occasionDetails, budgetMin: $budgetMin, budgetMax: $budgetMax, currency: $currency, giftType: $giftType, excludeCategories: $excludeCategories, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftRecommendationRequestImpl &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.occasion, occasion) ||
                other.occasion == occasion) &&
            (identical(other.occasionDetails, occasionDetails) ||
                other.occasionDetails == occasionDetails) &&
            (identical(other.budgetMin, budgetMin) ||
                other.budgetMin == budgetMin) &&
            (identical(other.budgetMax, budgetMax) ||
                other.budgetMax == budgetMax) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.giftType, giftType) ||
                other.giftType == giftType) &&
            const DeepCollectionEquality()
                .equals(other._excludeCategories, _excludeCategories) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      profileId,
      occasion,
      occasionDetails,
      budgetMin,
      budgetMax,
      currency,
      giftType,
      const DeepCollectionEquality().hash(_excludeCategories),
      count);

  /// Create a copy of GiftRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftRecommendationRequestImplCopyWith<_$GiftRecommendationRequestImpl>
      get copyWith => __$$GiftRecommendationRequestImplCopyWithImpl<
          _$GiftRecommendationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftRecommendationRequestImplToJson(
      this,
    );
  }
}

abstract class _GiftRecommendationRequest implements GiftRecommendationRequest {
  const factory _GiftRecommendationRequest(
      {required final String profileId,
      required final GiftOccasion occasion,
      final String? occasionDetails,
      required final double budgetMin,
      required final double budgetMax,
      final String currency,
      final GiftType giftType,
      final List<String> excludeCategories,
      final int count}) = _$GiftRecommendationRequestImpl;

  factory _GiftRecommendationRequest.fromJson(Map<String, dynamic> json) =
      _$GiftRecommendationRequestImpl.fromJson;

  @override
  String get profileId;
  @override
  GiftOccasion get occasion;
  @override
  String? get occasionDetails;
  @override
  double get budgetMin;
  @override
  double get budgetMax;
  @override
  String get currency;
  @override
  GiftType get giftType;
  @override
  List<String> get excludeCategories;
  @override
  int get count;

  /// Create a copy of GiftRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftRecommendationRequestImplCopyWith<_$GiftRecommendationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SosActivateRequest _$SosActivateRequestFromJson(Map<String, dynamic> json) {
  return _SosActivateRequest.fromJson(json);
}

/// @nodoc
mixin _$SosActivateRequest {
  SosScenario get scenario => throw _privateConstructorUsedError;
  SosUrgency get urgency => throw _privateConstructorUsedError;
  String? get briefContext => throw _privateConstructorUsedError;
  String? get profileId => throw _privateConstructorUsedError;

  /// Serializes this SosActivateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosActivateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosActivateRequestCopyWith<SosActivateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosActivateRequestCopyWith<$Res> {
  factory $SosActivateRequestCopyWith(
          SosActivateRequest value, $Res Function(SosActivateRequest) then) =
      _$SosActivateRequestCopyWithImpl<$Res, SosActivateRequest>;
  @useResult
  $Res call(
      {SosScenario scenario,
      SosUrgency urgency,
      String? briefContext,
      String? profileId});
}

/// @nodoc
class _$SosActivateRequestCopyWithImpl<$Res, $Val extends SosActivateRequest>
    implements $SosActivateRequestCopyWith<$Res> {
  _$SosActivateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosActivateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scenario = null,
    Object? urgency = null,
    Object? briefContext = freezed,
    Object? profileId = freezed,
  }) {
    return _then(_value.copyWith(
      scenario: null == scenario
          ? _value.scenario
          : scenario // ignore: cast_nullable_to_non_nullable
              as SosScenario,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as SosUrgency,
      briefContext: freezed == briefContext
          ? _value.briefContext
          : briefContext // ignore: cast_nullable_to_non_nullable
              as String?,
      profileId: freezed == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosActivateRequestImplCopyWith<$Res>
    implements $SosActivateRequestCopyWith<$Res> {
  factory _$$SosActivateRequestImplCopyWith(_$SosActivateRequestImpl value,
          $Res Function(_$SosActivateRequestImpl) then) =
      __$$SosActivateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SosScenario scenario,
      SosUrgency urgency,
      String? briefContext,
      String? profileId});
}

/// @nodoc
class __$$SosActivateRequestImplCopyWithImpl<$Res>
    extends _$SosActivateRequestCopyWithImpl<$Res, _$SosActivateRequestImpl>
    implements _$$SosActivateRequestImplCopyWith<$Res> {
  __$$SosActivateRequestImplCopyWithImpl(_$SosActivateRequestImpl _value,
      $Res Function(_$SosActivateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosActivateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scenario = null,
    Object? urgency = null,
    Object? briefContext = freezed,
    Object? profileId = freezed,
  }) {
    return _then(_$SosActivateRequestImpl(
      scenario: null == scenario
          ? _value.scenario
          : scenario // ignore: cast_nullable_to_non_nullable
              as SosScenario,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as SosUrgency,
      briefContext: freezed == briefContext
          ? _value.briefContext
          : briefContext // ignore: cast_nullable_to_non_nullable
              as String?,
      profileId: freezed == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosActivateRequestImpl implements _SosActivateRequest {
  const _$SosActivateRequestImpl(
      {required this.scenario,
      required this.urgency,
      this.briefContext,
      this.profileId});

  factory _$SosActivateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosActivateRequestImplFromJson(json);

  @override
  final SosScenario scenario;
  @override
  final SosUrgency urgency;
  @override
  final String? briefContext;
  @override
  final String? profileId;

  @override
  String toString() {
    return 'SosActivateRequest(scenario: $scenario, urgency: $urgency, briefContext: $briefContext, profileId: $profileId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosActivateRequestImpl &&
            (identical(other.scenario, scenario) ||
                other.scenario == scenario) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.briefContext, briefContext) ||
                other.briefContext == briefContext) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, scenario, urgency, briefContext, profileId);

  /// Create a copy of SosActivateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosActivateRequestImplCopyWith<_$SosActivateRequestImpl> get copyWith =>
      __$$SosActivateRequestImplCopyWithImpl<_$SosActivateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosActivateRequestImplToJson(
      this,
    );
  }
}

abstract class _SosActivateRequest implements SosActivateRequest {
  const factory _SosActivateRequest(
      {required final SosScenario scenario,
      required final SosUrgency urgency,
      final String? briefContext,
      final String? profileId}) = _$SosActivateRequestImpl;

  factory _SosActivateRequest.fromJson(Map<String, dynamic> json) =
      _$SosActivateRequestImpl.fromJson;

  @override
  SosScenario get scenario;
  @override
  SosUrgency get urgency;
  @override
  String? get briefContext;
  @override
  String? get profileId;

  /// Create a copy of SosActivateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosActivateRequestImplCopyWith<_$SosActivateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SosAssessRequest _$SosAssessRequestFromJson(Map<String, dynamic> json) {
  return _SosAssessRequest.fromJson(json);
}

/// @nodoc
mixin _$SosAssessRequest {
  String get sessionId => throw _privateConstructorUsedError;
  SosAssessmentAnswers get answers => throw _privateConstructorUsedError;

  /// Serializes this SosAssessRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosAssessRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosAssessRequestCopyWith<SosAssessRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosAssessRequestCopyWith<$Res> {
  factory $SosAssessRequestCopyWith(
          SosAssessRequest value, $Res Function(SosAssessRequest) then) =
      _$SosAssessRequestCopyWithImpl<$Res, SosAssessRequest>;
  @useResult
  $Res call({String sessionId, SosAssessmentAnswers answers});

  $SosAssessmentAnswersCopyWith<$Res> get answers;
}

/// @nodoc
class _$SosAssessRequestCopyWithImpl<$Res, $Val extends SosAssessRequest>
    implements $SosAssessRequestCopyWith<$Res> {
  _$SosAssessRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosAssessRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? answers = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as SosAssessmentAnswers,
    ) as $Val);
  }

  /// Create a copy of SosAssessRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosAssessmentAnswersCopyWith<$Res> get answers {
    return $SosAssessmentAnswersCopyWith<$Res>(_value.answers, (value) {
      return _then(_value.copyWith(answers: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SosAssessRequestImplCopyWith<$Res>
    implements $SosAssessRequestCopyWith<$Res> {
  factory _$$SosAssessRequestImplCopyWith(_$SosAssessRequestImpl value,
          $Res Function(_$SosAssessRequestImpl) then) =
      __$$SosAssessRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sessionId, SosAssessmentAnswers answers});

  @override
  $SosAssessmentAnswersCopyWith<$Res> get answers;
}

/// @nodoc
class __$$SosAssessRequestImplCopyWithImpl<$Res>
    extends _$SosAssessRequestCopyWithImpl<$Res, _$SosAssessRequestImpl>
    implements _$$SosAssessRequestImplCopyWith<$Res> {
  __$$SosAssessRequestImplCopyWithImpl(_$SosAssessRequestImpl _value,
      $Res Function(_$SosAssessRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosAssessRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? answers = null,
  }) {
    return _then(_$SosAssessRequestImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as SosAssessmentAnswers,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosAssessRequestImpl implements _SosAssessRequest {
  const _$SosAssessRequestImpl(
      {required this.sessionId, required this.answers});

  factory _$SosAssessRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosAssessRequestImplFromJson(json);

  @override
  final String sessionId;
  @override
  final SosAssessmentAnswers answers;

  @override
  String toString() {
    return 'SosAssessRequest(sessionId: $sessionId, answers: $answers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosAssessRequestImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.answers, answers) || other.answers == answers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sessionId, answers);

  /// Create a copy of SosAssessRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosAssessRequestImplCopyWith<_$SosAssessRequestImpl> get copyWith =>
      __$$SosAssessRequestImplCopyWithImpl<_$SosAssessRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosAssessRequestImplToJson(
      this,
    );
  }
}

abstract class _SosAssessRequest implements SosAssessRequest {
  const factory _SosAssessRequest(
      {required final String sessionId,
      required final SosAssessmentAnswers answers}) = _$SosAssessRequestImpl;

  factory _SosAssessRequest.fromJson(Map<String, dynamic> json) =
      _$SosAssessRequestImpl.fromJson;

  @override
  String get sessionId;
  @override
  SosAssessmentAnswers get answers;

  /// Create a copy of SosAssessRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosAssessRequestImplCopyWith<_$SosAssessRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SosAssessmentAnswers _$SosAssessmentAnswersFromJson(Map<String, dynamic> json) {
  return _SosAssessmentAnswers.fromJson(json);
}

/// @nodoc
mixin _$SosAssessmentAnswers {
  String get howLongAgo => throw _privateConstructorUsedError;
  String get herCurrentState => throw _privateConstructorUsedError;
  bool get haveYouSpoken => throw _privateConstructorUsedError;
  bool get isSheTalking => throw _privateConstructorUsedError;
  String get yourFault => throw _privateConstructorUsedError;
  bool? get previousSimilar => throw _privateConstructorUsedError;
  String? get additionalContext => throw _privateConstructorUsedError;

  /// Serializes this SosAssessmentAnswers to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosAssessmentAnswers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosAssessmentAnswersCopyWith<SosAssessmentAnswers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosAssessmentAnswersCopyWith<$Res> {
  factory $SosAssessmentAnswersCopyWith(SosAssessmentAnswers value,
          $Res Function(SosAssessmentAnswers) then) =
      _$SosAssessmentAnswersCopyWithImpl<$Res, SosAssessmentAnswers>;
  @useResult
  $Res call(
      {String howLongAgo,
      String herCurrentState,
      bool haveYouSpoken,
      bool isSheTalking,
      String yourFault,
      bool? previousSimilar,
      String? additionalContext});
}

/// @nodoc
class _$SosAssessmentAnswersCopyWithImpl<$Res,
        $Val extends SosAssessmentAnswers>
    implements $SosAssessmentAnswersCopyWith<$Res> {
  _$SosAssessmentAnswersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosAssessmentAnswers
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? howLongAgo = null,
    Object? herCurrentState = null,
    Object? haveYouSpoken = null,
    Object? isSheTalking = null,
    Object? yourFault = null,
    Object? previousSimilar = freezed,
    Object? additionalContext = freezed,
  }) {
    return _then(_value.copyWith(
      howLongAgo: null == howLongAgo
          ? _value.howLongAgo
          : howLongAgo // ignore: cast_nullable_to_non_nullable
              as String,
      herCurrentState: null == herCurrentState
          ? _value.herCurrentState
          : herCurrentState // ignore: cast_nullable_to_non_nullable
              as String,
      haveYouSpoken: null == haveYouSpoken
          ? _value.haveYouSpoken
          : haveYouSpoken // ignore: cast_nullable_to_non_nullable
              as bool,
      isSheTalking: null == isSheTalking
          ? _value.isSheTalking
          : isSheTalking // ignore: cast_nullable_to_non_nullable
              as bool,
      yourFault: null == yourFault
          ? _value.yourFault
          : yourFault // ignore: cast_nullable_to_non_nullable
              as String,
      previousSimilar: freezed == previousSimilar
          ? _value.previousSimilar
          : previousSimilar // ignore: cast_nullable_to_non_nullable
              as bool?,
      additionalContext: freezed == additionalContext
          ? _value.additionalContext
          : additionalContext // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosAssessmentAnswersImplCopyWith<$Res>
    implements $SosAssessmentAnswersCopyWith<$Res> {
  factory _$$SosAssessmentAnswersImplCopyWith(_$SosAssessmentAnswersImpl value,
          $Res Function(_$SosAssessmentAnswersImpl) then) =
      __$$SosAssessmentAnswersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String howLongAgo,
      String herCurrentState,
      bool haveYouSpoken,
      bool isSheTalking,
      String yourFault,
      bool? previousSimilar,
      String? additionalContext});
}

/// @nodoc
class __$$SosAssessmentAnswersImplCopyWithImpl<$Res>
    extends _$SosAssessmentAnswersCopyWithImpl<$Res, _$SosAssessmentAnswersImpl>
    implements _$$SosAssessmentAnswersImplCopyWith<$Res> {
  __$$SosAssessmentAnswersImplCopyWithImpl(_$SosAssessmentAnswersImpl _value,
      $Res Function(_$SosAssessmentAnswersImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosAssessmentAnswers
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? howLongAgo = null,
    Object? herCurrentState = null,
    Object? haveYouSpoken = null,
    Object? isSheTalking = null,
    Object? yourFault = null,
    Object? previousSimilar = freezed,
    Object? additionalContext = freezed,
  }) {
    return _then(_$SosAssessmentAnswersImpl(
      howLongAgo: null == howLongAgo
          ? _value.howLongAgo
          : howLongAgo // ignore: cast_nullable_to_non_nullable
              as String,
      herCurrentState: null == herCurrentState
          ? _value.herCurrentState
          : herCurrentState // ignore: cast_nullable_to_non_nullable
              as String,
      haveYouSpoken: null == haveYouSpoken
          ? _value.haveYouSpoken
          : haveYouSpoken // ignore: cast_nullable_to_non_nullable
              as bool,
      isSheTalking: null == isSheTalking
          ? _value.isSheTalking
          : isSheTalking // ignore: cast_nullable_to_non_nullable
              as bool,
      yourFault: null == yourFault
          ? _value.yourFault
          : yourFault // ignore: cast_nullable_to_non_nullable
              as String,
      previousSimilar: freezed == previousSimilar
          ? _value.previousSimilar
          : previousSimilar // ignore: cast_nullable_to_non_nullable
              as bool?,
      additionalContext: freezed == additionalContext
          ? _value.additionalContext
          : additionalContext // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosAssessmentAnswersImpl implements _SosAssessmentAnswers {
  const _$SosAssessmentAnswersImpl(
      {required this.howLongAgo,
      required this.herCurrentState,
      required this.haveYouSpoken,
      required this.isSheTalking,
      required this.yourFault,
      this.previousSimilar,
      this.additionalContext});

  factory _$SosAssessmentAnswersImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosAssessmentAnswersImplFromJson(json);

  @override
  final String howLongAgo;
  @override
  final String herCurrentState;
  @override
  final bool haveYouSpoken;
  @override
  final bool isSheTalking;
  @override
  final String yourFault;
  @override
  final bool? previousSimilar;
  @override
  final String? additionalContext;

  @override
  String toString() {
    return 'SosAssessmentAnswers(howLongAgo: $howLongAgo, herCurrentState: $herCurrentState, haveYouSpoken: $haveYouSpoken, isSheTalking: $isSheTalking, yourFault: $yourFault, previousSimilar: $previousSimilar, additionalContext: $additionalContext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosAssessmentAnswersImpl &&
            (identical(other.howLongAgo, howLongAgo) ||
                other.howLongAgo == howLongAgo) &&
            (identical(other.herCurrentState, herCurrentState) ||
                other.herCurrentState == herCurrentState) &&
            (identical(other.haveYouSpoken, haveYouSpoken) ||
                other.haveYouSpoken == haveYouSpoken) &&
            (identical(other.isSheTalking, isSheTalking) ||
                other.isSheTalking == isSheTalking) &&
            (identical(other.yourFault, yourFault) ||
                other.yourFault == yourFault) &&
            (identical(other.previousSimilar, previousSimilar) ||
                other.previousSimilar == previousSimilar) &&
            (identical(other.additionalContext, additionalContext) ||
                other.additionalContext == additionalContext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      howLongAgo,
      herCurrentState,
      haveYouSpoken,
      isSheTalking,
      yourFault,
      previousSimilar,
      additionalContext);

  /// Create a copy of SosAssessmentAnswers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosAssessmentAnswersImplCopyWith<_$SosAssessmentAnswersImpl>
      get copyWith =>
          __$$SosAssessmentAnswersImplCopyWithImpl<_$SosAssessmentAnswersImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosAssessmentAnswersImplToJson(
      this,
    );
  }
}

abstract class _SosAssessmentAnswers implements SosAssessmentAnswers {
  const factory _SosAssessmentAnswers(
      {required final String howLongAgo,
      required final String herCurrentState,
      required final bool haveYouSpoken,
      required final bool isSheTalking,
      required final String yourFault,
      final bool? previousSimilar,
      final String? additionalContext}) = _$SosAssessmentAnswersImpl;

  factory _SosAssessmentAnswers.fromJson(Map<String, dynamic> json) =
      _$SosAssessmentAnswersImpl.fromJson;

  @override
  String get howLongAgo;
  @override
  String get herCurrentState;
  @override
  bool get haveYouSpoken;
  @override
  bool get isSheTalking;
  @override
  String get yourFault;
  @override
  bool? get previousSimilar;
  @override
  String? get additionalContext;

  /// Create a copy of SosAssessmentAnswers
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosAssessmentAnswersImplCopyWith<_$SosAssessmentAnswersImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SosCoachRequest _$SosCoachRequestFromJson(Map<String, dynamic> json) {
  return _SosCoachRequest.fromJson(json);
}

/// @nodoc
mixin _$SosCoachRequest {
  String get sessionId => throw _privateConstructorUsedError;
  int get stepNumber => throw _privateConstructorUsedError;
  String? get userUpdate => throw _privateConstructorUsedError;
  String? get herResponse => throw _privateConstructorUsedError;
  bool get stream => throw _privateConstructorUsedError;

  /// Serializes this SosCoachRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosCoachRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosCoachRequestCopyWith<SosCoachRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosCoachRequestCopyWith<$Res> {
  factory $SosCoachRequestCopyWith(
          SosCoachRequest value, $Res Function(SosCoachRequest) then) =
      _$SosCoachRequestCopyWithImpl<$Res, SosCoachRequest>;
  @useResult
  $Res call(
      {String sessionId,
      int stepNumber,
      String? userUpdate,
      String? herResponse,
      bool stream});
}

/// @nodoc
class _$SosCoachRequestCopyWithImpl<$Res, $Val extends SosCoachRequest>
    implements $SosCoachRequestCopyWith<$Res> {
  _$SosCoachRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosCoachRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? stepNumber = null,
    Object? userUpdate = freezed,
    Object? herResponse = freezed,
    Object? stream = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      stepNumber: null == stepNumber
          ? _value.stepNumber
          : stepNumber // ignore: cast_nullable_to_non_nullable
              as int,
      userUpdate: freezed == userUpdate
          ? _value.userUpdate
          : userUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
      herResponse: freezed == herResponse
          ? _value.herResponse
          : herResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      stream: null == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosCoachRequestImplCopyWith<$Res>
    implements $SosCoachRequestCopyWith<$Res> {
  factory _$$SosCoachRequestImplCopyWith(_$SosCoachRequestImpl value,
          $Res Function(_$SosCoachRequestImpl) then) =
      __$$SosCoachRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      int stepNumber,
      String? userUpdate,
      String? herResponse,
      bool stream});
}

/// @nodoc
class __$$SosCoachRequestImplCopyWithImpl<$Res>
    extends _$SosCoachRequestCopyWithImpl<$Res, _$SosCoachRequestImpl>
    implements _$$SosCoachRequestImplCopyWith<$Res> {
  __$$SosCoachRequestImplCopyWithImpl(
      _$SosCoachRequestImpl _value, $Res Function(_$SosCoachRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosCoachRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? stepNumber = null,
    Object? userUpdate = freezed,
    Object? herResponse = freezed,
    Object? stream = null,
  }) {
    return _then(_$SosCoachRequestImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      stepNumber: null == stepNumber
          ? _value.stepNumber
          : stepNumber // ignore: cast_nullable_to_non_nullable
              as int,
      userUpdate: freezed == userUpdate
          ? _value.userUpdate
          : userUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
      herResponse: freezed == herResponse
          ? _value.herResponse
          : herResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      stream: null == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosCoachRequestImpl implements _SosCoachRequest {
  const _$SosCoachRequestImpl(
      {required this.sessionId,
      required this.stepNumber,
      this.userUpdate,
      this.herResponse,
      this.stream = false});

  factory _$SosCoachRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosCoachRequestImplFromJson(json);

  @override
  final String sessionId;
  @override
  final int stepNumber;
  @override
  final String? userUpdate;
  @override
  final String? herResponse;
  @override
  @JsonKey()
  final bool stream;

  @override
  String toString() {
    return 'SosCoachRequest(sessionId: $sessionId, stepNumber: $stepNumber, userUpdate: $userUpdate, herResponse: $herResponse, stream: $stream)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosCoachRequestImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.stepNumber, stepNumber) ||
                other.stepNumber == stepNumber) &&
            (identical(other.userUpdate, userUpdate) ||
                other.userUpdate == userUpdate) &&
            (identical(other.herResponse, herResponse) ||
                other.herResponse == herResponse) &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sessionId, stepNumber, userUpdate, herResponse, stream);

  /// Create a copy of SosCoachRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosCoachRequestImplCopyWith<_$SosCoachRequestImpl> get copyWith =>
      __$$SosCoachRequestImplCopyWithImpl<_$SosCoachRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosCoachRequestImplToJson(
      this,
    );
  }
}

abstract class _SosCoachRequest implements SosCoachRequest {
  const factory _SosCoachRequest(
      {required final String sessionId,
      required final int stepNumber,
      final String? userUpdate,
      final String? herResponse,
      final bool stream}) = _$SosCoachRequestImpl;

  factory _SosCoachRequest.fromJson(Map<String, dynamic> json) =
      _$SosCoachRequestImpl.fromJson;

  @override
  String get sessionId;
  @override
  int get stepNumber;
  @override
  String? get userUpdate;
  @override
  String? get herResponse;
  @override
  bool get stream;

  /// Create a copy of SosCoachRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosCoachRequestImplCopyWith<_$SosCoachRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
