// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_preferences_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PartnerPreferencesEntity {
  Map<String, List<String>> get favorites => throw _privateConstructorUsedError;
  List<String> get dislikes => throw _privateConstructorUsedError;
  List<String> get hobbies => throw _privateConstructorUsedError;
  String? get stressCoping => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of PartnerPreferencesEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerPreferencesEntityCopyWith<PartnerPreferencesEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerPreferencesEntityCopyWith<$Res> {
  factory $PartnerPreferencesEntityCopyWith(PartnerPreferencesEntity value,
          $Res Function(PartnerPreferencesEntity) then) =
      _$PartnerPreferencesEntityCopyWithImpl<$Res, PartnerPreferencesEntity>;
  @useResult
  $Res call(
      {Map<String, List<String>> favorites,
      List<String> dislikes,
      List<String> hobbies,
      String? stressCoping,
      String? notes});
}

/// @nodoc
class _$PartnerPreferencesEntityCopyWithImpl<$Res,
        $Val extends PartnerPreferencesEntity>
    implements $PartnerPreferencesEntityCopyWith<$Res> {
  _$PartnerPreferencesEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartnerPreferencesEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = null,
    Object? dislikes = null,
    Object? hobbies = null,
    Object? stressCoping = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      favorites: null == favorites
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      dislikes: null == dislikes
          ? _value.dislikes
          : dislikes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hobbies: null == hobbies
          ? _value.hobbies
          : hobbies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stressCoping: freezed == stressCoping
          ? _value.stressCoping
          : stressCoping // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerPreferencesEntityImplCopyWith<$Res>
    implements $PartnerPreferencesEntityCopyWith<$Res> {
  factory _$$PartnerPreferencesEntityImplCopyWith(
          _$PartnerPreferencesEntityImpl value,
          $Res Function(_$PartnerPreferencesEntityImpl) then) =
      __$$PartnerPreferencesEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, List<String>> favorites,
      List<String> dislikes,
      List<String> hobbies,
      String? stressCoping,
      String? notes});
}

/// @nodoc
class __$$PartnerPreferencesEntityImplCopyWithImpl<$Res>
    extends _$PartnerPreferencesEntityCopyWithImpl<$Res,
        _$PartnerPreferencesEntityImpl>
    implements _$$PartnerPreferencesEntityImplCopyWith<$Res> {
  __$$PartnerPreferencesEntityImplCopyWithImpl(
      _$PartnerPreferencesEntityImpl _value,
      $Res Function(_$PartnerPreferencesEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartnerPreferencesEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = null,
    Object? dislikes = null,
    Object? hobbies = null,
    Object? stressCoping = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$PartnerPreferencesEntityImpl(
      favorites: null == favorites
          ? _value._favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      dislikes: null == dislikes
          ? _value._dislikes
          : dislikes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hobbies: null == hobbies
          ? _value._hobbies
          : hobbies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stressCoping: freezed == stressCoping
          ? _value.stressCoping
          : stressCoping // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PartnerPreferencesEntityImpl extends _PartnerPreferencesEntity {
  const _$PartnerPreferencesEntityImpl(
      {final Map<String, List<String>> favorites = const {},
      final List<String> dislikes = const [],
      final List<String> hobbies = const [],
      this.stressCoping,
      this.notes})
      : _favorites = favorites,
        _dislikes = dislikes,
        _hobbies = hobbies,
        super._();

  final Map<String, List<String>> _favorites;
  @override
  @JsonKey()
  Map<String, List<String>> get favorites {
    if (_favorites is EqualUnmodifiableMapView) return _favorites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_favorites);
  }

  final List<String> _dislikes;
  @override
  @JsonKey()
  List<String> get dislikes {
    if (_dislikes is EqualUnmodifiableListView) return _dislikes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dislikes);
  }

  final List<String> _hobbies;
  @override
  @JsonKey()
  List<String> get hobbies {
    if (_hobbies is EqualUnmodifiableListView) return _hobbies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hobbies);
  }

  @override
  final String? stressCoping;
  @override
  final String? notes;

  @override
  String toString() {
    return 'PartnerPreferencesEntity(favorites: $favorites, dislikes: $dislikes, hobbies: $hobbies, stressCoping: $stressCoping, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerPreferencesEntityImpl &&
            const DeepCollectionEquality()
                .equals(other._favorites, _favorites) &&
            const DeepCollectionEquality().equals(other._dislikes, _dislikes) &&
            const DeepCollectionEquality().equals(other._hobbies, _hobbies) &&
            (identical(other.stressCoping, stressCoping) ||
                other.stressCoping == stressCoping) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_favorites),
      const DeepCollectionEquality().hash(_dislikes),
      const DeepCollectionEquality().hash(_hobbies),
      stressCoping,
      notes);

  /// Create a copy of PartnerPreferencesEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerPreferencesEntityImplCopyWith<_$PartnerPreferencesEntityImpl>
      get copyWith => __$$PartnerPreferencesEntityImplCopyWithImpl<
          _$PartnerPreferencesEntityImpl>(this, _$identity);
}

abstract class _PartnerPreferencesEntity extends PartnerPreferencesEntity {
  const factory _PartnerPreferencesEntity(
      {final Map<String, List<String>> favorites,
      final List<String> dislikes,
      final List<String> hobbies,
      final String? stressCoping,
      final String? notes}) = _$PartnerPreferencesEntityImpl;
  const _PartnerPreferencesEntity._() : super._();

  @override
  Map<String, List<String>> get favorites;
  @override
  List<String> get dislikes;
  @override
  List<String> get hobbies;
  @override
  String? get stressCoping;
  @override
  String? get notes;

  /// Create a copy of PartnerPreferencesEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerPreferencesEntityImplCopyWith<_$PartnerPreferencesEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
