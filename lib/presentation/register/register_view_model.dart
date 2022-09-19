import 'package:climb_balance/data/repository/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/repository/user_repository.dart';
import 'register_state.dart';

final registerViewModelProvider =
    StateNotifierProvider.autoDispose<RegisterViewModel, RegisterState>((ref) {
  RegisterViewModel notifier = RegisterViewModel(
      ref: ref, repository: ref.watch(userRepositoryImplProvider));
  return notifier;
});

class RegisterViewModel extends StateNotifier<RegisterState> {
  AutoDisposeStateNotifierProviderRef<RegisterViewModel, RegisterState> ref;
  UserRepository repository;
  RegisterViewModel({required this.ref, required this.repository})
      : super(const RegisterState());

  void updateAccessToken(String accessToken) {
    state = state.copyWith(accessToken: accessToken);
  }

  void updateHeight(int height) {
    state = state.copyWith(height: height);
  }

  void updateNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void updateWeight(int weight) {
    state = state.copyWith(weight: weight);
  }

  void updateSex(bool value) {
    String ch = 'F';
    if (value) {
      ch = 'M';
    }
    state = state.copyWith(sex: ch);
  }

  void updateProfileImage(String imagePath) {
    state = state.copyWith(profileImage: imagePath);
  }

  /// form을 검증하는 함수
  /// 이후 _register를 호출해 업로드한다.
  void validate(GlobalKey<FormState> formKey, BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('성공')),
    );

    context.pop();
    return;
  }

  void _register() async {}

  void nextPage() {
    state = state.copyWith(curPage: (state.curPage + 1) % 2);
  }

  void lastPage() {
    state = state.copyWith(curPage: (state.curPage - 1) % 2);
  }
}
