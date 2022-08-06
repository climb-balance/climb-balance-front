// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expert_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpertProfile _$$_ExpertProfileFromJson(Map<String, dynamic> json) =>
    _$_ExpertProfile(
      nickName: json['nickName'] as String? ?? 'default',
      profileImagePath: json['profileImagePath'] as String? ??
          'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
      introduce: json['introduce'] as String? ?? '',
    );

Map<String, dynamic> _$$_ExpertProfileToJson(_$_ExpertProfile instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'profileImagePath': instance.profileImagePath,
      'introduce': instance.introduce,
    };
