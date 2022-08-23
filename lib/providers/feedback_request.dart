import 'package:climb_balance/models/result.dart';
import 'package:climb_balance/providers/firebase.dart';
import 'package:climb_balance/services/server_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../models/feedback_status.dart';

class FeedbackRequestNotifier extends StateNotifier<void> {
  final StateNotifierProviderRef<FeedbackRequestNotifier, void> ref;

  FeedbackRequestNotifier({required this.ref}) : super(const FeedbackStatus());

  Future<Result<bool>> requestAi(int storyId) async {
    final String pushToken = ref.watch(firebaseProvider)!;
    final result = await ServerService.putAiFeedback(storyId, pushToken);
    return result;
  }

  void requestExpert(int storyId) {}
}

final feedbackRequestProvider =
    StateNotifierProvider<FeedbackRequestNotifier, void>((ref) {
  FeedbackRequestNotifier notifier = FeedbackRequestNotifier(ref: ref);
  return notifier;
});
