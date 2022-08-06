import 'package:climb_balance/models/user.dart';
import 'package:climb_balance/utils/storage/token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentUserNotifier extends StateNotifier<UserProfile> {
  final ref;

  CurrentUserNotifier({required this.ref}) : super(const UserProfile());

  bool isEmpty() {
    return state.token == '';
  }

  void updateToken({required String token}) {
    state = state.copyWith(token: token);
    storeStoredToken(token: token);
  }

  void clearToken() {
    state = state.copyWith(token: '');
    clearStoredToken();
  }

  // https://stackoverflow.com/questions/64285037/flutter-riverpod-initialize-with-async-values
  void loadTokenFromStorage() {
    getStoredToken().then((value) {
      loadUserInfo(value['token'] ?? '');
    });
  }

  void loadUserInfo(String token) {
    // 원래는 로그인으로 보내는 로직이 있어야할 것 같음.
    state = genRandomUser().copyWith(token: token);
    if (token == '') {
      return;
    }
  }
}

final currentUserProvider =
    StateNotifierProvider<CurrentUserNotifier, UserProfile>((ref) {
  CurrentUserNotifier notifier = CurrentUserNotifier(ref: ref);
  notifier.loadTokenFromStorage();
  return notifier;
});
