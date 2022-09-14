import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'expert_register_state.dart';

class ExpertRegisterViewModel extends StateNotifier<ExpertRegisterState> {
  ExpertRegisterViewModel() : super(const ExpertRegisterState());

  void updateProfilePicture(File image) {
    state = state.copyWith(tmpImage: image);
  }

  Future<bool> updateClimbingCode(String code) async {
    if (code.length == 4) {
      state = state.copyWith(code: code);
      return true;
    }
    return false;
  }

  void updateNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void clear() {
    state = const ExpertRegisterState();
  }
}

final expertRegisterViewModelProvider = StateNotifierProvider.autoDispose<
    ExpertRegisterViewModel, ExpertRegisterState>((ref) {
  ExpertRegisterViewModel notifier = ExpertRegisterViewModel();
  return notifier;
});
