import 'dart:math';

import 'package:climb_balance/models/expert_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class UserProfile with _$UserProfile {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserProfile({
    @Default('default') String nickName,
    @Default('https://i.ibb.co/d6SZN17/20220320-214742.jpg')
        String profileImage,
    @Default('') String description,
    @Default('') String token,
    @Default(1234) int uniqueTag,
    @Default(-1) int height,
    @Default(-1) int weight,
    @Default(false) bool isExpert,
    @Default(0) int rank,
    @Default(1) int userId,
    ExpertProfile? expertProfile,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, Object?> json) =>
      _$UserProfileFromJson(json);
}

UserProfile genRandomUser({bool isExpert = true}) {
  Random random = Random(1);
  if (isExpert) {
    return const UserProfile(
      nickName: '심규진',
      profileImage: 'https://i.ibb.co/d6SZN17/20220320-214742.jpg',
      uniqueTag: 1234,
      height: 160,
      weight: 50,
      description: '안녕하세요. 즐거운 클라이밍해요!!',
      isExpert: true,
      rank: 2,
    );
  }
  return UserProfile(
    nickName: '심규진',
    profileImage: 'https://i.ibb.co/d6SZN17/20220320-214742.jpg',
    uniqueTag: 1234,
    height: 160,
    weight: 50,
    description: '안녕하세요. 즐거운 클라이밍해요!!',
    rank: random.nextInt(2) - 1,
  );
}
