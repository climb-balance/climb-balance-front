import 'dart:async';

import 'package:better_player/better_player.dart';
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
import '../../domain/const/route_name.dart';
import '../../domain/model/result.dart';
import '../../domain/util/feedback_status.dart';
import '../../domain/util/platform_check.dart';
import '../common/components/videos/video_error.dart';
import '../common/components/videos/video_loading.dart';
import '../common/custom_dialog.dart';
import 'components/story_overlay.dart';
import 'models/comment.dart';

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
  final StateNotifierProviderRef<StoryViewModel, StoryState> ref;
  final StoryRepository storyRepository;
  final UserRepositoryImpl userRepository;

  BetterPlayerController? _betterPlayerController;
  Timer? overlayCloseTimer;

  StoryViewModel({
    required this.ref,
    required this.storyRepository,
    required this.userRepository,
  }) : super(const StoryState());

  BetterPlayerController? get betterPlayerController => _betterPlayerController;

  @override
  void dispose() {
    overlayCloseTimer?.cancel();
    _betterPlayerController?.dispose();
    super.dispose();
  }

  void _init(int storyId) async {
    final result = await storyRepository.getStoryById(storyId);
    result.when(
      success: (value) async {
        state = state.copyWith(story: value);
        _updateUploader(state.story.uploaderId);
        _initVideoController(state.story.storyId);
      },
      error: (message) => {},
    );
  }

  void _initVideoController(int storyId) {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      storyRepository.getStoryVideoPathById(storyId),
      videoFormat: BetterPlayerVideoFormat.hls,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
      ),
      bufferingConfiguration: const BetterPlayerBufferingConfiguration(
        minBufferMs: 2000,
        maxBufferMs: 10000,
        bufferForPlaybackMs: 1000,
        bufferForPlaybackAfterRebufferMs: 2000,
      ),
    );
    double screenAspectRatio =
        WidgetsBinding.instance.window.physicalSize.aspectRatio;
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: true,
        aspectRatio: screenAspectRatio,
        fit: BoxFit.contain,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          playerTheme: BetterPlayerTheme.custom,
          customControlsBuilder: (_, __) => StoryOverlay(
            storyId: state.story.storyId,
          ),
          loadingWidget: const VideoLoading(),
        ),
        errorBuilder: (_, __) => const VideoError(),
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
    _betterPlayerController?.addEventsListener((p) {
      if (p.betterPlayerEventType == BetterPlayerEventType.initialized) {
        state = state.copyWith(isInitialized: true);
      }
    });
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

  void togglePlaying() {
    if (_betterPlayerController == null) return;
    if (state.isInitialized == false) return;
    state.isPlaying
        ? _betterPlayerController!.pause()
        : _betterPlayerController!.play();
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void loadComments() async {
    final Result<Comments> result =
        await storyRepository.getStoryComments(state.story.storyId);
    result.when(
      success: (value) {
        state = state.copyWith(comments: value.comments);
      },
      error: (message) {},
    );
  }

  void addComment(BuildContext context) async {
    final result = await storyRepository.addComment(
        state.story.storyId, state.currentComment);
    result.when(
      success: (value) {
        state = state.copyWith(currentComment: '');
        loadComments();

        Navigator.pop(context);
        showCustomSnackbar(context: context, message: '댓글 작성 성공!');
      },
      error: (message) {},
    );
  }

  void deleteComment(
      {required int commentId, required BuildContext context}) async {
    final result = await storyRepository.deleteComment(
      storyId: state.story.storyId,
      commentId: commentId,
    );
    result.when(
      success: (value) {
        state = state.copyWith(currentComment: '');
        loadComments();

        showCustomSnackbar(context: context, message: '댓글 삭제 성공!');
      },
      error: (message) {},
    );
  }

  void updateCurrentComment(String content) async {
    state = state.copyWith(currentComment: content);
  }

  void likeStory() {
    // TODO implement
    storyRepository.likeStory();
  }

  void toggleOverlayOpen() {
    if (state.overlayOpen) {
      state = state.copyWith(overlayOpen: false);
      overlayCloseTimer?.cancel();
    } else {
      state = state.copyWith(overlayOpen: true);
      if (betterPlayerController?.isPlaying() == true) {
        overlayCloseTimer = Timer(
          const Duration(seconds: 3),
          () {
            state = state.copyWith(overlayOpen: false);
          },
        );
      }
    }
  }

  void openAiFeedback(BuildContext context) {
    betterPlayerController?.pause();
    state = state.copyWith(isPlaying: false);
    context.pushNamed(aiFeedbackRouteName,
        params: {'sid': '${state.story.storyId}'});
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
