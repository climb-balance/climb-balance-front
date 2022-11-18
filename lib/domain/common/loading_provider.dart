import 'package:climb_balance/domain/model/loading_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingProvider =
    StateNotifierProvider<LoadingNotifier, LoadingState>((ref) {
  return LoadingNotifier();
});

class LoadingNotifier extends StateNotifier<LoadingState> {
  LoadingNotifier() : super(const LoadingState());

  void closeLoading() {
    state = state.copyWith(isLoading: false);
  }

  void openLoading() {
    state = state.copyWith(isLoading: true);
  }

  void updateProgress(int progress) {
    if (progress == -1 || progress == 100) {
      state = state.copyWith(progress: null, isLoading: false);
      return;
    }

    state = state.copyWith(progress: progress, isLoading: true);
  }
}
