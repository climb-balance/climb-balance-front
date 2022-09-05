import 'package:climb_balance/data/repository/story_repository_impl.dart';
import 'package:climb_balance/domain/model/story.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:climb_balance/presentation/story/story_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/user_provider.dart';
import '../ai_feedback/ai_feedback_ads_screen.dart';
import '../common/custom_dialog.dart';

final storyViewModelProvider = StateNotifierProvider.family
    .autoDispose<StoryViewModel, Story, Story>((ref, Story story) {
  StoryViewModel notifier = StoryViewModel(
    story: story,
    ref: ref,
    repository: ref.watch(storyRepositoryImplProvider),
  );
  return notifier;
});

class StoryViewModel extends StateNotifier<Story> {
  final AutoDisposeStateNotifierProviderRef<StoryViewModel, Story> ref;
  final StoryRepository repository;

  StoryViewModel(
      {required Story story, required this.ref, required this.repository})
      : super(story);

  void onEvent(StoryEvent event) {
    event.when(
      likeStory: _likeStory,
      requestAiFeedback: _requestAiFeedback,
      requestExpertFeedback: (BuildContext context) {},
      loadComments: () {},
    );
  }

  void _likeStory() {
    // TODO implement
    repository.likeStory();
  }

  void _requestAiFeedback(BuildContext context) async {
    final int rank = ref.watch(userProvider.select((value) => value.rank));
    if (rank == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const AiFeedbackAdsScreen()));
      return;
    }
    final result = await repository.putAiFeedback(state.storyId);
    result.when(
      success: (value) {
        state = state.copyWith(aiAvailable: 1);
        customShowDialog(
                context: context,
                title: 'AI 피드백 요청 성공',
                content: 'AI 피드백 요청에 성공하셨습니다. 메인 화면에서 진행 상태를 확인하실 수 있습니다.')
            .then(
          (value) => Navigator.pop(context),
        );
      },
      error: (message) {
        customShowDialog(
            context: context,
            title: 'AI 피드백 요청 실패',
            content: 'AI 피드백 요청에 실패했습니다. \n에러 원인 : $message');
      },
    );
  }

  String getStoryVideoPath() {
    return repository.getStoryVideoPathById(state.storyId);
  }
}
