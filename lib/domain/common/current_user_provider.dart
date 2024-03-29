import 'package:climb_balance/data/data_source/service/storage_service.dart';
import 'package:climb_balance/data/repository/user_repository_impl.dart';
import 'package:climb_balance/domain/model/user.dart';
import 'package:climb_balance/domain/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../const/route_name.dart';
import '../model/expert_profile.dart';
import '../model/result.dart';
import '../model/update_user.dart';

final currentUserProvider =
    StateNotifierProvider<CurrentUserNotifier, User>((ref) {
  CurrentUserNotifier notifier = CurrentUserNotifier(
    ref: ref,
    storageService: ref.watch(storageServiceProvider),
    repository: ref.watch(userRepositoryImplProvider),
  );

  return notifier;
});

class CurrentUserNotifier extends StateNotifier<User> {
  final ref;

  // TODO by repository
  final StorageService storageService;
  final UserRepository repository;

  CurrentUserNotifier({
    required this.ref,
    required this.storageService,
    required this.repository,
  }) : super(const User());

  Future<void> init() async {
    await loadTokenFromStorage();
  }

  // https://stackoverflow.com/questions/64285037/flutter-riverpod-initialize-with-async-values
  Future<void> loadTokenFromStorage() async {
    final token = await storageService.getStoredToken();
    debugPrint(token);
    await loadUserInfo(token);
  }

  bool isEmpty() {
    return state.accessToken == '';
  }

  void updateToken({required String accessToken}) {
    state = state.copyWith(accessToken: accessToken);
    storageService.storeStoredToken(token: accessToken);
    loadUserInfo(accessToken);
  }

  void logout(BuildContext context) async {
    state = state.copyWith(accessToken: '');
    storageService.clearStoredToken();
    CookieManager().clearCookies();
    context.goNamed(authPageRouteName);
  }

  Future<void> loadUserInfo(String token, {String? imagePath}) async {
    final Result<User> result = await repository.getCurrentUserProfile(token);
    result.when(
      success: (value) {
        if (imagePath == null) {
          state = value.copyWith(
            accessToken: token,
          );
        } else {
          state = value.copyWith(
            accessToken: token,
            profileImage: imagePath!,
          );
        }
      },
      error: (message) {
        // TODO logout -> page move
      },
    );
  }

  Future<void> refreshUserInfo() async {
    final result = await repository.getCurrentUserProfile(state.accessToken);
    result.when(
      success: (value) {
        state = value.copyWith(accessToken: state.accessToken);
      },
      error: (message) {
        // TODO logout -> page move
      },
    );
  }

  void updateUserInfo({
    String? description,
    String? nickname,
    String? profileImage,
    bool? promotionCheck,
    bool? personalCheck,
  }) async {
    UpdateUser updateUser = UpdateUser(
      description: description,
      nickname: nickname,
      promotionCheck: promotionCheck,
      personalCheck: personalCheck,
      profileImage: profileImage,
    );
    await repository.updateUser(
      accessToken: state.accessToken,
      updateUser: updateUser,
    );

    loadUserInfo(state.accessToken, imagePath: profileImage);
  }

  void updateExpertInfo(ExpertProfile profile) {
    state = state.copyWith(expertProfile: profile, isExpert: true);
  }

  void removeUserAccount(BuildContext context) {
    repository.deleteUser(state.accessToken);
    logout(context);
  }
}
