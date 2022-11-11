import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingProvider = StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier();
});

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier() : super(false);

  void closeLoading() {
    state = false;
  }

  void openLoading() {
    state = true;
  }
}
