// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessageRequestEntity {
  MessageMode get mode => throw _privateConstructorUsedError;
  MessageTone get tone => throw _privateConstructorUsedError;
  MessageLength get length => throw _privateConstructorUsedError;
  int get humorLevel => throw _privateConstructorUsedError;
  String get languageCode => throw _privateConstructorUsedError;
  bool get includePartnerName => throw _privateConstructorUsedError;
  String? get contextText => throw _privateConstructorUsedError;

  /// Create a copy of MessageRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageRequestEntityCopyWith<MessageRequestEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageRequestEntityCopyWith<$Res> {
  factory $MessageRequestEntityCopyWith(MessageRequestEntity value,
          $Res Function(MessageRequestEntity) then) =
      _$MessageRequestEntityCopyWithImpl<$Res, MessageRequestEntity>;
  @useResult
  $Res call(
      {MessageMode mode,
      MessageTone tone,
      MessageLength length,
      int humorLevel,
      String languageCode,
      bool includePartnerName,
      String? contextText});
}

/// @nodoc
class _$MessageRequestEntityCopyWithImpl<$Res,
        $Val extends MessageRequestEntity>
    implements $MessageRequestEntityCopyWith<$Res> {
  _$MessageRequestEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? tone = null,
    Object? length = null,
    Object? humorLevel = null,
    Object? languageCode = null,
    Object? includePartnerName = null,
    Object? contextText = freezed,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as MessageMode,
      tone: null == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as MessageTone,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as MessageLength,
      humorLevel: null == humorLevel
          ? _value.humorLevel
          : humorLevel // ignore: cast_nullable_to_non_nullable
              as int,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      includePartnerName: null == includePartnerName
          ? _value.includePartnerName
          : includePartnerName // ignore: cast_nullable_to_non_nullable
              as bool,
      contextText: freezed == contextText
          ? _value.contextText
          : contextText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageRequestEntityImplCopyWith<$Res>
    implements $MessageRequestEntityCopyWith<$Res> {
  factory _$$MessageRequestEntityImplCopyWith(_$MessageRequestEntityImpl value,
          $Res Function(_$MessageRequestEntityImpl) then) =
      __$$MessageRequestEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MessageMode mode,
      MessageTone tone,
      MessageLength length,
      int humorLevel,
      String languageCode,
      bool includePartnerName,
      String? contextText});
}

/// @nodoc
class __$$MessageRequestEntityImplCopyWithImpl<$Res>
    extends _$MessageRequestEntityCopyWithImpl<$Res, _$MessageRequestEntityImpl>
    implements _$$MessageRequestEntityImplCopyWith<$Res> {
  __$$MessageRequestEntityImplCopyWithImpl(_$MessageRequestEntityImpl _value,
      $Res Function(_$MessageRequestEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? tone = null,
    Object? length = null,
    Object? humorLevel = null,
    Object? languageCode = null,
    Object? includePartnerName = null,
    Object? contextText = freezed,
  }) {
    return _then(_$MessageRequestEntityImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as MessageMode,
      tone: null == tone
          ? _value.tone
          : tone // ignore: cast_nullable_to_non_nullable
              as MessageTone,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as MessageLength,
      humorLevel: null == humorLevel
          ? _value.humorLevel
          : humorLevel // ignore: cast_nullable_to_non_nullable
              as int,
      languageCode: null == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      includePartnerName: null == includePartnerName
          ? _value.includePartnerName
          : includePartnerName // ignore: cast_nullable_to_non_nullable
              as bool,
      contextText: freezed == contextText
          ? _value.contextText
          : contextText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MessageRequestEntityImpl implements _MessageRequestEntity {
  const _$MessageRequestEntityImpl(
      {required this.mode,
      required this.tone,
      required this.length,
      this.humorLevel = 50,
      this.languageCode = 'en',
      this.includePartnerName = true,
      this.contextText});

  @override
  final MessageMode mode;
  @override
  final MessageTone tone;
  @override
  final MessageLength length;
  @override
  @JsonKey()
  final int humorLevel;
  @override
  @JsonKey()
  final String languageCode;
  @override
  @JsonKey()
  final bool includePartnerName;
  @override
  final String? contextText;

  @override
  String toString() {
    return 'MessageRequestEntity(mode: $mode, tone: $tone, length: $length, humorLevel: $humorLevel, languageCode: $languageCode, includePartnerName: $includePartnerName, contextText: $contextText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageRequestEntityImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.tone, tone) || other.tone == tone) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.humorLevel, humorLevel) ||
                other.humorLevel == humorLevel) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.includePartnerName, includePartnerName) ||
                other.includePartnerName == includePartnerName) &&
            (identical(other.contextText, contextText) ||
                other.contextText == contextText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode, tone, length, humorLevel,
      languageCode, includePartnerName, contextText);

  /// Create a copy of MessageRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageRequestEntityImplCopyWith<_$MessageRequestEntityImpl>
      get copyWith =>
          __$$MessageRequestEntityImplCopyWithImpl<_$MessageRequestEntityImpl>(
              this, _$identity);
}

abstract class _MessageRequestEntity implements MessageRequestEntity {
  const factory _MessageRequestEntity(
      {required final MessageMode mode,
      required final MessageTone tone,
      required final MessageLength length,
      final int humorLevel,
      final String languageCode,
      final bool includePartnerName,
      final String? contextText}) = _$MessageRequestEntityImpl;

  @override
  MessageMode get mode;
  @override
  MessageTone get tone;
  @override
  MessageLength get length;
  @override
  int get humorLevel;
  @override
  String get languageCode;
  @override
  bool get includePartnerName;
  @override
  String? get contextText;

  /// Create a copy of MessageRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageRequestEntityImplCopyWith<_$MessageRequestEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
