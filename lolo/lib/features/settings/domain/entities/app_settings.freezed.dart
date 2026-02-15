// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppSettings {
  String get locale => throw _privateConstructorUsedError;
  String get themeMode => throw _privateConstructorUsedError;
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  bool get reminderNotifications => throw _privateConstructorUsedError;
  bool get dailyCardNotifications => throw _privateConstructorUsedError;
  bool get weeklyDigest => throw _privateConstructorUsedError;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {String locale,
      String themeMode,
      bool notificationsEnabled,
      bool reminderNotifications,
      bool dailyCardNotifications,
      bool weeklyDigest});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
    Object? themeMode = null,
    Object? notificationsEnabled = null,
    Object? reminderNotifications = null,
    Object? dailyCardNotifications = null,
    Object? weeklyDigest = null,
  }) {
    return _then(_value.copyWith(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderNotifications: null == reminderNotifications
          ? _value.reminderNotifications
          : reminderNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyCardNotifications: null == dailyCardNotifications
          ? _value.dailyCardNotifications
          : dailyCardNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      weeklyDigest: null == weeklyDigest
          ? _value.weeklyDigest
          : weeklyDigest // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String locale,
      String themeMode,
      bool notificationsEnabled,
      bool reminderNotifications,
      bool dailyCardNotifications,
      bool weeklyDigest});
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
    Object? themeMode = null,
    Object? notificationsEnabled = null,
    Object? reminderNotifications = null,
    Object? dailyCardNotifications = null,
    Object? weeklyDigest = null,
  }) {
    return _then(_$AppSettingsImpl(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderNotifications: null == reminderNotifications
          ? _value.reminderNotifications
          : reminderNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyCardNotifications: null == dailyCardNotifications
          ? _value.dailyCardNotifications
          : dailyCardNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      weeklyDigest: null == weeklyDigest
          ? _value.weeklyDigest
          : weeklyDigest // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {this.locale = 'en',
      this.themeMode = 'system',
      this.notificationsEnabled = true,
      this.reminderNotifications = true,
      this.dailyCardNotifications = true,
      this.weeklyDigest = true});

  @override
  @JsonKey()
  final String locale;
  @override
  @JsonKey()
  final String themeMode;
  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final bool reminderNotifications;
  @override
  @JsonKey()
  final bool dailyCardNotifications;
  @override
  @JsonKey()
  final bool weeklyDigest;

  @override
  String toString() {
    return 'AppSettings(locale: $locale, themeMode: $themeMode, notificationsEnabled: $notificationsEnabled, reminderNotifications: $reminderNotifications, dailyCardNotifications: $dailyCardNotifications, weeklyDigest: $weeklyDigest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.reminderNotifications, reminderNotifications) ||
                other.reminderNotifications == reminderNotifications) &&
            (identical(other.dailyCardNotifications, dailyCardNotifications) ||
                other.dailyCardNotifications == dailyCardNotifications) &&
            (identical(other.weeklyDigest, weeklyDigest) ||
                other.weeklyDigest == weeklyDigest));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      locale,
      themeMode,
      notificationsEnabled,
      reminderNotifications,
      dailyCardNotifications,
      weeklyDigest);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {final String locale,
      final String themeMode,
      final bool notificationsEnabled,
      final bool reminderNotifications,
      final bool dailyCardNotifications,
      final bool weeklyDigest}) = _$AppSettingsImpl;

  @override
  String get locale;
  @override
  String get themeMode;
  @override
  bool get notificationsEnabled;
  @override
  bool get reminderNotifications;
  @override
  bool get dailyCardNotifications;
  @override
  bool get weeklyDigest;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
