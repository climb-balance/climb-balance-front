import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/expert_register_info.dart';

class ExpertRegisterNotifier extends StateNotifier<ExpertRegisterInfo> {
  ExpertRegisterNotifier() : super(const ExpertRegisterInfo());

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

  void updateNickName(String nickName) {
    state = state.copyWith(nickName: nickName);
  }

  void updateIntroduce(String introduce) {
    state = state.copyWith(introduce: introduce);
  }

  void clear() {
    state = const ExpertRegisterInfo();
  }
}

final expertRegisterProvider = StateNotifierProvider.autoDispose<
    ExpertRegisterNotifier, ExpertRegisterInfo>((ref) {
  ExpertRegisterNotifier notifier = ExpertRegisterNotifier();
  return notifier;
});
