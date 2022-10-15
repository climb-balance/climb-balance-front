import 'package:climb_balance/data/repository/user_repository_impl.dart';
import 'package:climb_balance/domain/common/current_user_provider.dart';
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
  KeepAliveLink? link;

  RegisterViewModel({required this.ref, required this.repository})
      : super(const RegisterState());

  void goBack(BuildContext context) {
    if (state.curPage == 0) {
      context.pop();
      return;
    }

    state = state.copyWith(curPage: state.curPage - 1);
    validateWeightHeight();
  }

  void goNext(BuildContext context) {
    if (state.curPage == 2) {
      _register(context);
      return;
    }
    state = state.copyWith(curPage: state.curPage + 1);
    validateWeightHeight();
  }

  void updateAccessToken(String accessToken) {
    link ??= ref.keepAlive();
    state = state.copyWith(accessToken: accessToken);
  }

  void updateHeight(int height) {
    state = state.copyWith(height: height);
    validateWeightHeight();
  }

  void updateWeight(int weight) {
    state = state.copyWith(weight: weight);
    validateWeightHeight();
  }

  void updateNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void updateDescription(String value) {
    state = state.copyWith(description: value);
  }

  void updateSex(String sex) {
    state = state.copyWith(sex: sex);
  }

  void updateProfileImage(String imagePath) {
    state = state.copyWith(profileImage: imagePath);
  }

  void updatePromotionCheck(bool value) {
    state = state.copyWith(promotionCheck: value);
  }

  void updatePersonalCheck(bool value) {
    state = state.copyWith(personalCheck: value);
  }

  void updateRequiredCheck(bool value) {
    state = state.copyWith(requiredCheck: value);
  }

  void validateWeightHeight() {
    bool result = false;
    if (state.curPage == 0) {
      if (state.height >= 100 && state.height <= 200) result = true;
    } else if (state.curPage == 1) {
      if (state.weight >= 30 && state.weight <= 120) result = true;
    }
    state = state.copyWith(isValid: result);
  }

  /// 마지막에 값이 갱신될때마다 업데이트하는 함수
  void validateLast(GlobalKey<FormState> formKey) {
    bool result = false;
    if (formKey.currentState == null || !state.requiredCheck) {
      result = false;
    } else {
      result = formKey.currentState!.validate();
    }
    state = state.copyWith(isValid: result);
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
    link?.close();
  }
}
