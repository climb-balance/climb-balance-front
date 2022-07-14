import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncStatus extends StateNotifier<bool> {
  AsyncStatus() : super(false);

  void toggleLoading() {
    state = !state;
  }
}

final asyncStatusProvider = StateNotifierProvider<AsyncStatus, bool>((ref) {
  AsyncStatus notifier = AsyncStatus();
  return notifier;
});
