import 'dart:math';

import 'package:climb_balance/models/expert_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @Default('default') String nickName,
    @Default('https://i.ibb.co/d6SZN17/20220320-214742.jpg')
        String profileImage,
    @Default('') String description,
    @Default('') String token,
    @Default(-1) int height,
    @Default(-1) int weight,
    @Default(false) bool isExpert,
    @Default(0) int rank,
    @Default(-1) int userId,
    ExpertProfile? expertProfile,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

User genRandomUser({bool isExpert = true}) {
  Random random = Random(1);
  if (isExpert) {
    return const User(
      nickName: '심규진',
      profileImage: 'https://i.ibb.co/d6SZN17/20220320-214742.jpg',
      height: 160,
      weight: 50,
      description: '안녕하세요. 즐거운 클라이밍해요!!',
      isExpert: false,
      rank: 2,
    );
  }
  return User(
    nickName: '심규진',
    profileImage: 'https://i.ibb.co/d6SZN17/20220320-214742.jpg',
    height: 160,
    weight: 50,
    description: '안녕하세요. 즐거운 클라이밍해요!!',
    rank: random.nextInt(2) - 1,
  );
}
