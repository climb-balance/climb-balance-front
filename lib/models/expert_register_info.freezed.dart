// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expert_register_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExpertRegisterInfo _$ExpertRegisterInfoFromJson(Map<String, dynamic> json) {
  return _ExpertRegisterInfo.fromJson(json);
}

/// @nodoc
mixin _$ExpertRegisterInfo {
  String get nickName => throw _privateConstructorUsedError;
  String get introduce => throw _privateConstructorUsedError;
  int get climbingCenterId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  File? get tmpImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpertRegisterInfoCopyWith<ExpertRegisterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpertRegisterInfoCopyWith<$Res> {
  factory $ExpertRegisterInfoCopyWith(
          ExpertRegisterInfo value, $Res Function(ExpertRegisterInfo) then) =
      _$ExpertRegisterInfoCopyWithImpl<$Res>;
  $Res call(
      {String nickName,
      String introduce,
      int climbingCenterId,
      @JsonKey(ignore: true) File? tmpImage});
}

/// @nodoc
class _$ExpertRegisterInfoCopyWithImpl<$Res>
    implements $ExpertRegisterInfoCopyWith<$Res> {
  _$ExpertRegisterInfoCopyWithImpl(this._value, this._then);

  final ExpertRegisterInfo _value;
  // ignore: unused_field
  final $Res Function(ExpertRegisterInfo) _then;

  @override
  $Res call({
    Object? nickName = freezed,
    Object? introduce = freezed,
    Object? climbingCenterId = freezed,
    Object? tmpImage = freezed,
  }) {
    return _then(_value.copyWith(
      nickName: nickName == freezed
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      introduce: introduce == freezed
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
      climbingCenterId: climbingCenterId == freezed
          ? _value.climbingCenterId
          : climbingCenterId // ignore: cast_nullable_to_non_nullable
              as int,
      tmpImage: tmpImage == freezed
          ? _value.tmpImage
          : tmpImage // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc
abstract class _$$_ExpertRegisterInfoCopyWith<$Res>
    implements $ExpertRegisterInfoCopyWith<$Res> {
  factory _$$_ExpertRegisterInfoCopyWith(_$_ExpertRegisterInfo value,
          $Res Function(_$_ExpertRegisterInfo) then) =
      __$$_ExpertRegisterInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String nickName,
      String introduce,
      int climbingCenterId,
      @JsonKey(ignore: true) File? tmpImage});
}

/// @nodoc
class __$$_ExpertRegisterInfoCopyWithImpl<$Res>
    extends _$ExpertRegisterInfoCopyWithImpl<$Res>
    implements _$$_ExpertRegisterInfoCopyWith<$Res> {
  __$$_ExpertRegisterInfoCopyWithImpl(
      _$_ExpertRegisterInfo _value, $Res Function(_$_ExpertRegisterInfo) _then)
      : super(_value, (v) => _then(v as _$_ExpertRegisterInfo));

  @override
  _$_ExpertRegisterInfo get _value => super._value as _$_ExpertRegisterInfo;

  @override
  $Res call({
    Object? nickName = freezed,
    Object? introduce = freezed,
    Object? climbingCenterId = freezed,
    Object? tmpImage = freezed,
  }) {
    return _then(_$_ExpertRegisterInfo(
      nickName: nickName == freezed
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      introduce: introduce == freezed
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
      climbingCenterId: climbingCenterId == freezed
          ? _value.climbingCenterId
          : climbingCenterId // ignore: cast_nullable_to_non_nullable
              as int,
      tmpImage: tmpImage == freezed
          ? _value.tmpImage
          : tmpImage // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExpertRegisterInfo implements _ExpertRegisterInfo {
  const _$_ExpertRegisterInfo(
      {this.nickName = 'default',
      this.introduce = '',
      this.climbingCenterId = -1,
      @JsonKey(ignore: true) this.tmpImage});

  factory _$_ExpertRegisterInfo.fromJson(Map<String, dynamic> json) =>
      _$$_ExpertRegisterInfoFromJson(json);

  @override
  @JsonKey()
  final String nickName;
  @override
  @JsonKey()
  final String introduce;
  @override
  @JsonKey()
  final int climbingCenterId;
  @override
  @JsonKey(ignore: true)
  final File? tmpImage;

  @override
  String toString() {
    return 'ExpertRegisterInfo(nickName: $nickName, introduce: $introduce, climbingCenterId: $climbingCenterId, tmpImage: $tmpImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpertRegisterInfo &&
            const DeepCollectionEquality().equals(other.nickName, nickName) &&
            const DeepCollectionEquality().equals(other.introduce, introduce) &&
            const DeepCollectionEquality()
                .equals(other.climbingCenterId, climbingCenterId) &&
            const DeepCollectionEquality().equals(other.tmpImage, tmpImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nickName),
      const DeepCollectionEquality().hash(introduce),
      const DeepCollectionEquality().hash(climbingCenterId),
      const DeepCollectionEquality().hash(tmpImage));

  @JsonKey(ignore: true)
  @override
  _$$_ExpertRegisterInfoCopyWith<_$_ExpertRegisterInfo> get copyWith =>
      __$$_ExpertRegisterInfoCopyWithImpl<_$_ExpertRegisterInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpertRegisterInfoToJson(
      this,
    );
  }
}

abstract class _ExpertRegisterInfo implements ExpertRegisterInfo {
  const factory _ExpertRegisterInfo(
      {final String nickName,
      final String introduce,
      final int climbingCenterId,
      @JsonKey(ignore: true) final File? tmpImage}) = _$_ExpertRegisterInfo;

  factory _ExpertRegisterInfo.fromJson(Map<String, dynamic> json) =
      _$_ExpertRegisterInfo.fromJson;

  @override
  String get nickName;
  @override
  String get introduce;
  @override
  int get climbingCenterId;
  @override
  @JsonKey(ignore: true)
  File? get tmpImage;
  @override
  @JsonKey(ignore: true)
  _$$_ExpertRegisterInfoCopyWith<_$_ExpertRegisterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
