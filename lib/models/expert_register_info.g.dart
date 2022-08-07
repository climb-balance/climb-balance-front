// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expert_register_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpertRegisterInfo _$$_ExpertRegisterInfoFromJson(
        Map<String, dynamic> json) =>
    _$_ExpertRegisterInfo(
      nickName: json['nickName'] as String? ?? 'default',
      introduce: json['introduce'] as String? ?? '',
      climbingCenterId: json['climbingCenterId'] as int? ?? -1,
      code: json['code'] as String? ?? '',
    );

Map<String, dynamic> _$$_ExpertRegisterInfoToJson(
        _$_ExpertRegisterInfo instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'introduce': instance.introduce,
      'climbingCenterId': instance.climbingCenterId,
      'code': instance.code,
    };
