import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'expert_profile.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @Default('default') String nickname,
    @Default('https://i.ibb.co/d6SZN17/20220320-214742.jpg')
        String profileImage,
    @Default('') String description,
    @Default('') String accessToken,
    @Default(-1) int height,
    @Default(-1) int weight,
    @Default(false) bool isExpert,
    @Default(0) int rank,
    @Default(-1) int userId,
    ExpertProfile? expertProfile,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

// TODO REMOVE
User genRandomUser({bool isExpert = true}) {
  Random random = Random(1);
  if (isExpert) {
    return const User(
      nickname: '심규진',
      profileImage: 'https://i.ibb.co/d6SZN17/20220320-214742.jpg',
      height: 160,
      weight: 50,
      description: '안녕하세요. 즐거운 클라이밍해요!!',
      isExpert: false,
      rank: 2,
    );
  }
  return User(
    nickname: '심규진',
    profileImage: 'https://i.ibb.co/d6SZN17/20220320-214742.jpg',
    height: 160,
    weight: 50,
    description: '안녕하세요. 즐거운 클라이밍해요!!',
    rank: random.nextInt(2) - 1,
  );
}
