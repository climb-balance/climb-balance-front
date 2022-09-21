import 'package:climb_balance/data/repository/story_repository_impl.dart';
import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:climb_balance/domain/const/route_name.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:climb_balance/presentation/story/story_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/user_repository_impl.dart';
import '../../domain/util/feedback_status.dart';
import '../common/custom_dialog.dart';

final storyViewModelProvider = StateNotifierProvider.family
    .autoDispose<StoryViewModel, StoryState, int>((ref, storyId) {
  StoryViewModel notifier = StoryViewModel(
    ref: ref,
    storyRepository: ref.watch(storyRepositoryImplProvider),
    userRepository: ref.watch(userRepositoryImplProvider),
  );
  notifier._init(storyId);
  return notifier;
});

class StoryViewModel extends StateNotifier<StoryState> {
  final AutoDisposeStateNotifierProviderRef<StoryViewModel, StoryState> ref;
  final StoryRepository storyRepository;
  final UserRepositoryImpl userRepository;

  StoryViewModel({
    required this.ref,
    required this.storyRepository,
    required this.userRepository,
  }) : super(const StoryState());

  void _init(int storyId) async {
    final result = await storyRepository.getStoryById(storyId);
    result.when(
      success: (value) async {
        state = state.copyWith(story: value);
        _updateUploader(state.story.uploaderId);
      },
      error: (message) => {},
    );
  }

  void _updateUploader(int uploaderId) async {
    final result = await userRepository.getUserProfileById(uploaderId);
    result.when(
      success: (value) {
        state = state.copyWith(
          uploader: value,
        );
      },
      error: (message) {},
    );
  }

  void likeStory() {
    // TODO implement
    storyRepository.likeStory();
  }

  void requestAiFeedback(BuildContext context) async {
    final int rank =
        ref.watch(currentUserProvider.select((value) => value.rank));
    if (rank == 0) {
      context.pushNamed(aiAdsRouteName);
      return;
    }
    final result = await storyRepository.putAiFeedback(state.story.storyId);
    result.when(
      success: (value) {
        state = state.copyWith(
          story: state.story.copyWith(
            aiStatus: FeedbackStatus.waiting,
          ),
        );
        customShowDialog(
            context: context,
            title: 'AI 피드백 요청 성공',
            content: 'AI 피드백 요청에 성공하셨습니다. 메인 화면에서 진행 상태를 확인하실 수 있습니다.');
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
    return storyRepository.getStoryVideoPathById(state.story.storyId);
  }
}
