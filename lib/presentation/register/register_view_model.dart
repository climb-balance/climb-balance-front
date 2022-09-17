import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'register_state.dart';

final registerViewModelProvider =
    StateNotifierProvider.autoDispose<RegisterViewModel, RegisterState>((ref) {
  RegisterViewModel notifier = RegisterViewModel();
  return notifier;
});

class RegisterViewModel extends StateNotifier<RegisterState> {
  RegisterViewModel() : super(const RegisterState());
  void updateAccessToken(String accessToken) {
    state = state.copyWith(accessToken: accessToken);
  }

  void updateHeight(int height) {
    state = state.copyWith(height: height);
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

  void nextPage() {
    state = state.copyWith(curPage: (state.curPage + 1) % 2);
  }

  void lastPage() {
    state = state.copyWith(curPage: (state.curPage - 1) % 2);
  }
}
