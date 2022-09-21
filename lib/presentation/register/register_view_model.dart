import 'package:climb_balance/data/repository/user_repository_impl.dart';
import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/repository/user_repository.dart';
import 'register_state.dart';

final registerViewModelProvider =
    StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
  RegisterViewModel notifier = RegisterViewModel(
      ref: ref, repository: ref.watch(userRepositoryImplProvider));
  return notifier;
});

class RegisterViewModel extends StateNotifier<RegisterState> {
  StateNotifierProviderRef<RegisterViewModel, RegisterState> ref;
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

  void updateDescription(String value) {
    state = state.copyWith(description: value);
  }

  void updateSex(bool isMale) {
    String ch = 'F';
    if (isMale) {
      ch = 'M';
    }
    state = state.copyWith(sex: ch);
  }

  void updateProfileImage(String imagePath) {
    state = state.copyWith(profileImage: imagePath);
  }

  /// form을 검증하는 함수
  /// 이후 _register를 호출해 업로드한다.
  void validate(GlobalKey<FormState> formKey, BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _register(context);
  }

  /// 회원가입을 진행하는 함수
  /// 성공시 토큰을 업데이트하고 pop한다.
  /// 실패시 알려준다.
  void _register(BuildContext context) async {
    repository.createUser(state).then(
          (result) => result.when(
            success: (value) {
              ref
                  .read(currentUserProvider.notifier)
                  .updateToken(accessToken: state.accessToken);
              context.pop();
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('성공')),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('회원가입 실패 $message')),
              );
            },
          ),
        );
  }
}
