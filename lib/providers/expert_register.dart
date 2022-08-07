import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/expert_register_info.dart';

class ExpertRegisterNotifier extends StateNotifier<ExpertRegisterInfo> {
  ExpertRegisterNotifier() : super(const ExpertRegisterInfo());

  void updateProfilePicture(File image) {
    state = state.copyWith(tmpImage: image);
  }
}

final expertRegisterProvider =
    StateNotifierProvider<ExpertRegisterNotifier, ExpertRegisterInfo>((ref) {
  ExpertRegisterNotifier notifier = ExpertRegisterNotifier();
  return notifier;
});
