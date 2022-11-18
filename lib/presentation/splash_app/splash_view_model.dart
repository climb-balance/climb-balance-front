import 'package:climb_balance/presentation/splash_app/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final splashViewModelProvider =
    StateNotifierProvider.autoDispose<SplashViewModelNotifier, SplashState>(
        (ref) {
  return SplashViewModelNotifier();
});

class SplashViewModelNotifier extends StateNotifier<SplashState> {
  SplashViewModelNotifier() : super(SplashState());

  Future<void> init({required List<Future<void> Function()> jobs}) async {
    for (final job in jobs) {
      try {
        await job();
      } catch (e) {
        debugPrint('초기화 오류 : ${e.toString()}');
        state = state.copyWith(error: e.toString());
        rethrow;
      }
      state = state.copyWith(progress: state.progress + 1 / jobs.length);
    }
  }
}
