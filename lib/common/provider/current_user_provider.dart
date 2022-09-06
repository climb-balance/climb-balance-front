import 'package:climb_balance/data/data_source/service/storage_service.dart';
import 'package:climb_balance/data/data_source/user_server_helpder.dart';
import 'package:climb_balance/domain/model/user.dart';
import 'package:climb_balance/models/expert_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentUserNotifier extends StateNotifier<User> {
  final ref;
  final StorageService storageService;
  final UserServerHelper server;

  CurrentUserNotifier({
    required this.ref,
    required this.storageService,
    required this.server,
  }) : super(const User());

  bool isEmpty() {
    return state.token == '';
  }

  void updateToken({required String token}) {
    state = state.copyWith(token: token);
    storageService.storeStoredToken(token: token);
  }

  void clearToken() {
    state = state.copyWith(token: '');
    storageService.clearStoredToken();
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
