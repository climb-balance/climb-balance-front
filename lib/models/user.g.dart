// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProfile _$$_UserProfileFromJson(Map<String, dynamic> json) =>
    _$_UserProfile(
      nickName: json['nickName'] as String? ?? 'default',
      profileImage: json['profileImage'] as String? ??
          'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
      description: json['description'] as String? ?? '',
      token: json['token'] as String? ?? '',
      uniqueTag: json['uniqueTag'] as int? ?? 1234,
      height: json['height'] as int? ?? -1,
      weight: json['weight'] as int? ?? -1,
      isExpert: json['isExpert'] as bool? ?? false,
      rank: json['rank'] as int? ?? 0,
      expertProfile: json['expertProfile'] == null
          ? null
          : ExpertProfile.fromJson(
              json['expertProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserProfileToJson(_$_UserProfile instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'profileImage': instance.profileImage,
      'description': instance.description,
      'token': instance.token,
      'uniqueTag': instance.uniqueTag,
      'height': instance.height,
      'weight': instance.weight,
      'isExpert': instance.isExpert,
      'rank': instance.rank,
      'expertProfile': instance.expertProfile,
    };
