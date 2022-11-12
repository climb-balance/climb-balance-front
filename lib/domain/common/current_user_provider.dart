import 'package:climb_balance/data/data_source/service/storage_service.dart';
import 'package:climb_balance/data/repository/user_repository_impl.dart';
import 'package:climb_balance/domain/model/user.dart';
import 'package:climb_balance/domain/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../const/route_name.dart';
import '../model/expert_profile.dart';

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

  void logout(BuildContext context) {
    state = state.copyWith(accessToken: '');
    storageService.clearStoredToken();
    context.goNamed(authPageRouteName);
  }

  Future<void> loadUserInfo(String token) async {
    final result = await repository.getCurrentUserProfile(token);
    result.when(
      success: (value) {
        state = value.copyWith(accessToken: token);
      },
      error: (message) {
        // TODO logout -> page move
      },
    );
  }

  void updateUserInfo(User user) {
    state = user;
  }

  void updateExpertInfo(ExpertProfile profile) {
    state = state.copyWith(expertProfile: profile, isExpert: true);
  }

  void removeUserAccount(BuildContext context) {
    repository.deleteUser(state.accessToken);
    logout(context);
  }
}
