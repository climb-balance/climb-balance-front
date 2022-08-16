import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class FeedbackStatus {
  final Duration leftTime;
  final bool waiting;

  const FeedbackStatus({
    this.leftTime = const Duration(
      seconds: 0,
    ),
    this.waiting = false,
  });
}

class AiFeedbackStatusNotifier extends StateNotifier<FeedbackStatus> {
  final ref;

  AiFeedbackStatusNotifier({required this.ref}) : super(const FeedbackStatus());

  void addTimer({required Duration timerTime}) {
    state = FeedbackStatus(waiting: true, leftTime: timerTime);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.leftTime.inSeconds == 0) {
        timer.cancel();
      }
      state = FeedbackStatus(
        waiting: true,
        leftTime: state.leftTime - const Duration(seconds: 1),
      );
    });
  }
}

final aiFeedbackStatusNotifier =
    StateNotifierProvider<AiFeedbackStatusNotifier, FeedbackStatus>((ref) {
  AiFeedbackStatusNotifier notifier = AiFeedbackStatusNotifier(ref: ref);
  return notifier;
});
