import 'dart:math';

import 'package:climb_balance/presentation/story/story_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/story_repository_impl.dart';
import '../../domain/model/story.dart';
import '../../domain/repository/story_repository.dart';
import 'models/ai_feedback_state.dart';

final aiFeedbackViewModelProvider = StateNotifierProvider.autoDispose
    .family<AiFeedbackViewModel, AiFeedbackState, int>((ref, storyId) {
  AiFeedbackViewModel notifier = AiFeedbackViewModel(
    ref.watch(storyRepositoryImplProvider),
    ref.watch(storyViewModelProvider(storyId).select((value) => value.story)),
  );
  notifier._loadDatas();
  return notifier;
});

class AiFeedbackViewModel extends StateNotifier<AiFeedbackState> {
  final StoryRepository repository;
  final Story story;

  AiFeedbackViewModel(this.repository, this.story)
      : super(const AiFeedbackState());

  void _loadDatas() async {
    final result = await repository.getStoryAiDetailById(story.storyId);
    result.when(
      success: (value) {
        state = value;
      },
      error: (message) {},
    );
  }

  String getStoryAiVideoPath() {
    return repository.getStoryVideoPathById(story.storyId, isAi: true);
  }

  void toggleInformation() {
    state = state.copyWith(isInformOpen: !state.isInformOpen);
  }

  void toggleLineOverlay() {
    state = state.copyWith(lineOverlay: !state.lineOverlay);
  }

  void toggleSquareOverlay() {
    state = state.copyWith(squareOverlay: !state.squareOverlay);
  }

  void togglePlayingStatus() {
    state = state.copyWith(isStatusChanging: true);
    Future.delayed(const Duration(milliseconds: 300), () {
      state = state.copyWith(isStatusChanging: false);
    });
  }

  int longestGoodLength() {
    int maxLength = 0;
    int curLength = 0;
    for (int i = 0; i < state.scores.length; i++) {
      if (state.scores[i] == 1) {
        curLength += 1;
        maxLength = max(maxLength, curLength);
      } else {
        curLength = 0;
      }
    }

    return maxLength;
  }

  int goodCount() {
    int curLength = 0;
    for (int i = 0; i < state.scores.length; i++) {
      if (state.scores[i] == 1) {
        curLength += 1;
      }
    }
    return curLength;
  }
}
