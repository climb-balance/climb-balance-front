class UserProfile {
  String nickName;
  String profileImagePath;
  String introduce;
  int uniqueCode;
  int height;
  int weight;

  UserProfile({
    required this.nickName,
    required this.profileImagePath,
    required this.uniqueCode,
    this.introduce = '',
    this.height = -1,
    this.weight = -1,
  });
}

UserProfile genRandomUser() {
  return UserProfile(
    nickName: '심규진',
    profileImagePath:
        'https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/avatars/00/00480565a56a710bc697f41f9a31e617d1d7a989_full.jpg',
    uniqueCode: 1234,
    height: 160,
    weight: 50,
    introduce: '안녕하세요. 즐거운 클라이밍해요!!',
  );
}
