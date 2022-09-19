import 'package:climb_balance/data/data_source/service/storage_service.dart';
import 'package:climb_balance/data/data_source/user_server_helper.dart';
import 'package:climb_balance/domain/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../const/route_name.dart';
import '../model/expert_profile.dart';

class CurrentUserNotifier extends StateNotifier<User> {
  final ref;

  // TODO by repository
  final StorageService storageService;
  final UserServerHelper server;

  CurrentUserNotifier({
    required this.ref,
    required this.storageService,
    required this.server,
  }) : super(const User());

  bool isEmpty() {
    return state.accessToken == '';
  }

  void updateToken({required String accessToken}) {
    state = state.copyWith(accessToken: accessToken);
    storageService.storeStoredToken(token: accessToken);
  }

  void logout(BuildContext context) {
    state = state.copyWith(accessToken: '');
    storageService.clearStoredToken();
    context.goNamed(authPageRouteName);
  }

  // https://stackoverflow.com/questions/64285037/flutter-riverpod-initialize-with-async-values
  void loadTokenFromStorage() {
    storageService.getStoredToken().then((value) {
      loadUserInfo(value['token'] ?? '');
    });
  }

  void loadUserInfo(String token) async {
    if (token == '') {
      // TODO logout -> page move
      return;
    }
    final result = await server.getCurrentUserProfile();
    result.when(
      success: (value) {
        state = value.copyWith(token: token);
      },
      error: (message) {
        // TODO logout -> page move
      },
    );
  }

  void updateExpertInfo(ExpertProfile profile) {
    state = state.copyWith(expertProfile: profile, isExpert: true);
  }
}

final currentUserProvider =
    StateNotifierProvider<CurrentUserNotifier, User>((ref) {
  CurrentUserNotifier notifier = CurrentUserNotifier(
    ref: ref,
    storageService: ref.watch(storageServiceProvider),
    server: ref.watch(userServerHelperProvider),
  );
  notifier.loadTokenFromStorage();
  return notifier;
});
