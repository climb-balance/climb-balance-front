import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'register_state.dart';

class RegisterViewModel extends StateNotifier<RegisterState> {
  RegisterViewModel() : super(RegisterState());

  void updateHeight(int value) {
    state = RegisterState(
        height: value,
        weight: state.weight,
        sex: state.sex,
        curPage: state.curPage);
  }

  void updateWeight(int value) {
    state = RegisterState(
        height: state.height,
        weight: value,
        sex: state.sex,
        curPage: state.curPage);
  }

  void updateSex(bool value) {
    state = RegisterState(
        height: state.height,
        weight: state.weight,
        sex: value,
        curPage: state.curPage);
  }

  void nextPage() {
    state = RegisterState(
        height: state.height,
        weight: state.weight,
        sex: state.sex,
        curPage: (state.curPage + 1) % 2);
  }

  void lastPage() {
    state = RegisterState(
        height: state.height,
        weight: state.weight,
        sex: state.sex,
        curPage: (state.curPage - 1) % 2);
  }
}

final registerViewModelProvider =
    StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
  RegisterViewModel notifier = RegisterViewModel();
  return notifier;
});
