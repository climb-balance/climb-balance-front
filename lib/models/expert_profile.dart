import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'expert_profile.freezed.dart';

part 'expert_profile.g.dart';

@freezed
class ExpertProfile with _$ExpertProfile {
  const factory ExpertProfile({
    @Default('default') String nickName,
    @Default('https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg')
        String profileImagePath,
    @Default('') String introduce,
    @Default(-1) int climbingCenterId,
    @Default(-1) int id,
    @Default(50.0) double reliability,
    @JsonKey(ignore: true) File? tmpImage,
  }) = _ExpertProfile;

  factory ExpertProfile.fromJson(Map<String, dynamic> json) =>
      _$ExpertProfileFromJson(json);
}
