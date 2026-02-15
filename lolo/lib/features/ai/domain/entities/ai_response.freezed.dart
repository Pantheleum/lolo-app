// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AiMessageResponse _$AiMessageResponseFromJson(Map<String, dynamic> json) {
  return _AiMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$AiMessageResponse {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String> get alternatives => throw _privateConstructorUsedError;
  String get mode => throw _privateConstructorUsedError;
  String get tone => throw _privateConstructorUsedError;
  String get length => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  AiMetadata get metadata => throw _privateConstructorUsedError;
  String get feedbackId => throw _privateConstructorUsedError;
  AiUsageInfo get usage => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AiMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiMessageResponseCopyWith<AiMessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiMessageResponseCopyWith<$Res> {
  factory $AiMessageResponseCopyWith(
          AiMessageResponse value, $Res Function(AiMessageResponse) then) =
      _$AiMessageResponseCopyWithImpl<$Res, AiMessageResponse>;
  @useResult
  $Res call(
      {String id,
      String content,
      List<String> alternatives,
      String mode,
      String tone,
      String length,
      String language,
      AiMetadata metadata,
      String feedbackId,
      AiUsageInfo usage,
      DateTime createdAt});

  $AiMetadataCopyWith<$Res> get metadata;
  $AiUsageInfoCopyWith<$Res> get usage;
}

/// @nodoc
class _$AiMessageResponseCopyWithImpl<$Res, $Val extends AiMessageResponse>
    implements $AiMessageResponseCopyWith<$Res> {
  _$AiMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? alternatives = null,
    Object? mode = null,
    Object? tone = null,
    Object? length = null,
    Object? language = null,
    Object? metadata = null,
    Object? feedbackId = null,
    Object? usage = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      alternatives: null == alternatives
          ? _value.alternatives
          : alternatives // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as AiMetadata,
      feedbackId: null == feedbackId
          ? _value.feedbackId
          : feedbackId // ignore: cast_nullable_to_non_nullable
              as String,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as AiUsageInfo,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of AiMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AiMetadataCopyWith<$Res> get metadata {
    return $AiMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }

  /// Create a copy of AiMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AiUsageInfoCopyWith<$Res> get usage {
    return $AiUsageInfoCopyWith<$Res>(_value.usage, (value) {
      return _then(_value.copyWith(usage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AiMessageResponseImplCopyWith<$Res>
    implements $AiMessageResponseCopyWith<$Res> {
  factory _$$AiMessageResponseImplCopyWith(_$AiMessageResponseImpl value,
          $Res Function(_$AiMessageResponseImpl) then) =
      __$$AiMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String content,
      List<String> alternatives,
      String mode,
      String tone,
      String length,
      String language,
      AiMetadata metadata,
      String feedbackId,
      AiUsageInfo usage,
      DateTime createdAt});

  @override
  $AiMetadataCopyWith<$Res> get metadata;
  @override
  $AiUsageInfoCopyWith<$Res> get usage;
}

/// @nodoc
class __$$AiMessageResponseImplCopyWithImpl<$Res>
    extends _$AiMessageResponseCopyWithImpl<$Res, _$AiMessageResponseImpl>
    implements _$$AiMessageResponseImplCopyWith<$Res> {
  __$$AiMessageResponseImplCopyWithImpl(_$AiMessageResponseImpl _value,
      $Res Function(_$AiMessageResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? alternatives = null,
    Object? mode = null,
    Object? tone = null,
    Object? length = null,
    Object? language = null,
    Object? metadata = null,
    Object? feedbackId = null,
    Object? usage = null,
    Object? createdAt = null,
  }) {
    return _then(_$AiMessageResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      alternatives: null == alternatives
          ? _value._alternatives
          : alternatives // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      tone: null == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as String,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as AiMetadata,
      feedbackId: null == feedbackId
          ? _value.feedbackId
          : feedbackId // ignore: cast_nullable_to_non_nullable
              as String,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as AiUsageInfo,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AiMessageResponseImpl implements _AiMessageResponse {
  const _$AiMessageResponseImpl(
      {required this.id,
      required this.content,
      final List<String> alternatives = const [],
      required this.mode,
      required this.tone,
      required this.length,
      required this.language,
      required this.metadata,
      required this.feedbackId,
      required this.usage,
      required this.createdAt})
      : _alternatives = alternatives;

  factory _$AiMessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiMessageResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  final List<String> _alternatives;
  @override
  @JsonKey()
  List<String> get alternatives {
    if (_alternatives is EqualUnmodifiableListView) return _alternatives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alternatives);
  }

  @override
  final String mode;
  @override
  final String tone;
  @override
  final String length;
  @override
  final String language;
  @override
  final AiMetadata metadata;
  @override
  final String feedbackId;
  @override
  final AiUsageInfo usage;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'AiMessageResponse(id: $id, content: $content, alternatives: $alternatives, mode: $mode, tone: $tone, length: $length, language: $language, metadata: $metadata, feedbackId: $feedbackId, usage: $usage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiMessageResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._alternatives, _alternatives) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.feedbackId, feedbackId) ||
                other.feedbackId == feedbackId) &&
            (identical(other.usage, usage) || other.usage == usage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      content,
      const DeepCollectionEquality().hash(_alternatives),
      mode,
      tone,
      length,
      language,
      metadata,
      feedbackId,
      usage,
      createdAt);

  /// Create a copy of AiMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiMessageResponseImplCopyWith<_$AiMessageResponseImpl> get copyWith =>
      __$$AiMessageResponseImplCopyWithImpl<_$AiMessageResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiMessageResponseImplToJson(
      this,
    );
  }
}

abstract class _AiMessageResponse implements AiMessageResponse {
  const factory _AiMessageResponse(
      {required final String id,
      required final String content,
      final List<String> alternatives,
      required final String mode,
      required final String tone,
      required final String length,
      required final String language,
      required final AiMetadata metadata,
      required final String feedbackId,
      required final AiUsageInfo usage,
      required final DateTime createdAt}) = _$AiMessageResponseImpl;

  factory _AiMessageResponse.fromJson(Map<String, dynamic> json) =
      _$AiMessageResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  List<String> get alternatives;
  @override
  String get mode;
  @override
  String get tone;
  @override
  String get length;
  @override
  String get language;
  @override
  AiMetadata get metadata;
  @override
  String get feedbackId;
  @override
  AiUsageInfo get usage;
  @override
  DateTime get createdAt;

  /// Create a copy of AiMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiMessageResponseImplCopyWith<_$AiMessageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiMetadata _$AiMetadataFromJson(Map<String, dynamic> json) {
  return _AiMetadata.fromJson(json);
}

/// @nodoc
mixin _$AiMetadata {
  String get modelUsed => throw _privateConstructorUsedError;
  int get emotionalDepthScore => throw _privateConstructorUsedError;
  int get latencyMs => throw _privateConstructorUsedError;
  bool get cached => throw _privateConstructorUsedError;
  bool get wasFallback => throw _privateConstructorUsedError;

  /// Serializes this AiMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiMetadataCopyWith<AiMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiMetadataCopyWith<$Res> {
  factory $AiMetadataCopyWith(
          AiMetadata value, $Res Function(AiMetadata) then) =
      _$AiMetadataCopyWithImpl<$Res, AiMetadata>;
  @useResult
  $Res call(
      {String modelUsed,
      int emotionalDepthScore,
      int latencyMs,
      bool cached,
      bool wasFallback});
}

/// @nodoc
class _$AiMetadataCopyWithImpl<$Res, $Val extends AiMetadata>
    implements $AiMetadataCopyWith<$Res> {
  _$AiMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelUsed = null,
    Object? emotionalDepthScore = null,
    Object? latencyMs = null,
    Object? cached = null,
    Object? wasFallback = null,
  }) {
    return _then(_value.copyWith(
      modelUsed: null == modelUsed
          ? _value.modelUsed
          : modelUsed // ignore: cast_nullable_to_non_nullable
              as String,
      emotionalDepthScore: null == emotionalDepthScore
          ? _value.emotionalDepthScore
          : emotionalDepthScore // ignore: cast_nullable_to_non_nullable
              as int,
      latencyMs: null == latencyMs
          ? _value.latencyMs
          : latencyMs // ignore: cast_nullable_to_non_nullable
              as int,
      cached: null == cached
          ? _value.cached
          : cached // ignore: cast_nullable_to_non_nullable
              as bool,
      wasFallback: null == wasFallback
          ? _value.wasFallback
          : wasFallback // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiMetadataImplCopyWith<$Res>
    implements $AiMetadataCopyWith<$Res> {
  factory _$$AiMetadataImplCopyWith(
          _$AiMetadataImpl value, $Res Function(_$AiMetadataImpl) then) =
      __$$AiMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String modelUsed,
      int emotionalDepthScore,
      int latencyMs,
      bool cached,
      bool wasFallback});
}

/// @nodoc
class __$$AiMetadataImplCopyWithImpl<$Res>
    extends _$AiMetadataCopyWithImpl<$Res, _$AiMetadataImpl>
    implements _$$AiMetadataImplCopyWith<$Res> {
  __$$AiMetadataImplCopyWithImpl(
      _$AiMetadataImpl _value, $Res Function(_$AiMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modelUsed = null,
    Object? emotionalDepthScore = null,
    Object? latencyMs = null,
    Object? cached = null,
    Object? wasFallback = null,
  }) {
    return _then(_$AiMetadataImpl(
      modelUsed: null == modelUsed
          ? _value.modelUsed
          : modelUsed // ignore: cast_nullable_to_non_nullable
              as String,
      emotionalDepthScore: null == emotionalDepthScore
          ? _value.emotionalDepthScore
          : emotionalDepthScore // ignore: cast_nullable_to_non_nullable
              as int,
      latencyMs: null == latencyMs
          ? _value.latencyMs
          : latencyMs // ignore: cast_nullable_to_non_nullable
              as int,
      cached: null == cached
          ? _value.cached
          : cached // ignore: cast_nullable_to_non_nullable
              as bool,
      wasFallback: null == wasFallback
          ? _value.wasFallback
          : wasFallback // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AiMetadataImpl implements _AiMetadata {
  const _$AiMetadataImpl(
      {required this.modelUsed,
      required this.emotionalDepthScore,
      required this.latencyMs,
      this.cached = false,
      this.wasFallback = false});

  factory _$AiMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiMetadataImplFromJson(json);

  @override
  final String modelUsed;
  @override
  final int emotionalDepthScore;
  @override
  final int latencyMs;
  @override
  @JsonKey()
  final bool cached;
  @override
  @JsonKey()
  final bool wasFallback;

  @override
  String toString() {
    return 'AiMetadata(modelUsed: $modelUsed, emotionalDepthScore: $emotionalDepthScore, latencyMs: $latencyMs, cached: $cached, wasFallback: $wasFallback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiMetadataImpl &&
            (identical(other.modelUsed, modelUsed) ||
                other.modelUsed == modelUsed) &&
            (identical(other.emotionalDepthScore, emotionalDepthScore) ||
                other.emotionalDepthScore == emotionalDepthScore) &&
            (identical(other.latencyMs, latencyMs) ||
                other.latencyMs == latencyMs) &&
            (identical(other.cached, cached) || other.cached == cached) &&
            (identical(other.wasFallback, wasFallback) ||
                other.wasFallback == wasFallback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, modelUsed, emotionalDepthScore,
      latencyMs, cached, wasFallback);

  /// Create a copy of AiMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiMetadataImplCopyWith<_$AiMetadataImpl> get copyWith =>
      __$$AiMetadataImplCopyWithImpl<_$AiMetadataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiMetadataImplToJson(
      this,
    );
  }
}

abstract class _AiMetadata implements AiMetadata {
  const factory _AiMetadata(
      {required final String modelUsed,
      required final int emotionalDepthScore,
      required final int latencyMs,
      final bool cached,
      final bool wasFallback}) = _$AiMetadataImpl;

  factory _AiMetadata.fromJson(Map<String, dynamic> json) =
      _$AiMetadataImpl.fromJson;

  @override
  String get modelUsed;
  @override
  int get emotionalDepthScore;
  @override
  int get latencyMs;
  @override
  bool get cached;
  @override
  bool get wasFallback;

  /// Create a copy of AiMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiMetadataImplCopyWith<_$AiMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiUsageInfo _$AiUsageInfoFromJson(Map<String, dynamic> json) {
  return _AiUsageInfo.fromJson(json);
}

/// @nodoc
mixin _$AiUsageInfo {
  int get used => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get remaining => throw _privateConstructorUsedError;
  DateTime get resetsAt => throw _privateConstructorUsedError;

  /// Serializes this AiUsageInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiUsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiUsageInfoCopyWith<AiUsageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiUsageInfoCopyWith<$Res> {
  factory $AiUsageInfoCopyWith(
          AiUsageInfo value, $Res Function(AiUsageInfo) then) =
      _$AiUsageInfoCopyWithImpl<$Res, AiUsageInfo>;
  @useResult
  $Res call({int used, int limit, int remaining, DateTime resetsAt});
}

/// @nodoc
class _$AiUsageInfoCopyWithImpl<$Res, $Val extends AiUsageInfo>
    implements $AiUsageInfoCopyWith<$Res> {
  _$AiUsageInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiUsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? used = null,
    Object? limit = null,
    Object? remaining = null,
    Object? resetsAt = null,
  }) {
    return _then(_value.copyWith(
      used: null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int,
      resetsAt: null == resetsAt
          ? _value.resetsAt
          : resetsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiUsageInfoImplCopyWith<$Res>
    implements $AiUsageInfoCopyWith<$Res> {
  factory _$$AiUsageInfoImplCopyWith(
          _$AiUsageInfoImpl value, $Res Function(_$AiUsageInfoImpl) then) =
      __$$AiUsageInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int used, int limit, int remaining, DateTime resetsAt});
}

/// @nodoc
class __$$AiUsageInfoImplCopyWithImpl<$Res>
    extends _$AiUsageInfoCopyWithImpl<$Res, _$AiUsageInfoImpl>
    implements _$$AiUsageInfoImplCopyWith<$Res> {
  __$$AiUsageInfoImplCopyWithImpl(
      _$AiUsageInfoImpl _value, $Res Function(_$AiUsageInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiUsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? used = null,
    Object? limit = null,
    Object? remaining = null,
    Object? resetsAt = null,
  }) {
    return _then(_$AiUsageInfoImpl(
      used: null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int,
      resetsAt: null == resetsAt
          ? _value.resetsAt
          : resetsAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AiUsageInfoImpl implements _AiUsageInfo {
  const _$AiUsageInfoImpl(
      {required this.used,
      required this.limit,
      required this.remaining,
      required this.resetsAt});

  factory _$AiUsageInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiUsageInfoImplFromJson(json);

  @override
  final int used;
  @override
  final int limit;
  @override
  final int remaining;
  @override
  final DateTime resetsAt;

  @override
  String toString() {
    return 'AiUsageInfo(used: $used, limit: $limit, remaining: $remaining, resetsAt: $resetsAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiUsageInfoImpl &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.resetsAt, resetsAt) ||
                other.resetsAt == resetsAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, used, limit, remaining, resetsAt);

  /// Create a copy of AiUsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiUsageInfoImplCopyWith<_$AiUsageInfoImpl> get copyWith =>
      __$$AiUsageInfoImplCopyWithImpl<_$AiUsageInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiUsageInfoImplToJson(
      this,
    );
  }
}

abstract class _AiUsageInfo implements AiUsageInfo {
  const factory _AiUsageInfo(
      {required final int used,
      required final int limit,
      required final int remaining,
      required final DateTime resetsAt}) = _$AiUsageInfoImpl;

  factory _AiUsageInfo.fromJson(Map<String, dynamic> json) =
      _$AiUsageInfoImpl.fromJson;

  @override
  int get used;
  @override
  int get limit;
  @override
  int get remaining;
  @override
  DateTime get resetsAt;

  /// Create a copy of AiUsageInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiUsageInfoImplCopyWith<_$AiUsageInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GiftRecommendation _$GiftRecommendationFromJson(Map<String, dynamic> json) {
  return _GiftRecommendation.fromJson(json);
}

/// @nodoc
mixin _$GiftRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  GiftPrice get estimatedPrice => throw _privateConstructorUsedError;
  String get personalizedReasoning => throw _privateConstructorUsedError;
  List<String> get whereToBuy => throw _privateConstructorUsedError;
  String get imageCategory => throw _privateConstructorUsedError;
  String get giftType => throw _privateConstructorUsedError;
  bool get culturallyAppropriate => throw _privateConstructorUsedError;
  double get matchScore => throw _privateConstructorUsedError;
  List<String> get pairsWith => throw _privateConstructorUsedError;

  /// Serializes this GiftRecommendation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftRecommendationCopyWith<GiftRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftRecommendationCopyWith<$Res> {
  factory $GiftRecommendationCopyWith(
          GiftRecommendation value, $Res Function(GiftRecommendation) then) =
      _$GiftRecommendationCopyWithImpl<$Res, GiftRecommendation>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String category,
      GiftPrice estimatedPrice,
      String personalizedReasoning,
      List<String> whereToBuy,
      String imageCategory,
      String giftType,
      bool culturallyAppropriate,
      double matchScore,
      List<String> pairsWith});

  $GiftPriceCopyWith<$Res> get estimatedPrice;
}

/// @nodoc
class _$GiftRecommendationCopyWithImpl<$Res, $Val extends GiftRecommendation>
    implements $GiftRecommendationCopyWith<$Res> {
  _$GiftRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? estimatedPrice = null,
    Object? personalizedReasoning = null,
    Object? whereToBuy = null,
    Object? imageCategory = null,
    Object? giftType = null,
    Object? culturallyAppropriate = null,
    Object? matchScore = null,
    Object? pairsWith = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedPrice: null == estimatedPrice
          ? _value.estimatedPrice
          : estimatedPrice // ignore: cast_nullable_to_non_nullable
              as GiftPrice,
      personalizedReasoning: null == personalizedReasoning
          ? _value.personalizedReasoning
          : personalizedReasoning // ignore: cast_nullable_to_non_nullable
              as String,
      whereToBuy: null == whereToBuy
          ? _value.whereToBuy
          : whereToBuy // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageCategory: null == imageCategory
          ? _value.imageCategory
          : imageCategory // ignore: cast_nullable_to_non_nullable
              as String,
      giftType: null == giftType
          ? _value.giftType
          : giftType // ignore: cast_nullable_to_non_nullable
              as String,
      culturallyAppropriate: null == culturallyAppropriate
          ? _value.culturallyAppropriate
          : culturallyAppropriate // ignore: cast_nullable_to_non_nullable
              as bool,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      pairsWith: null == pairsWith
          ? _value.pairsWith
          : pairsWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  /// Create a copy of GiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GiftPriceCopyWith<$Res> get estimatedPrice {
    return $GiftPriceCopyWith<$Res>(_value.estimatedPrice, (value) {
      return _then(_value.copyWith(estimatedPrice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GiftRecommendationImplCopyWith<$Res>
    implements $GiftRecommendationCopyWith<$Res> {
  factory _$$GiftRecommendationImplCopyWith(_$GiftRecommendationImpl value,
          $Res Function(_$GiftRecommendationImpl) then) =
      __$$GiftRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String category,
      GiftPrice estimatedPrice,
      String personalizedReasoning,
      List<String> whereToBuy,
      String imageCategory,
      String giftType,
      bool culturallyAppropriate,
      double matchScore,
      List<String> pairsWith});

  @override
  $GiftPriceCopyWith<$Res> get estimatedPrice;
}

/// @nodoc
class __$$GiftRecommendationImplCopyWithImpl<$Res>
    extends _$GiftRecommendationCopyWithImpl<$Res, _$GiftRecommendationImpl>
    implements _$$GiftRecommendationImplCopyWith<$Res> {
  __$$GiftRecommendationImplCopyWithImpl(_$GiftRecommendationImpl _value,
      $Res Function(_$GiftRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? estimatedPrice = null,
    Object? personalizedReasoning = null,
    Object? whereToBuy = null,
    Object? imageCategory = null,
    Object? giftType = null,
    Object? culturallyAppropriate = null,
    Object? matchScore = null,
    Object? pairsWith = null,
  }) {
    return _then(_$GiftRecommendationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedPrice: null == estimatedPrice
          ? _value.estimatedPrice
          : estimatedPrice // ignore: cast_nullable_to_non_nullable
              as GiftPrice,
      personalizedReasoning: null == personalizedReasoning
          ? _value.personalizedReasoning
          : personalizedReasoning // ignore: cast_nullable_to_non_nullable
              as String,
      whereToBuy: null == whereToBuy
          ? _value._whereToBuy
          : whereToBuy // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageCategory: null == imageCategory
          ? _value.imageCategory
          : imageCategory // ignore: cast_nullable_to_non_nullable
              as String,
      giftType: null == giftType
          ? _value.giftType
          : giftType // ignore: cast_nullable_to_non_nullable
              as String,
      culturallyAppropriate: null == culturallyAppropriate
          ? _value.culturallyAppropriate
          : culturallyAppropriate // ignore: cast_nullable_to_non_nullable
              as bool,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      pairsWith: null == pairsWith
          ? _value._pairsWith
          : pairsWith // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftRecommendationImpl implements _GiftRecommendation {
  const _$GiftRecommendationImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.estimatedPrice,
      required this.personalizedReasoning,
      required final List<String> whereToBuy,
      required this.imageCategory,
      required this.giftType,
      this.culturallyAppropriate = true,
      this.matchScore = 0.0,
      final List<String> pairsWith = const []})
      : _whereToBuy = whereToBuy,
        _pairsWith = pairsWith;

  factory _$GiftRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String category;
  @override
  final GiftPrice estimatedPrice;
  @override
  final String personalizedReasoning;
  final List<String> _whereToBuy;
  @override
  List<String> get whereToBuy {
    if (_whereToBuy is EqualUnmodifiableListView) return _whereToBuy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_whereToBuy);
  }

  @override
  final String imageCategory;
  @override
  final String giftType;
  @override
  @JsonKey()
  final bool culturallyAppropriate;
  @override
  @JsonKey()
  final double matchScore;
  final List<String> _pairsWith;
  @override
  @JsonKey()
  List<String> get pairsWith {
    if (_pairsWith is EqualUnmodifiableListView) return _pairsWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pairsWith);
  }

  @override
  String toString() {
    return 'GiftRecommendation(id: $id, name: $name, description: $description, category: $category, estimatedPrice: $estimatedPrice, personalizedReasoning: $personalizedReasoning, whereToBuy: $whereToBuy, imageCategory: $imageCategory, giftType: $giftType, culturallyAppropriate: $culturallyAppropriate, matchScore: $matchScore, pairsWith: $pairsWith)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.estimatedPrice, estimatedPrice) ||
                other.estimatedPrice == estimatedPrice) &&
            (identical(other.personalizedReasoning, personalizedReasoning) ||
                other.personalizedReasoning == personalizedReasoning) &&
            const DeepCollectionEquality()
                .equals(other._whereToBuy, _whereToBuy) &&
            (identical(other.imageCategory, imageCategory) ||
                other.imageCategory == imageCategory) &&
            (identical(other.giftType, giftType) ||
                other.giftType == giftType) &&
            (identical(other.culturallyAppropriate, culturallyAppropriate) ||
                other.culturallyAppropriate == culturallyAppropriate) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            const DeepCollectionEquality()
                .equals(other._pairsWith, _pairsWith));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      category,
      estimatedPrice,
      personalizedReasoning,
      const DeepCollectionEquality().hash(_whereToBuy),
      imageCategory,
      giftType,
      culturallyAppropriate,
      matchScore,
      const DeepCollectionEquality().hash(_pairsWith));

  /// Create a copy of GiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftRecommendationImplCopyWith<_$GiftRecommendationImpl> get copyWith =>
      __$$GiftRecommendationImplCopyWithImpl<_$GiftRecommendationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftRecommendationImplToJson(
      this,
    );
  }
}

abstract class _GiftRecommendation implements GiftRecommendation {
  const factory _GiftRecommendation(
      {required final String id,
      required final String name,
      required final String description,
      required final String category,
      required final GiftPrice estimatedPrice,
      required final String personalizedReasoning,
      required final List<String> whereToBuy,
      required final String imageCategory,
      required final String giftType,
      final bool culturallyAppropriate,
      final double matchScore,
      final List<String> pairsWith}) = _$GiftRecommendationImpl;

  factory _GiftRecommendation.fromJson(Map<String, dynamic> json) =
      _$GiftRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get category;
  @override
  GiftPrice get estimatedPrice;
  @override
  String get personalizedReasoning;
  @override
  List<String> get whereToBuy;
  @override
  String get imageCategory;
  @override
  String get giftType;
  @override
  bool get culturallyAppropriate;
  @override
  double get matchScore;
  @override
  List<String> get pairsWith;

  /// Create a copy of GiftRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftRecommendationImplCopyWith<_$GiftRecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GiftPrice _$GiftPriceFromJson(Map<String, dynamic> json) {
  return _GiftPrice.fromJson(json);
}

/// @nodoc
mixin _$GiftPrice {
  double get min => throw _privateConstructorUsedError;
  double get max => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  /// Serializes this GiftPrice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftPriceCopyWith<GiftPrice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftPriceCopyWith<$Res> {
  factory $GiftPriceCopyWith(GiftPrice value, $Res Function(GiftPrice) then) =
      _$GiftPriceCopyWithImpl<$Res, GiftPrice>;
  @useResult
  $Res call({double min, double max, String currency});
}

/// @nodoc
class _$GiftPriceCopyWithImpl<$Res, $Val extends GiftPrice>
    implements $GiftPriceCopyWith<$Res> {
  _$GiftPriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? currency = null,
  }) {
    return _then(_value.copyWith(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GiftPriceImplCopyWith<$Res>
    implements $GiftPriceCopyWith<$Res> {
  factory _$$GiftPriceImplCopyWith(
          _$GiftPriceImpl value, $Res Function(_$GiftPriceImpl) then) =
      __$$GiftPriceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double min, double max, String currency});
}

/// @nodoc
class __$$GiftPriceImplCopyWithImpl<$Res>
    extends _$GiftPriceCopyWithImpl<$Res, _$GiftPriceImpl>
    implements _$$GiftPriceImplCopyWith<$Res> {
  __$$GiftPriceImplCopyWithImpl(
      _$GiftPriceImpl _value, $Res Function(_$GiftPriceImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftPrice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? currency = null,
  }) {
    return _then(_$GiftPriceImpl(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftPriceImpl implements _GiftPrice {
  const _$GiftPriceImpl(
      {required this.min, required this.max, this.currency = 'USD'});

  factory _$GiftPriceImpl.fromJson(Map<String, dynamic> json) =>
      _$$GiftPriceImplFromJson(json);

  @override
  final double min;
  @override
  final double max;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'GiftPrice(min: $min, max: $max, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftPriceImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max, currency);

  /// Create a copy of GiftPrice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftPriceImplCopyWith<_$GiftPriceImpl> get copyWith =>
      __$$GiftPriceImplCopyWithImpl<_$GiftPriceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftPriceImplToJson(
      this,
    );
  }
}

abstract class _GiftPrice implements GiftPrice {
  const factory _GiftPrice(
      {required final double min,
      required final double max,
      final String currency}) = _$GiftPriceImpl;

  factory _GiftPrice.fromJson(Map<String, dynamic> json) =
      _$GiftPriceImpl.fromJson;

  @override
  double get min;
  @override
  double get max;
  @override
  String get currency;

  /// Create a copy of GiftPrice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftPriceImplCopyWith<_$GiftPriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GiftRecommendationResponse _$GiftRecommendationResponseFromJson(
    Map<String, dynamic> json) {
  return _GiftRecommendationResponse.fromJson(json);
}

/// @nodoc
mixin _$GiftRecommendationResponse {
  List<GiftRecommendation> get recommendations =>
      throw _privateConstructorUsedError;
  AiMetadata get metadata => throw _privateConstructorUsedError;
  AiUsageInfo get usage => throw _privateConstructorUsedError;

  /// Serializes this GiftRecommendationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GiftRecommendationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GiftRecommendationResponseCopyWith<GiftRecommendationResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GiftRecommendationResponseCopyWith<$Res> {
  factory $GiftRecommendationResponseCopyWith(GiftRecommendationResponse value,
          $Res Function(GiftRecommendationResponse) then) =
      _$GiftRecommendationResponseCopyWithImpl<$Res,
          GiftRecommendationResponse>;
  @useResult
  $Res call(
      {List<GiftRecommendation> recommendations,
      AiMetadata metadata,
      AiUsageInfo usage});

  $AiMetadataCopyWith<$Res> get metadata;
  $AiUsageInfoCopyWith<$Res> get usage;
}

/// @nodoc
class _$GiftRecommendationResponseCopyWithImpl<$Res,
        $Val extends GiftRecommendationResponse>
    implements $GiftRecommendationResponseCopyWith<$Res> {
  _$GiftRecommendationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GiftRecommendationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recommendations = null,
    Object? metadata = null,
    Object? usage = null,
  }) {
    return _then(_value.copyWith(
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<GiftRecommendation>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as AiMetadata,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as AiUsageInfo,
    ) as $Val);
  }

  /// Create a copy of GiftRecommendationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AiMetadataCopyWith<$Res> get metadata {
    return $AiMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }

  /// Create a copy of GiftRecommendationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AiUsageInfoCopyWith<$Res> get usage {
    return $AiUsageInfoCopyWith<$Res>(_value.usage, (value) {
      return _then(_value.copyWith(usage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GiftRecommendationResponseImplCopyWith<$Res>
    implements $GiftRecommendationResponseCopyWith<$Res> {
  factory _$$GiftRecommendationResponseImplCopyWith(
          _$GiftRecommendationResponseImpl value,
          $Res Function(_$GiftRecommendationResponseImpl) then) =
      __$$GiftRecommendationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<GiftRecommendation> recommendations,
      AiMetadata metadata,
      AiUsageInfo usage});

  @override
  $AiMetadataCopyWith<$Res> get metadata;
  @override
  $AiUsageInfoCopyWith<$Res> get usage;
}

/// @nodoc
class __$$GiftRecommendationResponseImplCopyWithImpl<$Res>
    extends _$GiftRecommendationResponseCopyWithImpl<$Res,
        _$GiftRecommendationResponseImpl>
    implements _$$GiftRecommendationResponseImplCopyWith<$Res> {
  __$$GiftRecommendationResponseImplCopyWithImpl(
      _$GiftRecommendationResponseImpl _value,
      $Res Function(_$GiftRecommendationResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GiftRecommendationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recommendations = null,
    Object? metadata = null,
    Object? usage = null,
  }) {
    return _then(_$GiftRecommendationResponseImpl(
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<GiftRecommendation>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as AiMetadata,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as AiUsageInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GiftRecommendationResponseImpl implements _GiftRecommendationResponse {
  const _$GiftRecommendationResponseImpl(
      {required final List<GiftRecommendation> recommendations,
      required this.metadata,
      required this.usage})
      : _recommendations = recommendations;

  factory _$GiftRecommendationResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GiftRecommendationResponseImplFromJson(json);

  final List<GiftRecommendation> _recommendations;
  @override
  List<GiftRecommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final AiMetadata metadata;
  @override
  final AiUsageInfo usage;

  @override
  String toString() {
    return 'GiftRecommendationResponse(recommendations: $recommendations, metadata: $metadata, usage: $usage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GiftRecommendationResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_recommendations), metadata, usage);

  /// Create a copy of GiftRecommendationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GiftRecommendationResponseImplCopyWith<_$GiftRecommendationResponseImpl>
      get copyWith => __$$GiftRecommendationResponseImplCopyWithImpl<
          _$GiftRecommendationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GiftRecommendationResponseImplToJson(
      this,
    );
  }
}

abstract class _GiftRecommendationResponse
    implements GiftRecommendationResponse {
  const factory _GiftRecommendationResponse(
      {required final List<GiftRecommendation> recommendations,
      required final AiMetadata metadata,
      required final AiUsageInfo usage}) = _$GiftRecommendationResponseImpl;

  factory _GiftRecommendationResponse.fromJson(Map<String, dynamic> json) =
      _$GiftRecommendationResponseImpl.fromJson;

  @override
  List<GiftRecommendation> get recommendations;
  @override
  AiMetadata get metadata;
  @override
  AiUsageInfo get usage;

  /// Create a copy of GiftRecommendationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GiftRecommendationResponseImplCopyWith<_$GiftRecommendationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SosActivateResponse _$SosActivateResponseFromJson(Map<String, dynamic> json) {
  return _SosActivateResponse.fromJson(json);
}

/// @nodoc
mixin _$SosActivateResponse {
  String get sessionId => throw _privateConstructorUsedError;
  String get scenario => throw _privateConstructorUsedError;
  String get urgency => throw _privateConstructorUsedError;
  SosImmediateAdvice get immediateAdvice => throw _privateConstructorUsedError;
  bool get severityAssessmentRequired => throw _privateConstructorUsedError;
  int get estimatedResolutionSteps => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SosActivateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosActivateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosActivateResponseCopyWith<SosActivateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosActivateResponseCopyWith<$Res> {
  factory $SosActivateResponseCopyWith(
          SosActivateResponse value, $Res Function(SosActivateResponse) then) =
      _$SosActivateResponseCopyWithImpl<$Res, SosActivateResponse>;
  @useResult
  $Res call(
      {String sessionId,
      String scenario,
      String urgency,
      SosImmediateAdvice immediateAdvice,
      bool severityAssessmentRequired,
      int estimatedResolutionSteps,
      DateTime createdAt});

  $SosImmediateAdviceCopyWith<$Res> get immediateAdvice;
}

/// @nodoc
class _$SosActivateResponseCopyWithImpl<$Res, $Val extends SosActivateResponse>
    implements $SosActivateResponseCopyWith<$Res> {
  _$SosActivateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosActivateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? scenario = null,
    Object? urgency = null,
    Object? immediateAdvice = null,
    Object? severityAssessmentRequired = null,
    Object? estimatedResolutionSteps = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      scenario: null == scenario
          ? _value.scenario
          : scenario // ignore: cast_nullable_to_non_nullable
              as String,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as String,
      immediateAdvice: null == immediateAdvice
          ? _value.immediateAdvice
          : immediateAdvice // ignore: cast_nullable_to_non_nullable
              as SosImmediateAdvice,
      severityAssessmentRequired: null == severityAssessmentRequired
          ? _value.severityAssessmentRequired
          : severityAssessmentRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      estimatedResolutionSteps: null == estimatedResolutionSteps
          ? _value.estimatedResolutionSteps
          : estimatedResolutionSteps // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of SosActivateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosImmediateAdviceCopyWith<$Res> get immediateAdvice {
    return $SosImmediateAdviceCopyWith<$Res>(_value.immediateAdvice, (value) {
      return _then(_value.copyWith(immediateAdvice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SosActivateResponseImplCopyWith<$Res>
    implements $SosActivateResponseCopyWith<$Res> {
  factory _$$SosActivateResponseImplCopyWith(_$SosActivateResponseImpl value,
          $Res Function(_$SosActivateResponseImpl) then) =
      __$$SosActivateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      String scenario,
      String urgency,
      SosImmediateAdvice immediateAdvice,
      bool severityAssessmentRequired,
      int estimatedResolutionSteps,
      DateTime createdAt});

  @override
  $SosImmediateAdviceCopyWith<$Res> get immediateAdvice;
}

/// @nodoc
class __$$SosActivateResponseImplCopyWithImpl<$Res>
    extends _$SosActivateResponseCopyWithImpl<$Res, _$SosActivateResponseImpl>
    implements _$$SosActivateResponseImplCopyWith<$Res> {
  __$$SosActivateResponseImplCopyWithImpl(_$SosActivateResponseImpl _value,
      $Res Function(_$SosActivateResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosActivateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? scenario = null,
    Object? urgency = null,
    Object? immediateAdvice = null,
    Object? severityAssessmentRequired = null,
    Object? estimatedResolutionSteps = null,
    Object? createdAt = null,
  }) {
    return _then(_$SosActivateResponseImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      scenario: null == scenario
          ? _value.scenario
          : scenario // ignore: cast_nullable_to_non_nullable
              as String,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as String,
      immediateAdvice: null == immediateAdvice
          ? _value.immediateAdvice
          : immediateAdvice // ignore: cast_nullable_to_non_nullable
              as SosImmediateAdvice,
      severityAssessmentRequired: null == severityAssessmentRequired
          ? _value.severityAssessmentRequired
          : severityAssessmentRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      estimatedResolutionSteps: null == estimatedResolutionSteps
          ? _value.estimatedResolutionSteps
          : estimatedResolutionSteps // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosActivateResponseImpl implements _SosActivateResponse {
  const _$SosActivateResponseImpl(
      {required this.sessionId,
      required this.scenario,
      required this.urgency,
      required this.immediateAdvice,
      this.severityAssessmentRequired = true,
      this.estimatedResolutionSteps = 4,
      required this.createdAt});

  factory _$SosActivateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosActivateResponseImplFromJson(json);

  @override
  final String sessionId;
  @override
  final String scenario;
  @override
  final String urgency;
  @override
  final SosImmediateAdvice immediateAdvice;
  @override
  @JsonKey()
  final bool severityAssessmentRequired;
  @override
  @JsonKey()
  final int estimatedResolutionSteps;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'SosActivateResponse(sessionId: $sessionId, scenario: $scenario, urgency: $urgency, immediateAdvice: $immediateAdvice, severityAssessmentRequired: $severityAssessmentRequired, estimatedResolutionSteps: $estimatedResolutionSteps, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosActivateResponseImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.scenario, scenario) ||
                other.scenario == scenario) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.immediateAdvice, immediateAdvice) ||
                other.immediateAdvice == immediateAdvice) &&
            (identical(other.severityAssessmentRequired,
                    severityAssessmentRequired) ||
                other.severityAssessmentRequired ==
                    severityAssessmentRequired) &&
            (identical(
                    other.estimatedResolutionSteps, estimatedResolutionSteps) ||
                other.estimatedResolutionSteps == estimatedResolutionSteps) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionId,
      scenario,
      urgency,
      immediateAdvice,
      severityAssessmentRequired,
      estimatedResolutionSteps,
      createdAt);

  /// Create a copy of SosActivateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosActivateResponseImplCopyWith<_$SosActivateResponseImpl> get copyWith =>
      __$$SosActivateResponseImplCopyWithImpl<_$SosActivateResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosActivateResponseImplToJson(
      this,
    );
  }
}

abstract class _SosActivateResponse implements SosActivateResponse {
  const factory _SosActivateResponse(
      {required final String sessionId,
      required final String scenario,
      required final String urgency,
      required final SosImmediateAdvice immediateAdvice,
      final bool severityAssessmentRequired,
      final int estimatedResolutionSteps,
      required final DateTime createdAt}) = _$SosActivateResponseImpl;

  factory _SosActivateResponse.fromJson(Map<String, dynamic> json) =
      _$SosActivateResponseImpl.fromJson;

  @override
  String get sessionId;
  @override
  String get scenario;
  @override
  String get urgency;
  @override
  SosImmediateAdvice get immediateAdvice;
  @override
  bool get severityAssessmentRequired;
  @override
  int get estimatedResolutionSteps;
  @override
  DateTime get createdAt;

  /// Create a copy of SosActivateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosActivateResponseImplCopyWith<_$SosActivateResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SosImmediateAdvice _$SosImmediateAdviceFromJson(Map<String, dynamic> json) {
  return _SosImmediateAdvice.fromJson(json);
}

/// @nodoc
mixin _$SosImmediateAdvice {
  String get doNow => throw _privateConstructorUsedError;
  String get doNotDo => throw _privateConstructorUsedError;
  String get bodyLanguage => throw _privateConstructorUsedError;

  /// Serializes this SosImmediateAdvice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosImmediateAdviceCopyWith<SosImmediateAdvice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosImmediateAdviceCopyWith<$Res> {
  factory $SosImmediateAdviceCopyWith(
          SosImmediateAdvice value, $Res Function(SosImmediateAdvice) then) =
      _$SosImmediateAdviceCopyWithImpl<$Res, SosImmediateAdvice>;
  @useResult
  $Res call({String doNow, String doNotDo, String bodyLanguage});
}

/// @nodoc
class _$SosImmediateAdviceCopyWithImpl<$Res, $Val extends SosImmediateAdvice>
    implements $SosImmediateAdviceCopyWith<$Res> {
  _$SosImmediateAdviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doNow = null,
    Object? doNotDo = null,
    Object? bodyLanguage = null,
  }) {
    return _then(_value.copyWith(
      doNow: null == doNow
          ? _value.doNow
          : doNow // ignore: cast_nullable_to_non_nullable
              as String,
      doNotDo: null == doNotDo
          ? _value.doNotDo
          : doNotDo // ignore: cast_nullable_to_non_nullable
              as String,
      bodyLanguage: null == bodyLanguage
          ? _value.bodyLanguage
          : bodyLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosImmediateAdviceImplCopyWith<$Res>
    implements $SosImmediateAdviceCopyWith<$Res> {
  factory _$$SosImmediateAdviceImplCopyWith(_$SosImmediateAdviceImpl value,
          $Res Function(_$SosImmediateAdviceImpl) then) =
      __$$SosImmediateAdviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String doNow, String doNotDo, String bodyLanguage});
}

/// @nodoc
class __$$SosImmediateAdviceImplCopyWithImpl<$Res>
    extends _$SosImmediateAdviceCopyWithImpl<$Res, _$SosImmediateAdviceImpl>
    implements _$$SosImmediateAdviceImplCopyWith<$Res> {
  __$$SosImmediateAdviceImplCopyWithImpl(_$SosImmediateAdviceImpl _value,
      $Res Function(_$SosImmediateAdviceImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doNow = null,
    Object? doNotDo = null,
    Object? bodyLanguage = null,
  }) {
    return _then(_$SosImmediateAdviceImpl(
      doNow: null == doNow
          ? _value.doNow
          : doNow // ignore: cast_nullable_to_non_nullable
              as String,
      doNotDo: null == doNotDo
          ? _value.doNotDo
          : doNotDo // ignore: cast_nullable_to_non_nullable
              as String,
      bodyLanguage: null == bodyLanguage
          ? _value.bodyLanguage
          : bodyLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosImmediateAdviceImpl implements _SosImmediateAdvice {
  const _$SosImmediateAdviceImpl(
      {required this.doNow, required this.doNotDo, required this.bodyLanguage});

  factory _$SosImmediateAdviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosImmediateAdviceImplFromJson(json);

  @override
  final String doNow;
  @override
  final String doNotDo;
  @override
  final String bodyLanguage;

  @override
  String toString() {
    return 'SosImmediateAdvice(doNow: $doNow, doNotDo: $doNotDo, bodyLanguage: $bodyLanguage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosImmediateAdviceImpl &&
            (identical(other.doNow, doNow) || other.doNow == doNow) &&
            (identical(other.doNotDo, doNotDo) || other.doNotDo == doNotDo) &&
            (identical(other.bodyLanguage, bodyLanguage) ||
                other.bodyLanguage == bodyLanguage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, doNow, doNotDo, bodyLanguage);

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosImmediateAdviceImplCopyWith<_$SosImmediateAdviceImpl> get copyWith =>
      __$$SosImmediateAdviceImplCopyWithImpl<_$SosImmediateAdviceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosImmediateAdviceImplToJson(
      this,
    );
  }
}

abstract class _SosImmediateAdvice implements SosImmediateAdvice {
  const factory _SosImmediateAdvice(
      {required final String doNow,
      required final String doNotDo,
      required final String bodyLanguage}) = _$SosImmediateAdviceImpl;

  factory _SosImmediateAdvice.fromJson(Map<String, dynamic> json) =
      _$SosImmediateAdviceImpl.fromJson;

  @override
  String get doNow;
  @override
  String get doNotDo;
  @override
  String get bodyLanguage;

  /// Create a copy of SosImmediateAdvice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosImmediateAdviceImplCopyWith<_$SosImmediateAdviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SosAssessResponse _$SosAssessResponseFromJson(Map<String, dynamic> json) {
  return _SosAssessResponse.fromJson(json);
}

/// @nodoc
mixin _$SosAssessResponse {
  String get sessionId => throw _privateConstructorUsedError;
  int get severityScore => throw _privateConstructorUsedError;
  String get severityLabel => throw _privateConstructorUsedError;
  SosCoachingPlan get coachingPlan => throw _privateConstructorUsedError;

  /// Serializes this SosAssessResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosAssessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosAssessResponseCopyWith<SosAssessResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosAssessResponseCopyWith<$Res> {
  factory $SosAssessResponseCopyWith(
          SosAssessResponse value, $Res Function(SosAssessResponse) then) =
      _$SosAssessResponseCopyWithImpl<$Res, SosAssessResponse>;
  @useResult
  $Res call(
      {String sessionId,
      int severityScore,
      String severityLabel,
      SosCoachingPlan coachingPlan});

  $SosCoachingPlanCopyWith<$Res> get coachingPlan;
}

/// @nodoc
class _$SosAssessResponseCopyWithImpl<$Res, $Val extends SosAssessResponse>
    implements $SosAssessResponseCopyWith<$Res> {
  _$SosAssessResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosAssessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? severityScore = null,
    Object? severityLabel = null,
    Object? coachingPlan = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      severityScore: null == severityScore
          ? _value.severityScore
          : severityScore // ignore: cast_nullable_to_non_nullable
              as int,
      severityLabel: null == severityLabel
          ? _value.severityLabel
          : severityLabel // ignore: cast_nullable_to_non_nullable
              as String,
      coachingPlan: null == coachingPlan
          ? _value.coachingPlan
          : coachingPlan // ignore: cast_nullable_to_non_nullable
              as SosCoachingPlan,
    ) as $Val);
  }

  /// Create a copy of SosAssessResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosCoachingPlanCopyWith<$Res> get coachingPlan {
    return $SosCoachingPlanCopyWith<$Res>(_value.coachingPlan, (value) {
      return _then(_value.copyWith(coachingPlan: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SosAssessResponseImplCopyWith<$Res>
    implements $SosAssessResponseCopyWith<$Res> {
  factory _$$SosAssessResponseImplCopyWith(_$SosAssessResponseImpl value,
          $Res Function(_$SosAssessResponseImpl) then) =
      __$$SosAssessResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      int severityScore,
      String severityLabel,
      SosCoachingPlan coachingPlan});

  @override
  $SosCoachingPlanCopyWith<$Res> get coachingPlan;
}

/// @nodoc
class __$$SosAssessResponseImplCopyWithImpl<$Res>
    extends _$SosAssessResponseCopyWithImpl<$Res, _$SosAssessResponseImpl>
    implements _$$SosAssessResponseImplCopyWith<$Res> {
  __$$SosAssessResponseImplCopyWithImpl(_$SosAssessResponseImpl _value,
      $Res Function(_$SosAssessResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosAssessResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? severityScore = null,
    Object? severityLabel = null,
    Object? coachingPlan = null,
  }) {
    return _then(_$SosAssessResponseImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      severityScore: null == severityScore
          ? _value.severityScore
          : severityScore // ignore: cast_nullable_to_non_nullable
              as int,
      severityLabel: null == severityLabel
          ? _value.severityLabel
          : severityLabel // ignore: cast_nullable_to_non_nullable
              as String,
      coachingPlan: null == coachingPlan
          ? _value.coachingPlan
          : coachingPlan // ignore: cast_nullable_to_non_nullable
              as SosCoachingPlan,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosAssessResponseImpl implements _SosAssessResponse {
  const _$SosAssessResponseImpl(
      {required this.sessionId,
      required this.severityScore,
      required this.severityLabel,
      required this.coachingPlan});

  factory _$SosAssessResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosAssessResponseImplFromJson(json);

  @override
  final String sessionId;
  @override
  final int severityScore;
  @override
  final String severityLabel;
  @override
  final SosCoachingPlan coachingPlan;

  @override
  String toString() {
    return 'SosAssessResponse(sessionId: $sessionId, severityScore: $severityScore, severityLabel: $severityLabel, coachingPlan: $coachingPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosAssessResponseImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.severityScore, severityScore) ||
                other.severityScore == severityScore) &&
            (identical(other.severityLabel, severityLabel) ||
                other.severityLabel == severityLabel) &&
            (identical(other.coachingPlan, coachingPlan) ||
                other.coachingPlan == coachingPlan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sessionId, severityScore, severityLabel, coachingPlan);

  /// Create a copy of SosAssessResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosAssessResponseImplCopyWith<_$SosAssessResponseImpl> get copyWith =>
      __$$SosAssessResponseImplCopyWithImpl<_$SosAssessResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosAssessResponseImplToJson(
      this,
    );
  }
}

abstract class _SosAssessResponse implements SosAssessResponse {
  const factory _SosAssessResponse(
      {required final String sessionId,
      required final int severityScore,
      required final String severityLabel,
      required final SosCoachingPlan coachingPlan}) = _$SosAssessResponseImpl;

  factory _SosAssessResponse.fromJson(Map<String, dynamic> json) =
      _$SosAssessResponseImpl.fromJson;

  @override
  String get sessionId;
  @override
  int get severityScore;
  @override
  String get severityLabel;
  @override
  SosCoachingPlan get coachingPlan;

  /// Create a copy of SosAssessResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosAssessResponseImplCopyWith<_$SosAssessResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SosCoachingPlan _$SosCoachingPlanFromJson(Map<String, dynamic> json) {
  return _SosCoachingPlan.fromJson(json);
}

/// @nodoc
mixin _$SosCoachingPlan {
  int get totalSteps => throw _privateConstructorUsedError;
  int get estimatedMinutes => throw _privateConstructorUsedError;
  String get approach => throw _privateConstructorUsedError;
  String get keyInsight => throw _privateConstructorUsedError;

  /// Serializes this SosCoachingPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosCoachingPlanCopyWith<SosCoachingPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosCoachingPlanCopyWith<$Res> {
  factory $SosCoachingPlanCopyWith(
          SosCoachingPlan value, $Res Function(SosCoachingPlan) then) =
      _$SosCoachingPlanCopyWithImpl<$Res, SosCoachingPlan>;
  @useResult
  $Res call(
      {int totalSteps,
      int estimatedMinutes,
      String approach,
      String keyInsight});
}

/// @nodoc
class _$SosCoachingPlanCopyWithImpl<$Res, $Val extends SosCoachingPlan>
    implements $SosCoachingPlanCopyWith<$Res> {
  _$SosCoachingPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSteps = null,
    Object? estimatedMinutes = null,
    Object? approach = null,
    Object? keyInsight = null,
  }) {
    return _then(_value.copyWith(
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedMinutes: null == estimatedMinutes
          ? _value.estimatedMinutes
          : estimatedMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      approach: null == approach
          ? _value.approach
          : approach // ignore: cast_nullable_to_non_nullable
              as String,
      keyInsight: null == keyInsight
          ? _value.keyInsight
          : keyInsight // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosCoachingPlanImplCopyWith<$Res>
    implements $SosCoachingPlanCopyWith<$Res> {
  factory _$$SosCoachingPlanImplCopyWith(_$SosCoachingPlanImpl value,
          $Res Function(_$SosCoachingPlanImpl) then) =
      __$$SosCoachingPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalSteps,
      int estimatedMinutes,
      String approach,
      String keyInsight});
}

/// @nodoc
class __$$SosCoachingPlanImplCopyWithImpl<$Res>
    extends _$SosCoachingPlanCopyWithImpl<$Res, _$SosCoachingPlanImpl>
    implements _$$SosCoachingPlanImplCopyWith<$Res> {
  __$$SosCoachingPlanImplCopyWithImpl(
      _$SosCoachingPlanImpl _value, $Res Function(_$SosCoachingPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSteps = null,
    Object? estimatedMinutes = null,
    Object? approach = null,
    Object? keyInsight = null,
  }) {
    return _then(_$SosCoachingPlanImpl(
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedMinutes: null == estimatedMinutes
          ? _value.estimatedMinutes
          : estimatedMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      approach: null == approach
          ? _value.approach
          : approach // ignore: cast_nullable_to_non_nullable
              as String,
      keyInsight: null == keyInsight
          ? _value.keyInsight
          : keyInsight // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosCoachingPlanImpl implements _SosCoachingPlan {
  const _$SosCoachingPlanImpl(
      {required this.totalSteps,
      required this.estimatedMinutes,
      required this.approach,
      required this.keyInsight});

  factory _$SosCoachingPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosCoachingPlanImplFromJson(json);

  @override
  final int totalSteps;
  @override
  final int estimatedMinutes;
  @override
  final String approach;
  @override
  final String keyInsight;

  @override
  String toString() {
    return 'SosCoachingPlan(totalSteps: $totalSteps, estimatedMinutes: $estimatedMinutes, approach: $approach, keyInsight: $keyInsight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosCoachingPlanImpl &&
            (identical(other.totalSteps, totalSteps) ||
                other.totalSteps == totalSteps) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes) &&
            (identical(other.approach, approach) ||
                other.approach == approach) &&
            (identical(other.keyInsight, keyInsight) ||
                other.keyInsight == keyInsight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalSteps, estimatedMinutes, approach, keyInsight);

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosCoachingPlanImplCopyWith<_$SosCoachingPlanImpl> get copyWith =>
      __$$SosCoachingPlanImplCopyWithImpl<_$SosCoachingPlanImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosCoachingPlanImplToJson(
      this,
    );
  }
}

abstract class _SosCoachingPlan implements SosCoachingPlan {
  const factory _SosCoachingPlan(
      {required final int totalSteps,
      required final int estimatedMinutes,
      required final String approach,
      required final String keyInsight}) = _$SosCoachingPlanImpl;

  factory _SosCoachingPlan.fromJson(Map<String, dynamic> json) =
      _$SosCoachingPlanImpl.fromJson;

  @override
  int get totalSteps;
  @override
  int get estimatedMinutes;
  @override
  String get approach;
  @override
  String get keyInsight;

  /// Create a copy of SosCoachingPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosCoachingPlanImplCopyWith<_$SosCoachingPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SosCoachResponse _$SosCoachResponseFromJson(Map<String, dynamic> json) {
  return _SosCoachResponse.fromJson(json);
}

/// @nodoc
mixin _$SosCoachResponse {
  String get sessionId => throw _privateConstructorUsedError;
  int get stepNumber => throw _privateConstructorUsedError;
  int get totalSteps => throw _privateConstructorUsedError;
  SosCoachingContent get coaching => throw _privateConstructorUsedError;
  bool get isLastStep => throw _privateConstructorUsedError;
  String? get nextStepPrompt => throw _privateConstructorUsedError;

  /// Serializes this SosCoachResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosCoachResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosCoachResponseCopyWith<SosCoachResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosCoachResponseCopyWith<$Res> {
  factory $SosCoachResponseCopyWith(
          SosCoachResponse value, $Res Function(SosCoachResponse) then) =
      _$SosCoachResponseCopyWithImpl<$Res, SosCoachResponse>;
  @useResult
  $Res call(
      {String sessionId,
      int stepNumber,
      int totalSteps,
      SosCoachingContent coaching,
      bool isLastStep,
      String? nextStepPrompt});

  $SosCoachingContentCopyWith<$Res> get coaching;
}

/// @nodoc
class _$SosCoachResponseCopyWithImpl<$Res, $Val extends SosCoachResponse>
    implements $SosCoachResponseCopyWith<$Res> {
  _$SosCoachResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosCoachResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? stepNumber = null,
    Object? totalSteps = null,
    Object? coaching = null,
    Object? isLastStep = null,
    Object? nextStepPrompt = freezed,
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
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      coaching: null == coaching
          ? _value.coaching
          : coaching // ignore: cast_nullable_to_non_nullable
              as SosCoachingContent,
      isLastStep: null == isLastStep
          ? _value.isLastStep
          : isLastStep // ignore: cast_nullable_to_non_nullable
              as bool,
      nextStepPrompt: freezed == nextStepPrompt
          ? _value.nextStepPrompt
          : nextStepPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of SosCoachResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SosCoachingContentCopyWith<$Res> get coaching {
    return $SosCoachingContentCopyWith<$Res>(_value.coaching, (value) {
      return _then(_value.copyWith(coaching: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SosCoachResponseImplCopyWith<$Res>
    implements $SosCoachResponseCopyWith<$Res> {
  factory _$$SosCoachResponseImplCopyWith(_$SosCoachResponseImpl value,
          $Res Function(_$SosCoachResponseImpl) then) =
      __$$SosCoachResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      int stepNumber,
      int totalSteps,
      SosCoachingContent coaching,
      bool isLastStep,
      String? nextStepPrompt});

  @override
  $SosCoachingContentCopyWith<$Res> get coaching;
}

/// @nodoc
class __$$SosCoachResponseImplCopyWithImpl<$Res>
    extends _$SosCoachResponseCopyWithImpl<$Res, _$SosCoachResponseImpl>
    implements _$$SosCoachResponseImplCopyWith<$Res> {
  __$$SosCoachResponseImplCopyWithImpl(_$SosCoachResponseImpl _value,
      $Res Function(_$SosCoachResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosCoachResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? stepNumber = null,
    Object? totalSteps = null,
    Object? coaching = null,
    Object? isLastStep = null,
    Object? nextStepPrompt = freezed,
  }) {
    return _then(_$SosCoachResponseImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      stepNumber: null == stepNumber
          ? _value.stepNumber
          : stepNumber // ignore: cast_nullable_to_non_nullable
              as int,
      totalSteps: null == totalSteps
          ? _value.totalSteps
          : totalSteps // ignore: cast_nullable_to_non_nullable
              as int,
      coaching: null == coaching
          ? _value.coaching
          : coaching // ignore: cast_nullable_to_non_nullable
              as SosCoachingContent,
      isLastStep: null == isLastStep
          ? _value.isLastStep
          : isLastStep // ignore: cast_nullable_to_non_nullable
              as bool,
      nextStepPrompt: freezed == nextStepPrompt
          ? _value.nextStepPrompt
          : nextStepPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosCoachResponseImpl implements _SosCoachResponse {
  const _$SosCoachResponseImpl(
      {required this.sessionId,
      required this.stepNumber,
      required this.totalSteps,
      required this.coaching,
      this.isLastStep = false,
      this.nextStepPrompt});

  factory _$SosCoachResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosCoachResponseImplFromJson(json);

  @override
  final String sessionId;
  @override
  final int stepNumber;
  @override
  final int totalSteps;
  @override
  final SosCoachingContent coaching;
  @override
  @JsonKey()
  final bool isLastStep;
  @override
  final String? nextStepPrompt;

  @override
  String toString() {
    return 'SosCoachResponse(sessionId: $sessionId, stepNumber: $stepNumber, totalSteps: $totalSteps, coaching: $coaching, isLastStep: $isLastStep, nextStepPrompt: $nextStepPrompt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosCoachResponseImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.stepNumber, stepNumber) ||
                other.stepNumber == stepNumber) &&
            (identical(other.totalSteps, totalSteps) ||
                other.totalSteps == totalSteps) &&
            (identical(other.coaching, coaching) ||
                other.coaching == coaching) &&
            (identical(other.isLastStep, isLastStep) ||
                other.isLastStep == isLastStep) &&
            (identical(other.nextStepPrompt, nextStepPrompt) ||
                other.nextStepPrompt == nextStepPrompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sessionId, stepNumber,
      totalSteps, coaching, isLastStep, nextStepPrompt);

  /// Create a copy of SosCoachResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosCoachResponseImplCopyWith<_$SosCoachResponseImpl> get copyWith =>
      __$$SosCoachResponseImplCopyWithImpl<_$SosCoachResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosCoachResponseImplToJson(
      this,
    );
  }
}

abstract class _SosCoachResponse implements SosCoachResponse {
  const factory _SosCoachResponse(
      {required final String sessionId,
      required final int stepNumber,
      required final int totalSteps,
      required final SosCoachingContent coaching,
      final bool isLastStep,
      final String? nextStepPrompt}) = _$SosCoachResponseImpl;

  factory _SosCoachResponse.fromJson(Map<String, dynamic> json) =
      _$SosCoachResponseImpl.fromJson;

  @override
  String get sessionId;
  @override
  int get stepNumber;
  @override
  int get totalSteps;
  @override
  SosCoachingContent get coaching;
  @override
  bool get isLastStep;
  @override
  String? get nextStepPrompt;

  /// Create a copy of SosCoachResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosCoachResponseImplCopyWith<_$SosCoachResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SosCoachingContent _$SosCoachingContentFromJson(Map<String, dynamic> json) {
  return _SosCoachingContent.fromJson(json);
}

/// @nodoc
mixin _$SosCoachingContent {
  String get sayThis => throw _privateConstructorUsedError;
  String get whyItWorks => throw _privateConstructorUsedError;
  List<String> get doNotSay => throw _privateConstructorUsedError;
  String? get bodyLanguageTip => throw _privateConstructorUsedError;
  String? get toneAdvice => throw _privateConstructorUsedError;
  String? get waitFor => throw _privateConstructorUsedError;

  /// Serializes this SosCoachingContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosCoachingContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosCoachingContentCopyWith<SosCoachingContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosCoachingContentCopyWith<$Res> {
  factory $SosCoachingContentCopyWith(
          SosCoachingContent value, $Res Function(SosCoachingContent) then) =
      _$SosCoachingContentCopyWithImpl<$Res, SosCoachingContent>;
  @useResult
  $Res call(
      {String sayThis,
      String whyItWorks,
      List<String> doNotSay,
      String? bodyLanguageTip,
      String? toneAdvice,
      String? waitFor});
}

/// @nodoc
class _$SosCoachingContentCopyWithImpl<$Res, $Val extends SosCoachingContent>
    implements $SosCoachingContentCopyWith<$Res> {
  _$SosCoachingContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosCoachingContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sayThis = null,
    Object? whyItWorks = null,
    Object? doNotSay = null,
    Object? bodyLanguageTip = freezed,
    Object? toneAdvice = freezed,
    Object? waitFor = freezed,
  }) {
    return _then(_value.copyWith(
      sayThis: null == sayThis
          ? _value.sayThis
          : sayThis // ignore: cast_nullable_to_non_nullable
              as String,
      whyItWorks: null == whyItWorks
          ? _value.whyItWorks
          : whyItWorks // ignore: cast_nullable_to_non_nullable
              as String,
      doNotSay: null == doNotSay
          ? _value.doNotSay
          : doNotSay // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bodyLanguageTip: freezed == bodyLanguageTip
          ? _value.bodyLanguageTip
          : bodyLanguageTip // ignore: cast_nullable_to_non_nullable
              as String?,
      toneAdvice: freezed == toneAdvice
          ? _value.toneAdvice
          : toneAdvice // ignore: cast_nullable_to_non_nullable
              as String?,
      waitFor: freezed == waitFor
          ? _value.waitFor
          : waitFor // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosCoachingContentImplCopyWith<$Res>
    implements $SosCoachingContentCopyWith<$Res> {
  factory _$$SosCoachingContentImplCopyWith(_$SosCoachingContentImpl value,
          $Res Function(_$SosCoachingContentImpl) then) =
      __$$SosCoachingContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sayThis,
      String whyItWorks,
      List<String> doNotSay,
      String? bodyLanguageTip,
      String? toneAdvice,
      String? waitFor});
}

/// @nodoc
class __$$SosCoachingContentImplCopyWithImpl<$Res>
    extends _$SosCoachingContentCopyWithImpl<$Res, _$SosCoachingContentImpl>
    implements _$$SosCoachingContentImplCopyWith<$Res> {
  __$$SosCoachingContentImplCopyWithImpl(_$SosCoachingContentImpl _value,
      $Res Function(_$SosCoachingContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of SosCoachingContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sayThis = null,
    Object? whyItWorks = null,
    Object? doNotSay = null,
    Object? bodyLanguageTip = freezed,
    Object? toneAdvice = freezed,
    Object? waitFor = freezed,
  }) {
    return _then(_$SosCoachingContentImpl(
      sayThis: null == sayThis
          ? _value.sayThis
          : sayThis // ignore: cast_nullable_to_non_nullable
              as String,
      whyItWorks: null == whyItWorks
          ? _value.whyItWorks
          : whyItWorks // ignore: cast_nullable_to_non_nullable
              as String,
      doNotSay: null == doNotSay
          ? _value._doNotSay
          : doNotSay // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bodyLanguageTip: freezed == bodyLanguageTip
          ? _value.bodyLanguageTip
          : bodyLanguageTip // ignore: cast_nullable_to_non_nullable
              as String?,
      toneAdvice: freezed == toneAdvice
          ? _value.toneAdvice
          : toneAdvice // ignore: cast_nullable_to_non_nullable
              as String?,
      waitFor: freezed == waitFor
          ? _value.waitFor
          : waitFor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosCoachingContentImpl implements _SosCoachingContent {
  const _$SosCoachingContentImpl(
      {required this.sayThis,
      required this.whyItWorks,
      final List<String> doNotSay = const [],
      this.bodyLanguageTip,
      this.toneAdvice,
      this.waitFor})
      : _doNotSay = doNotSay;

  factory _$SosCoachingContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosCoachingContentImplFromJson(json);

  @override
  final String sayThis;
  @override
  final String whyItWorks;
  final List<String> _doNotSay;
  @override
  @JsonKey()
  List<String> get doNotSay {
    if (_doNotSay is EqualUnmodifiableListView) return _doNotSay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_doNotSay);
  }

  @override
  final String? bodyLanguageTip;
  @override
  final String? toneAdvice;
  @override
  final String? waitFor;

  @override
  String toString() {
    return 'SosCoachingContent(sayThis: $sayThis, whyItWorks: $whyItWorks, doNotSay: $doNotSay, bodyLanguageTip: $bodyLanguageTip, toneAdvice: $toneAdvice, waitFor: $waitFor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosCoachingContentImpl &&
            (identical(other.sayThis, sayThis) || other.sayThis == sayThis) &&
            (identical(other.whyItWorks, whyItWorks) ||
                other.whyItWorks == whyItWorks) &&
            const DeepCollectionEquality().equals(other._doNotSay, _doNotSay) &&
            (identical(other.bodyLanguageTip, bodyLanguageTip) ||
                other.bodyLanguageTip == bodyLanguageTip) &&
            (identical(other.toneAdvice, toneAdvice) ||
                other.toneAdvice == toneAdvice) &&
            (identical(other.waitFor, waitFor) || other.waitFor == waitFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sayThis,
      whyItWorks,
      const DeepCollectionEquality().hash(_doNotSay),
      bodyLanguageTip,
      toneAdvice,
      waitFor);

  /// Create a copy of SosCoachingContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosCoachingContentImplCopyWith<_$SosCoachingContentImpl> get copyWith =>
      __$$SosCoachingContentImplCopyWithImpl<_$SosCoachingContentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosCoachingContentImplToJson(
      this,
    );
  }
}

abstract class _SosCoachingContent implements SosCoachingContent {
  const factory _SosCoachingContent(
      {required final String sayThis,
      required final String whyItWorks,
      final List<String> doNotSay,
      final String? bodyLanguageTip,
      final String? toneAdvice,
      final String? waitFor}) = _$SosCoachingContentImpl;

  factory _SosCoachingContent.fromJson(Map<String, dynamic> json) =
      _$SosCoachingContentImpl.fromJson;

  @override
  String get sayThis;
  @override
  String get whyItWorks;
  @override
  List<String> get doNotSay;
  @override
  String? get bodyLanguageTip;
  @override
  String? get toneAdvice;
  @override
  String? get waitFor;

  /// Create a copy of SosCoachingContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosCoachingContentImplCopyWith<_$SosCoachingContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActionCard _$ActionCardFromJson(Map<String, dynamic> json) {
  return _ActionCard.fromJson(json);
}

/// @nodoc
mixin _$ActionCard {
  String get id => throw _privateConstructorUsedError;
  ActionCardType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get titleLocalized => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get descriptionLocalized => throw _privateConstructorUsedError;
  String? get personalizedDetail => throw _privateConstructorUsedError;
  CardDifficulty get difficulty => throw _privateConstructorUsedError;
  String? get estimatedTime => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  CardStatus get status => throw _privateConstructorUsedError;
  List<String> get contextTags => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this ActionCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActionCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionCardCopyWith<ActionCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionCardCopyWith<$Res> {
  factory $ActionCardCopyWith(
          ActionCard value, $Res Function(ActionCard) then) =
      _$ActionCardCopyWithImpl<$Res, ActionCard>;
  @useResult
  $Res call(
      {String id,
      ActionCardType type,
      String title,
      String? titleLocalized,
      String description,
      String? descriptionLocalized,
      String? personalizedDetail,
      CardDifficulty difficulty,
      String? estimatedTime,
      int xpReward,
      CardStatus status,
      List<String> contextTags,
      DateTime? expiresAt});
}

/// @nodoc
class _$ActionCardCopyWithImpl<$Res, $Val extends ActionCard>
    implements $ActionCardCopyWith<$Res> {
  _$ActionCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? titleLocalized = freezed,
    Object? description = null,
    Object? descriptionLocalized = freezed,
    Object? personalizedDetail = freezed,
    Object? difficulty = null,
    Object? estimatedTime = freezed,
    Object? xpReward = null,
    Object? status = null,
    Object? contextTags = null,
    Object? expiresAt = freezed,
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
      titleLocalized: freezed == titleLocalized
          ? _value.titleLocalized
          : titleLocalized // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionLocalized: freezed == descriptionLocalized
          ? _value.descriptionLocalized
          : descriptionLocalized // ignore: cast_nullable_to_non_nullable
              as String?,
      personalizedDetail: freezed == personalizedDetail
          ? _value.personalizedDetail
          : personalizedDetail // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as CardDifficulty,
      estimatedTime: freezed == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CardStatus,
      contextTags: null == contextTags
          ? _value.contextTags
          : contextTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActionCardImplCopyWith<$Res>
    implements $ActionCardCopyWith<$Res> {
  factory _$$ActionCardImplCopyWith(
          _$ActionCardImpl value, $Res Function(_$ActionCardImpl) then) =
      __$$ActionCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ActionCardType type,
      String title,
      String? titleLocalized,
      String description,
      String? descriptionLocalized,
      String? personalizedDetail,
      CardDifficulty difficulty,
      String? estimatedTime,
      int xpReward,
      CardStatus status,
      List<String> contextTags,
      DateTime? expiresAt});
}

/// @nodoc
class __$$ActionCardImplCopyWithImpl<$Res>
    extends _$ActionCardCopyWithImpl<$Res, _$ActionCardImpl>
    implements _$$ActionCardImplCopyWith<$Res> {
  __$$ActionCardImplCopyWithImpl(
      _$ActionCardImpl _value, $Res Function(_$ActionCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? titleLocalized = freezed,
    Object? description = null,
    Object? descriptionLocalized = freezed,
    Object? personalizedDetail = freezed,
    Object? difficulty = null,
    Object? estimatedTime = freezed,
    Object? xpReward = null,
    Object? status = null,
    Object? contextTags = null,
    Object? expiresAt = freezed,
  }) {
    return _then(_$ActionCardImpl(
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
      titleLocalized: freezed == titleLocalized
          ? _value.titleLocalized
          : titleLocalized // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      descriptionLocalized: freezed == descriptionLocalized
          ? _value.descriptionLocalized
          : descriptionLocalized // ignore: cast_nullable_to_non_nullable
              as String?,
      personalizedDetail: freezed == personalizedDetail
          ? _value.personalizedDetail
          : personalizedDetail // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as CardDifficulty,
      estimatedTime: freezed == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CardStatus,
      contextTags: null == contextTags
          ? _value._contextTags
          : contextTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActionCardImpl implements _ActionCard {
  const _$ActionCardImpl(
      {required this.id,
      required this.type,
      required this.title,
      this.titleLocalized,
      required this.description,
      this.descriptionLocalized,
      this.personalizedDetail,
      required this.difficulty,
      this.estimatedTime,
      this.xpReward = 0,
      this.status = CardStatus.pending,
      final List<String> contextTags = const [],
      this.expiresAt})
      : _contextTags = contextTags;

  factory _$ActionCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionCardImplFromJson(json);

  @override
  final String id;
  @override
  final ActionCardType type;
  @override
  final String title;
  @override
  final String? titleLocalized;
  @override
  final String description;
  @override
  final String? descriptionLocalized;
  @override
  final String? personalizedDetail;
  @override
  final CardDifficulty difficulty;
  @override
  final String? estimatedTime;
  @override
  @JsonKey()
  final int xpReward;
  @override
  @JsonKey()
  final CardStatus status;
  final List<String> _contextTags;
  @override
  @JsonKey()
  List<String> get contextTags {
    if (_contextTags is EqualUnmodifiableListView) return _contextTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contextTags);
  }

  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'ActionCard(id: $id, type: $type, title: $title, titleLocalized: $titleLocalized, description: $description, descriptionLocalized: $descriptionLocalized, personalizedDetail: $personalizedDetail, difficulty: $difficulty, estimatedTime: $estimatedTime, xpReward: $xpReward, status: $status, contextTags: $contextTags, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.titleLocalized, titleLocalized) ||
                other.titleLocalized == titleLocalized) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionLocalized, descriptionLocalized) ||
                other.descriptionLocalized == descriptionLocalized) &&
            (identical(other.personalizedDetail, personalizedDetail) ||
                other.personalizedDetail == personalizedDetail) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._contextTags, _contextTags) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      title,
      titleLocalized,
      description,
      descriptionLocalized,
      personalizedDetail,
      difficulty,
      estimatedTime,
      xpReward,
      status,
      const DeepCollectionEquality().hash(_contextTags),
      expiresAt);

  /// Create a copy of ActionCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionCardImplCopyWith<_$ActionCardImpl> get copyWith =>
      __$$ActionCardImplCopyWithImpl<_$ActionCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionCardImplToJson(
      this,
    );
  }
}

abstract class _ActionCard implements ActionCard {
  const factory _ActionCard(
      {required final String id,
      required final ActionCardType type,
      required final String title,
      final String? titleLocalized,
      required final String description,
      final String? descriptionLocalized,
      final String? personalizedDetail,
      required final CardDifficulty difficulty,
      final String? estimatedTime,
      final int xpReward,
      final CardStatus status,
      final List<String> contextTags,
      final DateTime? expiresAt}) = _$ActionCardImpl;

  factory _ActionCard.fromJson(Map<String, dynamic> json) =
      _$ActionCardImpl.fromJson;

  @override
  String get id;
  @override
  ActionCardType get type;
  @override
  String get title;
  @override
  String? get titleLocalized;
  @override
  String get description;
  @override
  String? get descriptionLocalized;
  @override
  String? get personalizedDetail;
  @override
  CardDifficulty get difficulty;
  @override
  String? get estimatedTime;
  @override
  int get xpReward;
  @override
  CardStatus get status;
  @override
  List<String> get contextTags;
  @override
  DateTime? get expiresAt;

  /// Create a copy of ActionCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionCardImplCopyWith<_$ActionCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActionCardsResponse _$ActionCardsResponseFromJson(Map<String, dynamic> json) {
  return _ActionCardsResponse.fromJson(json);
}

/// @nodoc
mixin _$ActionCardsResponse {
  String get date => throw _privateConstructorUsedError;
  List<ActionCard> get cards => throw _privateConstructorUsedError;
  ActionCardSummary get summary => throw _privateConstructorUsedError;

  /// Serializes this ActionCardsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActionCardsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionCardsResponseCopyWith<ActionCardsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionCardsResponseCopyWith<$Res> {
  factory $ActionCardsResponseCopyWith(
          ActionCardsResponse value, $Res Function(ActionCardsResponse) then) =
      _$ActionCardsResponseCopyWithImpl<$Res, ActionCardsResponse>;
  @useResult
  $Res call({String date, List<ActionCard> cards, ActionCardSummary summary});

  $ActionCardSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$ActionCardsResponseCopyWithImpl<$Res, $Val extends ActionCardsResponse>
    implements $ActionCardsResponseCopyWith<$Res> {
  _$ActionCardsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionCardsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? cards = null,
    Object? summary = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<ActionCard>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ActionCardSummary,
    ) as $Val);
  }

  /// Create a copy of ActionCardsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActionCardSummaryCopyWith<$Res> get summary {
    return $ActionCardSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ActionCardsResponseImplCopyWith<$Res>
    implements $ActionCardsResponseCopyWith<$Res> {
  factory _$$ActionCardsResponseImplCopyWith(_$ActionCardsResponseImpl value,
          $Res Function(_$ActionCardsResponseImpl) then) =
      __$$ActionCardsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, List<ActionCard> cards, ActionCardSummary summary});

  @override
  $ActionCardSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$ActionCardsResponseImplCopyWithImpl<$Res>
    extends _$ActionCardsResponseCopyWithImpl<$Res, _$ActionCardsResponseImpl>
    implements _$$ActionCardsResponseImplCopyWith<$Res> {
  __$$ActionCardsResponseImplCopyWithImpl(_$ActionCardsResponseImpl _value,
      $Res Function(_$ActionCardsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionCardsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? cards = null,
    Object? summary = null,
  }) {
    return _then(_$ActionCardsResponseImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
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
}

/// @nodoc
@JsonSerializable()
class _$ActionCardsResponseImpl implements _ActionCardsResponse {
  const _$ActionCardsResponseImpl(
      {required this.date,
      required final List<ActionCard> cards,
      required this.summary})
      : _cards = cards;

  factory _$ActionCardsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionCardsResponseImplFromJson(json);

  @override
  final String date;
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
    return 'ActionCardsResponse(date: $date, cards: $cards, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionCardsResponseImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, const DeepCollectionEquality().hash(_cards), summary);

  /// Create a copy of ActionCardsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionCardsResponseImplCopyWith<_$ActionCardsResponseImpl> get copyWith =>
      __$$ActionCardsResponseImplCopyWithImpl<_$ActionCardsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionCardsResponseImplToJson(
      this,
    );
  }
}

abstract class _ActionCardsResponse implements ActionCardsResponse {
  const factory _ActionCardsResponse(
      {required final String date,
      required final List<ActionCard> cards,
      required final ActionCardSummary summary}) = _$ActionCardsResponseImpl;

  factory _ActionCardsResponse.fromJson(Map<String, dynamic> json) =
      _$ActionCardsResponseImpl.fromJson;

  @override
  String get date;
  @override
  List<ActionCard> get cards;
  @override
  ActionCardSummary get summary;

  /// Create a copy of ActionCardsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionCardsResponseImplCopyWith<_$ActionCardsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActionCardSummary _$ActionCardSummaryFromJson(Map<String, dynamic> json) {
  return _ActionCardSummary.fromJson(json);
}

/// @nodoc
mixin _$ActionCardSummary {
  int get totalCards => throw _privateConstructorUsedError;
  int get completedToday => throw _privateConstructorUsedError;
  int get totalXpAvailable => throw _privateConstructorUsedError;

  /// Serializes this ActionCardSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActionCardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionCardSummaryCopyWith<ActionCardSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionCardSummaryCopyWith<$Res> {
  factory $ActionCardSummaryCopyWith(
          ActionCardSummary value, $Res Function(ActionCardSummary) then) =
      _$ActionCardSummaryCopyWithImpl<$Res, ActionCardSummary>;
  @useResult
  $Res call({int totalCards, int completedToday, int totalXpAvailable});
}

/// @nodoc
class _$ActionCardSummaryCopyWithImpl<$Res, $Val extends ActionCardSummary>
    implements $ActionCardSummaryCopyWith<$Res> {
  _$ActionCardSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionCardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCards = null,
    Object? completedToday = null,
    Object? totalXpAvailable = null,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$ActionCardSummaryImplCopyWith<$Res>
    implements $ActionCardSummaryCopyWith<$Res> {
  factory _$$ActionCardSummaryImplCopyWith(_$ActionCardSummaryImpl value,
          $Res Function(_$ActionCardSummaryImpl) then) =
      __$$ActionCardSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalCards, int completedToday, int totalXpAvailable});
}

/// @nodoc
class __$$ActionCardSummaryImplCopyWithImpl<$Res>
    extends _$ActionCardSummaryCopyWithImpl<$Res, _$ActionCardSummaryImpl>
    implements _$$ActionCardSummaryImplCopyWith<$Res> {
  __$$ActionCardSummaryImplCopyWithImpl(_$ActionCardSummaryImpl _value,
      $Res Function(_$ActionCardSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionCardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCards = null,
    Object? completedToday = null,
    Object? totalXpAvailable = null,
  }) {
    return _then(_$ActionCardSummaryImpl(
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
@JsonSerializable()
class _$ActionCardSummaryImpl implements _ActionCardSummary {
  const _$ActionCardSummaryImpl(
      {this.totalCards = 0,
      this.completedToday = 0,
      this.totalXpAvailable = 0});

  factory _$ActionCardSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionCardSummaryImplFromJson(json);

  @override
  @JsonKey()
  final int totalCards;
  @override
  @JsonKey()
  final int completedToday;
  @override
  @JsonKey()
  final int totalXpAvailable;

  @override
  String toString() {
    return 'ActionCardSummary(totalCards: $totalCards, completedToday: $completedToday, totalXpAvailable: $totalXpAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionCardSummaryImpl &&
            (identical(other.totalCards, totalCards) ||
                other.totalCards == totalCards) &&
            (identical(other.completedToday, completedToday) ||
                other.completedToday == completedToday) &&
            (identical(other.totalXpAvailable, totalXpAvailable) ||
                other.totalXpAvailable == totalXpAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalCards, completedToday, totalXpAvailable);

  /// Create a copy of ActionCardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionCardSummaryImplCopyWith<_$ActionCardSummaryImpl> get copyWith =>
      __$$ActionCardSummaryImplCopyWithImpl<_$ActionCardSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionCardSummaryImplToJson(
      this,
    );
  }
}

abstract class _ActionCardSummary implements ActionCardSummary {
  const factory _ActionCardSummary(
      {final int totalCards,
      final int completedToday,
      final int totalXpAvailable}) = _$ActionCardSummaryImpl;

  factory _ActionCardSummary.fromJson(Map<String, dynamic> json) =
      _$ActionCardSummaryImpl.fromJson;

  @override
  int get totalCards;
  @override
  int get completedToday;
  @override
  int get totalXpAvailable;

  /// Create a copy of ActionCardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionCardSummaryImplCopyWith<_$ActionCardSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CardCompleteResponse _$CardCompleteResponseFromJson(Map<String, dynamic> json) {
  return _CardCompleteResponse.fromJson(json);
}

/// @nodoc
mixin _$CardCompleteResponse {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get completedAt => throw _privateConstructorUsedError;
  int get xpAwarded => throw _privateConstructorUsedError;
  XpBreakdown get xpBreakdown => throw _privateConstructorUsedError;
  StreakUpdate get streakUpdate => throw _privateConstructorUsedError;
  String? get encouragement => throw _privateConstructorUsedError;

  /// Serializes this CardCompleteResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CardCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CardCompleteResponseCopyWith<CardCompleteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardCompleteResponseCopyWith<$Res> {
  factory $CardCompleteResponseCopyWith(CardCompleteResponse value,
          $Res Function(CardCompleteResponse) then) =
      _$CardCompleteResponseCopyWithImpl<$Res, CardCompleteResponse>;
  @useResult
  $Res call(
      {String id,
      String status,
      DateTime completedAt,
      int xpAwarded,
      XpBreakdown xpBreakdown,
      StreakUpdate streakUpdate,
      String? encouragement});

  $XpBreakdownCopyWith<$Res> get xpBreakdown;
  $StreakUpdateCopyWith<$Res> get streakUpdate;
}

/// @nodoc
class _$CardCompleteResponseCopyWithImpl<$Res,
        $Val extends CardCompleteResponse>
    implements $CardCompleteResponseCopyWith<$Res> {
  _$CardCompleteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CardCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? completedAt = null,
    Object? xpAwarded = null,
    Object? xpBreakdown = null,
    Object? streakUpdate = null,
    Object? encouragement = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      xpAwarded: null == xpAwarded
          ? _value.xpAwarded
          : xpAwarded // ignore: cast_nullable_to_non_nullable
              as int,
      xpBreakdown: null == xpBreakdown
          ? _value.xpBreakdown
          : xpBreakdown // ignore: cast_nullable_to_non_nullable
              as XpBreakdown,
      streakUpdate: null == streakUpdate
          ? _value.streakUpdate
          : streakUpdate // ignore: cast_nullable_to_non_nullable
              as StreakUpdate,
      encouragement: freezed == encouragement
          ? _value.encouragement
          : encouragement // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CardCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $XpBreakdownCopyWith<$Res> get xpBreakdown {
    return $XpBreakdownCopyWith<$Res>(_value.xpBreakdown, (value) {
      return _then(_value.copyWith(xpBreakdown: value) as $Val);
    });
  }

  /// Create a copy of CardCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StreakUpdateCopyWith<$Res> get streakUpdate {
    return $StreakUpdateCopyWith<$Res>(_value.streakUpdate, (value) {
      return _then(_value.copyWith(streakUpdate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CardCompleteResponseImplCopyWith<$Res>
    implements $CardCompleteResponseCopyWith<$Res> {
  factory _$$CardCompleteResponseImplCopyWith(_$CardCompleteResponseImpl value,
          $Res Function(_$CardCompleteResponseImpl) then) =
      __$$CardCompleteResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String status,
      DateTime completedAt,
      int xpAwarded,
      XpBreakdown xpBreakdown,
      StreakUpdate streakUpdate,
      String? encouragement});

  @override
  $XpBreakdownCopyWith<$Res> get xpBreakdown;
  @override
  $StreakUpdateCopyWith<$Res> get streakUpdate;
}

/// @nodoc
class __$$CardCompleteResponseImplCopyWithImpl<$Res>
    extends _$CardCompleteResponseCopyWithImpl<$Res, _$CardCompleteResponseImpl>
    implements _$$CardCompleteResponseImplCopyWith<$Res> {
  __$$CardCompleteResponseImplCopyWithImpl(_$CardCompleteResponseImpl _value,
      $Res Function(_$CardCompleteResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? completedAt = null,
    Object? xpAwarded = null,
    Object? xpBreakdown = null,
    Object? streakUpdate = null,
    Object? encouragement = freezed,
  }) {
    return _then(_$CardCompleteResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      xpAwarded: null == xpAwarded
          ? _value.xpAwarded
          : xpAwarded // ignore: cast_nullable_to_non_nullable
              as int,
      xpBreakdown: null == xpBreakdown
          ? _value.xpBreakdown
          : xpBreakdown // ignore: cast_nullable_to_non_nullable
              as XpBreakdown,
      streakUpdate: null == streakUpdate
          ? _value.streakUpdate
          : streakUpdate // ignore: cast_nullable_to_non_nullable
              as StreakUpdate,
      encouragement: freezed == encouragement
          ? _value.encouragement
          : encouragement // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CardCompleteResponseImpl implements _CardCompleteResponse {
  const _$CardCompleteResponseImpl(
      {required this.id,
      required this.status,
      required this.completedAt,
      required this.xpAwarded,
      required this.xpBreakdown,
      required this.streakUpdate,
      this.encouragement});

  factory _$CardCompleteResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardCompleteResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String status;
  @override
  final DateTime completedAt;
  @override
  final int xpAwarded;
  @override
  final XpBreakdown xpBreakdown;
  @override
  final StreakUpdate streakUpdate;
  @override
  final String? encouragement;

  @override
  String toString() {
    return 'CardCompleteResponse(id: $id, status: $status, completedAt: $completedAt, xpAwarded: $xpAwarded, xpBreakdown: $xpBreakdown, streakUpdate: $streakUpdate, encouragement: $encouragement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardCompleteResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.xpAwarded, xpAwarded) ||
                other.xpAwarded == xpAwarded) &&
            (identical(other.xpBreakdown, xpBreakdown) ||
                other.xpBreakdown == xpBreakdown) &&
            (identical(other.streakUpdate, streakUpdate) ||
                other.streakUpdate == streakUpdate) &&
            (identical(other.encouragement, encouragement) ||
                other.encouragement == encouragement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, completedAt,
      xpAwarded, xpBreakdown, streakUpdate, encouragement);

  /// Create a copy of CardCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardCompleteResponseImplCopyWith<_$CardCompleteResponseImpl>
      get copyWith =>
          __$$CardCompleteResponseImplCopyWithImpl<_$CardCompleteResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardCompleteResponseImplToJson(
      this,
    );
  }
}

abstract class _CardCompleteResponse implements CardCompleteResponse {
  const factory _CardCompleteResponse(
      {required final String id,
      required final String status,
      required final DateTime completedAt,
      required final int xpAwarded,
      required final XpBreakdown xpBreakdown,
      required final StreakUpdate streakUpdate,
      final String? encouragement}) = _$CardCompleteResponseImpl;

  factory _CardCompleteResponse.fromJson(Map<String, dynamic> json) =
      _$CardCompleteResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get status;
  @override
  DateTime get completedAt;
  @override
  int get xpAwarded;
  @override
  XpBreakdown get xpBreakdown;
  @override
  StreakUpdate get streakUpdate;
  @override
  String? get encouragement;

  /// Create a copy of CardCompleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardCompleteResponseImplCopyWith<_$CardCompleteResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

XpBreakdown _$XpBreakdownFromJson(Map<String, dynamic> json) {
  return _XpBreakdown.fromJson(json);
}

/// @nodoc
mixin _$XpBreakdown {
  int get base => throw _privateConstructorUsedError;
  int get streakBonus => throw _privateConstructorUsedError;
  int get difficultyBonus => throw _privateConstructorUsedError;

  /// Serializes this XpBreakdown to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of XpBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $XpBreakdownCopyWith<XpBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $XpBreakdownCopyWith<$Res> {
  factory $XpBreakdownCopyWith(
          XpBreakdown value, $Res Function(XpBreakdown) then) =
      _$XpBreakdownCopyWithImpl<$Res, XpBreakdown>;
  @useResult
  $Res call({int base, int streakBonus, int difficultyBonus});
}

/// @nodoc
class _$XpBreakdownCopyWithImpl<$Res, $Val extends XpBreakdown>
    implements $XpBreakdownCopyWith<$Res> {
  _$XpBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of XpBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base = null,
    Object? streakBonus = null,
    Object? difficultyBonus = null,
  }) {
    return _then(_value.copyWith(
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as int,
      streakBonus: null == streakBonus
          ? _value.streakBonus
          : streakBonus // ignore: cast_nullable_to_non_nullable
              as int,
      difficultyBonus: null == difficultyBonus
          ? _value.difficultyBonus
          : difficultyBonus // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$XpBreakdownImplCopyWith<$Res>
    implements $XpBreakdownCopyWith<$Res> {
  factory _$$XpBreakdownImplCopyWith(
          _$XpBreakdownImpl value, $Res Function(_$XpBreakdownImpl) then) =
      __$$XpBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int base, int streakBonus, int difficultyBonus});
}

/// @nodoc
class __$$XpBreakdownImplCopyWithImpl<$Res>
    extends _$XpBreakdownCopyWithImpl<$Res, _$XpBreakdownImpl>
    implements _$$XpBreakdownImplCopyWith<$Res> {
  __$$XpBreakdownImplCopyWithImpl(
      _$XpBreakdownImpl _value, $Res Function(_$XpBreakdownImpl) _then)
      : super(_value, _then);

  /// Create a copy of XpBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base = null,
    Object? streakBonus = null,
    Object? difficultyBonus = null,
  }) {
    return _then(_$XpBreakdownImpl(
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as int,
      streakBonus: null == streakBonus
          ? _value.streakBonus
          : streakBonus // ignore: cast_nullable_to_non_nullable
              as int,
      difficultyBonus: null == difficultyBonus
          ? _value.difficultyBonus
          : difficultyBonus // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$XpBreakdownImpl implements _XpBreakdown {
  const _$XpBreakdownImpl(
      {this.base = 0, this.streakBonus = 0, this.difficultyBonus = 0});

  factory _$XpBreakdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$XpBreakdownImplFromJson(json);

  @override
  @JsonKey()
  final int base;
  @override
  @JsonKey()
  final int streakBonus;
  @override
  @JsonKey()
  final int difficultyBonus;

  @override
  String toString() {
    return 'XpBreakdown(base: $base, streakBonus: $streakBonus, difficultyBonus: $difficultyBonus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$XpBreakdownImpl &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.streakBonus, streakBonus) ||
                other.streakBonus == streakBonus) &&
            (identical(other.difficultyBonus, difficultyBonus) ||
                other.difficultyBonus == difficultyBonus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, base, streakBonus, difficultyBonus);

  /// Create a copy of XpBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$XpBreakdownImplCopyWith<_$XpBreakdownImpl> get copyWith =>
      __$$XpBreakdownImplCopyWithImpl<_$XpBreakdownImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$XpBreakdownImplToJson(
      this,
    );
  }
}

abstract class _XpBreakdown implements XpBreakdown {
  const factory _XpBreakdown(
      {final int base,
      final int streakBonus,
      final int difficultyBonus}) = _$XpBreakdownImpl;

  factory _XpBreakdown.fromJson(Map<String, dynamic> json) =
      _$XpBreakdownImpl.fromJson;

  @override
  int get base;
  @override
  int get streakBonus;
  @override
  int get difficultyBonus;

  /// Create a copy of XpBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$XpBreakdownImplCopyWith<_$XpBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StreakUpdate _$StreakUpdateFromJson(Map<String, dynamic> json) {
  return _StreakUpdate.fromJson(json);
}

/// @nodoc
mixin _$StreakUpdate {
  int get currentDays => throw _privateConstructorUsedError;
  bool get isActiveToday => throw _privateConstructorUsedError;

  /// Serializes this StreakUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreakUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreakUpdateCopyWith<StreakUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakUpdateCopyWith<$Res> {
  factory $StreakUpdateCopyWith(
          StreakUpdate value, $Res Function(StreakUpdate) then) =
      _$StreakUpdateCopyWithImpl<$Res, StreakUpdate>;
  @useResult
  $Res call({int currentDays, bool isActiveToday});
}

/// @nodoc
class _$StreakUpdateCopyWithImpl<$Res, $Val extends StreakUpdate>
    implements $StreakUpdateCopyWith<$Res> {
  _$StreakUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreakUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDays = null,
    Object? isActiveToday = null,
  }) {
    return _then(_value.copyWith(
      currentDays: null == currentDays
          ? _value.currentDays
          : currentDays // ignore: cast_nullable_to_non_nullable
              as int,
      isActiveToday: null == isActiveToday
          ? _value.isActiveToday
          : isActiveToday // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreakUpdateImplCopyWith<$Res>
    implements $StreakUpdateCopyWith<$Res> {
  factory _$$StreakUpdateImplCopyWith(
          _$StreakUpdateImpl value, $Res Function(_$StreakUpdateImpl) then) =
      __$$StreakUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentDays, bool isActiveToday});
}

/// @nodoc
class __$$StreakUpdateImplCopyWithImpl<$Res>
    extends _$StreakUpdateCopyWithImpl<$Res, _$StreakUpdateImpl>
    implements _$$StreakUpdateImplCopyWith<$Res> {
  __$$StreakUpdateImplCopyWithImpl(
      _$StreakUpdateImpl _value, $Res Function(_$StreakUpdateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreakUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDays = null,
    Object? isActiveToday = null,
  }) {
    return _then(_$StreakUpdateImpl(
      currentDays: null == currentDays
          ? _value.currentDays
          : currentDays // ignore: cast_nullable_to_non_nullable
              as int,
      isActiveToday: null == isActiveToday
          ? _value.isActiveToday
          : isActiveToday // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreakUpdateImpl implements _StreakUpdate {
  const _$StreakUpdateImpl({this.currentDays = 0, this.isActiveToday = false});

  factory _$StreakUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreakUpdateImplFromJson(json);

  @override
  @JsonKey()
  final int currentDays;
  @override
  @JsonKey()
  final bool isActiveToday;

  @override
  String toString() {
    return 'StreakUpdate(currentDays: $currentDays, isActiveToday: $isActiveToday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakUpdateImpl &&
            (identical(other.currentDays, currentDays) ||
                other.currentDays == currentDays) &&
            (identical(other.isActiveToday, isActiveToday) ||
                other.isActiveToday == isActiveToday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentDays, isActiveToday);

  /// Create a copy of StreakUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakUpdateImplCopyWith<_$StreakUpdateImpl> get copyWith =>
      __$$StreakUpdateImplCopyWithImpl<_$StreakUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreakUpdateImplToJson(
      this,
    );
  }
}

abstract class _StreakUpdate implements StreakUpdate {
  const factory _StreakUpdate(
      {final int currentDays, final bool isActiveToday}) = _$StreakUpdateImpl;

  factory _StreakUpdate.fromJson(Map<String, dynamic> json) =
      _$StreakUpdateImpl.fromJson;

  @override
  int get currentDays;
  @override
  bool get isActiveToday;

  /// Create a copy of StreakUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreakUpdateImplCopyWith<_$StreakUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
