class UserProfile {
  String nickName;
  String profileImagePath;
  int uniqueCode;

  UserProfile(
      {required this.nickName,
      required this.profileImagePath,
      required this.uniqueCode});
}

UserProfile genRandomUser() {
  return UserProfile(
    nickName: '1234',
    profileImagePath: 'https://i.imgur.com/7yteESU.jpeg',
    uniqueCode: 1234,
  );
}
