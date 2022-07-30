class UserProfile {
  String nickName;
  String profileImagePath;
  int uniqueCode;
  int height;
  int weight;

  UserProfile({
    required this.nickName,
    required this.profileImagePath,
    required this.uniqueCode,
    this.height = -1,
    this.weight = -1,
  });
}

UserProfile genRandomUser() {
  return UserProfile(
    nickName: '심규진',
    profileImagePath: 'https://i.imgur.com/2tCh01l.jpeg',
    uniqueCode: 1234,
    height: 160,
    weight: 50,
  );
}
