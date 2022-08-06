import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    @Default('default_user') String nickName,
    @Default('https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg')
        String profileImagePath,
    @Default('') String introduce,
    @Default('') String token,
    @Default(1234) int uniqueCode,
    @Default(-1) int height,
    @Default(-1) int weight,
    @Default(false) bool isExpert,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, Object?> json) =>
      _$UserProfileFromJson(json);
}

UserProfile genRandomUser({bool isExpert = false}) {
  if (isExpert) {
    return const UserProfile(
      nickName: '심규진',
      profileImagePath:
          'https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/avatars/00/00480565a56a710bc697f41f9a31e617d1d7a989_full.jpg',
      uniqueCode: 1234,
      height: 160,
      weight: 50,
      introduce: '안녕하세요. 즐거운 클라이밍해요!!',
      isExpert: true,
    );
  }
  return const UserProfile(
    nickName: '심규진',
    profileImagePath:
        'https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/avatars/00/00480565a56a710bc697f41f9a31e617d1d7a989_full.jpg',
    uniqueCode: 1234,
    height: 160,
    weight: 50,
    introduce: '안녕하세요. 즐거운 클라이밍해요!!',
  );
}
