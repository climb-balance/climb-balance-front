// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expert_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExpertProfile _$ExpertProfileFromJson(Map<String, dynamic> json) {
  return _ExpertProfile.fromJson(json);
}

/// @nodoc
mixin _$ExpertProfile {
  String get nickName => throw _privateConstructorUsedError;
  String get profileImagePath => throw _privateConstructorUsedError;
  String get introduce => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpertProfileCopyWith<ExpertProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpertProfileCopyWith<$Res> {
  factory $ExpertProfileCopyWith(
          ExpertProfile value, $Res Function(ExpertProfile) then) =
      _$ExpertProfileCopyWithImpl<$Res>;
  $Res call({String nickName, String profileImagePath, String introduce});
}

/// @nodoc
class _$ExpertProfileCopyWithImpl<$Res>
    implements $ExpertProfileCopyWith<$Res> {
  _$ExpertProfileCopyWithImpl(this._value, this._then);

  final ExpertProfile _value;
  // ignore: unused_field
  final $Res Function(ExpertProfile) _then;

  @override
  $Res call({
    Object? nickName = freezed,
    Object? profileImagePath = freezed,
    Object? introduce = freezed,
  }) {
    return _then(_value.copyWith(
      nickName: nickName == freezed
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImagePath: profileImagePath == freezed
          ? _value.profileImagePath
          : profileImagePath // ignore: cast_nullable_to_non_nullable
              as String,
      introduce: introduce == freezed
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ExpertProfileCopyWith<$Res>
    implements $ExpertProfileCopyWith<$Res> {
  factory _$$_ExpertProfileCopyWith(
          _$_ExpertProfile value, $Res Function(_$_ExpertProfile) then) =
      __$$_ExpertProfileCopyWithImpl<$Res>;
  @override
  $Res call({String nickName, String profileImagePath, String introduce});
}

/// @nodoc
class __$$_ExpertProfileCopyWithImpl<$Res>
    extends _$ExpertProfileCopyWithImpl<$Res>
    implements _$$_ExpertProfileCopyWith<$Res> {
  __$$_ExpertProfileCopyWithImpl(
      _$_ExpertProfile _value, $Res Function(_$_ExpertProfile) _then)
      : super(_value, (v) => _then(v as _$_ExpertProfile));

  @override
  _$_ExpertProfile get _value => super._value as _$_ExpertProfile;

  @override
  $Res call({
    Object? nickName = freezed,
    Object? profileImagePath = freezed,
    Object? introduce = freezed,
  }) {
    return _then(_$_ExpertProfile(
      nickName: nickName == freezed
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      profileImagePath: profileImagePath == freezed
          ? _value.profileImagePath
          : profileImagePath // ignore: cast_nullable_to_non_nullable
              as String,
      introduce: introduce == freezed
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExpertProfile implements _ExpertProfile {
  const _$_ExpertProfile(
      {this.nickName = 'default',
      this.profileImagePath =
          'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
      this.introduce = ''});

  factory _$_ExpertProfile.fromJson(Map<String, dynamic> json) =>
      _$$_ExpertProfileFromJson(json);

  @override
  @JsonKey()
  final String nickName;
  @override
  @JsonKey()
  final String profileImagePath;
  @override
  @JsonKey()
  final String introduce;

  @override
  String toString() {
    return 'ExpertProfile(nickName: $nickName, profileImagePath: $profileImagePath, introduce: $introduce)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpertProfile &&
            const DeepCollectionEquality().equals(other.nickName, nickName) &&
            const DeepCollectionEquality()
                .equals(other.profileImagePath, profileImagePath) &&
            const DeepCollectionEquality().equals(other.introduce, introduce));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nickName),
      const DeepCollectionEquality().hash(profileImagePath),
      const DeepCollectionEquality().hash(introduce));

  @JsonKey(ignore: true)
  @override
  _$$_ExpertProfileCopyWith<_$_ExpertProfile> get copyWith =>
      __$$_ExpertProfileCopyWithImpl<_$_ExpertProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpertProfileToJson(
      this,
    );
  }
}

abstract class _ExpertProfile implements ExpertProfile {
  const factory _ExpertProfile(
      {final String nickName,
      final String profileImagePath,
      final String introduce}) = _$_ExpertProfile;

  factory _ExpertProfile.fromJson(Map<String, dynamic> json) =
      _$_ExpertProfile.fromJson;

  @override
  String get nickName;
  @override
  String get profileImagePath;
  @override
  String get introduce;
  @override
  @JsonKey(ignore: true)
  _$$_ExpertProfileCopyWith<_$_ExpertProfile> get copyWith =>
      throw _privateConstructorUsedError;
}
