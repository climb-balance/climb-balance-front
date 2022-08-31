import 'dart:async';

import 'package:climb_balance/providers/firebase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../models/feedback_status.dart';

class FeedbackStatusNotifier extends StateNotifier<FeedbackStatus> {
  final StateNotifierProviderRef<FeedbackStatusNotifier, FeedbackStatus> ref;

  FeedbackStatusNotifier({required this.ref}) : super(const FeedbackStatus());

  void addTimer({required Duration timerTime}) {
    ref.watch(firebaseProvider);
    state = FeedbackStatus(
        aiIsWaiting: true, aiLeftTime: timerTime, aiWaitingTime: timerTime);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.aiLeftTime.inSeconds <= 0) {
        timer.cancel();
        state = const FeedbackStatus(aiIsWaiting: false);
      } else {
        state = FeedbackStatus(
          aiIsWaiting: true,
          aiLeftTime: state.aiLeftTime - const Duration(seconds: 1),
          aiWaitingTime: state.aiWaitingTime,
        );
      }
    });
  }

  void clearTimer() {
    state = FeedbackStatus(
      finishedExpertFeedback: state.finishedExpertFeedback,
      waitingExpertFeedback: state.waitingExpertFeedback,
    );
  }
}

final feedbackStatusProvider =
    StateNotifierProvider<FeedbackStatusNotifier, FeedbackStatus>((ref) {
  FeedbackStatusNotifier notifier = FeedbackStatusNotifier(ref: ref);
  return notifier;
});
