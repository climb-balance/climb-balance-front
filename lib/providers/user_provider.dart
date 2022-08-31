import 'package:climb_balance/models/expert_profile.dart';
import 'package:climb_balance/models/user.dart';
import 'package:climb_balance/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<UserProfile> {
  final ref;

  UserNotifier({required this.ref}) : super(const UserProfile());

  bool isEmpty() {
    return state.token == '';
  }

  void updateToken({required String token}) {
    state = state.copyWith(token: token);
    StorageService.storeStoredToken(token: token);
  }

  void clearToken() {
    state = state.copyWith(token: '');
    StorageService.clearStoredToken();
  }

  // https://stackoverflow.com/questions/64285037/flutter-riverpod-initialize-with-async-values
  void loadTokenFromStorage() {
    StorageService.getStoredToken().then((value) {
      loadUserInfo(value['token'] ?? '');
    });
  }

  void loadUserInfo(String token) {
    state = genRandomUser().copyWith(token: token);
    if (token == '') {
      return;
    }
  }

  void updateExpertInfo(ExpertProfile profile) {
    state = state.copyWith(expertProfile: profile, isExpert: true);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserProfile>((ref) {
  UserNotifier notifier = UserNotifier(ref: ref);
  notifier.loadTokenFromStorage();
  return notifier;
});
