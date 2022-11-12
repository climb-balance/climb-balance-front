import 'package:hooks_riverpod/hooks_riverpod.dart';

final splashViewModelProvider =
    StateNotifierProvider.autoDispose<SplashViewModelNotifier, double>((ref) {
  return SplashViewModelNotifier();
});

class SplashViewModelNotifier extends StateNotifier<double> {
  SplashViewModelNotifier() : super(0);

  Future<void> init({required List<Future<void> Function()> jobs}) async {
    for (final job in jobs) {
      await job();
      state = state += 1 / jobs.length;
    }
  }
}
