// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get nickName => throw _privateConstructorUsedError;
  String get profileImagePath => throw _privateConstructorUsedError;
  String get introduce => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  int get uniqueCode => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;
  bool get isExpert => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res>;
  $Res call(
      {String nickName,
      String profileImagePath,
      String introduce,
      String token,
      int uniqueCode,
      int height,
      int weight,
      bool isExpert});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res> implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  final UserProfile _value;
  // ignore: unused_field
  final $Res Function(UserProfile) _then;

  @override
  $Res call({
    Object? nickName = freezed,
    Object? profileImagePath = freezed,
    Object? introduce = freezed,
    Object? token = freezed,
    Object? uniqueCode = freezed,
    Object? height = freezed,
    Object? weight = freezed,
    Object? isExpert = freezed,
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
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      uniqueCode: uniqueCode == freezed
          ? _value.uniqueCode
          : uniqueCode // ignore: cast_nullable_to_non_nullable
              as int,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      isExpert: isExpert == freezed
          ? _value.isExpert
          : isExpert // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_UserProfileCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$_UserProfileCopyWith(
          _$_UserProfile value, $Res Function(_$_UserProfile) then) =
      __$$_UserProfileCopyWithImpl<$Res>;
  @override
  $Res call(
      {String nickName,
      String profileImagePath,
      String introduce,
      String token,
      int uniqueCode,
      int height,
      int weight,
      bool isExpert});
}

/// @nodoc
class __$$_UserProfileCopyWithImpl<$Res> extends _$UserProfileCopyWithImpl<$Res>
    implements _$$_UserProfileCopyWith<$Res> {
  __$$_UserProfileCopyWithImpl(
      _$_UserProfile _value, $Res Function(_$_UserProfile) _then)
      : super(_value, (v) => _then(v as _$_UserProfile));

  @override
  _$_UserProfile get _value => super._value as _$_UserProfile;

  @override
  $Res call({
    Object? nickName = freezed,
    Object? profileImagePath = freezed,
    Object? introduce = freezed,
    Object? token = freezed,
    Object? uniqueCode = freezed,
    Object? height = freezed,
    Object? weight = freezed,
    Object? isExpert = freezed,
  }) {
    return _then(_$_UserProfile(
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
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      uniqueCode: uniqueCode == freezed
          ? _value.uniqueCode
          : uniqueCode // ignore: cast_nullable_to_non_nullable
              as int,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      isExpert: isExpert == freezed
          ? _value.isExpert
          : isExpert // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserProfile implements _UserProfile {
  const _$_UserProfile(
      {this.nickName = 'default_user',
      this.profileImagePath =
          'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
      this.introduce = '',
      this.token = '',
      this.uniqueCode = 1234,
      this.height = -1,
      this.weight = -1,
      this.isExpert = false});

  factory _$_UserProfile.fromJson(Map<String, dynamic> json) =>
      _$$_UserProfileFromJson(json);

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
  @JsonKey()
  final String token;
  @override
  @JsonKey()
  final int uniqueCode;
  @override
  @JsonKey()
  final int height;
  @override
  @JsonKey()
  final int weight;
  @override
  @JsonKey()
  final bool isExpert;

  @override
  String toString() {
    return 'UserProfile(nickName: $nickName, profileImagePath: $profileImagePath, introduce: $introduce, token: $token, uniqueCode: $uniqueCode, height: $height, weight: $weight, isExpert: $isExpert)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProfile &&
            const DeepCollectionEquality().equals(other.nickName, nickName) &&
            const DeepCollectionEquality()
                .equals(other.profileImagePath, profileImagePath) &&
            const DeepCollectionEquality().equals(other.introduce, introduce) &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality()
                .equals(other.uniqueCode, uniqueCode) &&
            const DeepCollectionEquality().equals(other.height, height) &&
            const DeepCollectionEquality().equals(other.weight, weight) &&
            const DeepCollectionEquality().equals(other.isExpert, isExpert));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nickName),
      const DeepCollectionEquality().hash(profileImagePath),
      const DeepCollectionEquality().hash(introduce),
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(uniqueCode),
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(weight),
      const DeepCollectionEquality().hash(isExpert));

  @JsonKey(ignore: true)
  @override
  _$$_UserProfileCopyWith<_$_UserProfile> get copyWith =>
      __$$_UserProfileCopyWithImpl<_$_UserProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserProfileToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {final String nickName,
      final String profileImagePath,
      final String introduce,
      final String token,
      final int uniqueCode,
      final int height,
      final int weight,
      final bool isExpert}) = _$_UserProfile;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$_UserProfile.fromJson;

  @override
  String get nickName;
  @override
  String get profileImagePath;
  @override
  String get introduce;
  @override
  String get token;
  @override
  int get uniqueCode;
  @override
  int get height;
  @override
  int get weight;
  @override
  bool get isExpert;
  @override
  @JsonKey(ignore: true)
  _$$_UserProfileCopyWith<_$_UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}
