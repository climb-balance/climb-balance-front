import 'dart:async';

import 'package:climb_balance/data/repository/story_repository_impl.dart';
import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:climb_balance/domain/common/firebase_provider.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:climb_balance/presentation/common/custom_snackbar.dart';
import 'package:climb_balance/presentation/story/models/story_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/user_repository_impl.dart';
import '../../domain/util/feedback_status.dart';
import '../../domain/util/platform_check.dart';
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
  Timer? overlayCloseTimer;

  StoryViewModel({
    required this.ref,
    required this.storyRepository,
    required this.userRepository,
  }) : super(const StoryState());

  @override
  void dispose() {
    overlayCloseTimer?.cancel();
    super.dispose();
  }

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

  void loadComments() async {
    final result = await storyRepository.getStoryComments(state.story.storyId);
    result.when(
      success: (value) {
        state = state.copyWith(comments: value);
      },
      error: (message) {},
    );
  }

  void likeStory() {
    // TODO implement
    storyRepository.likeStory();
  }

  void toggleOverlayOpen(bool isPlaying) {
    if (state.overlayOpen) {
      state = state.copyWith(overlayOpen: false);
      overlayCloseTimer?.cancel();
    } else {
      state = state.copyWith(overlayOpen: true);
      if (isPlaying) {
        overlayCloseTimer = Timer(
          const Duration(seconds: 3),
          () {
            state = state.copyWith(overlayOpen: false);
          },
        );
      }
    }
  }

  void toggleCommentOpen() {
    state = state.copyWith(commentOpen: !state.commentOpen, overlayOpen: false);
  }

  void cancelOverlayCloseTimer() {
    overlayCloseTimer?.cancel();
  }

  void requestAiFeedback(BuildContext context) async {
    final int rank =
        ref.watch(currentUserProvider.select((value) => value.rank));
    final String pushToken = ref.watch(firebaseProvider);
    // TODO 로직 되살리기
    // if (rank == 0) {
    //   context.pushNamed(aiAdsRouteName);
    //   return;
    // }
    final result =
        await storyRepository.putAiFeedback(state.story.storyId, pushToken);
    result.when(
      success: (value) {
        state = state.copyWith(
          story: state.story.copyWith(
            aiStatus: FeedbackStatus.waiting,
          ),
        );
        context.pop();
        showCustomSnackbar(
            context: context, message: 'AI 피드백 요청! 4분 정도 소요됩니다.');
      },
      error: (message) {
        Navigator.pop(context);
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

  void saveAndShare(BuildContext context) async {
    if (isMobile()) {
      final String? path =
          await storyRepository.getStoryVideo(storyId: state.story.storyId);
    } else {
      customShowDialog(
        context: context,
        title: '웹에서는 공유가 지원되지 않습니다.',
        content: '모바일을 이용해주세요',
      );
    }
  }
}
