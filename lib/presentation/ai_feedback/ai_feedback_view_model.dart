import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:climb_balance/presentation/story/story_view_model.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/story_repository_impl.dart';
import '../../domain/model/story.dart';
import '../../domain/repository/story_repository.dart';
import '../../domain/util/platform_check.dart';
import '../common/components/videos/video_error.dart';
import '../common/components/videos/video_loading.dart';
import '../common/custom_dialog.dart';
import 'models/ai_feedback_state.dart';

final aiFeedbackViewModelProvider = StateNotifierProvider.autoDispose
    .family<AiFeedbackViewModel, AiFeedbackState, int>((ref, storyId) {
  AiFeedbackViewModel notifier = AiFeedbackViewModel(
    ref: ref,
    ref.read(storyRepositoryImplProvider),
    ref.watch(storyViewModelProvider(storyId).select((value) => value.story)),
  );
  notifier._init();
  return notifier;
});

class AiFeedbackViewModel extends StateNotifier<AiFeedbackState> {
  final StoryRepository repository;
  final Story story;
  final AutoDisposeStateNotifierProviderRef ref;
  Timer? actionsCloseTimer;
  AnimationController? _animationController;
  BetterPlayerController? _betterPlayerController;

  AiFeedbackViewModel(this.repository, this.story, {required this.ref})
      : super(const AiFeedbackState());

  BetterPlayerController? get betterPlayerController => _betterPlayerController;

  @override
  void dispose() {
    _betterPlayerController?.dispose();
    actionsCloseTimer?.cancel();
    super.dispose();
  }

  void _init() async {
    final result = await repository.getStoryAiDetailById(story.storyId);
    result.when(
      success: (value) {
        state = value;
        _initVideoController();
      },
      error: (message) {},
    );
  }

  void _initVideoController() {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      getStoryAiVideoPath(),
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
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          playerTheme: BetterPlayerTheme.custom,
          loadingWidget: VideoLoading(),
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

  void initAnimationController(AnimationController? animationController) {
    _animationController = animationController;
  }

  void togglePlaying() {
    if (_betterPlayerController == null || !state.isInitialized) return;
    state.isPlaying
        ? _betterPlayerController!.pause()
        : _betterPlayerController!.play();
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void seekAnimation(Duration seekTime) {
    if (_animationController == null) return;
    bool isAnimating = _animationController!.isAnimating;
    _animationController!.forward(
        from: seekTime.inMilliseconds /
            _animationController!.duration!.inMilliseconds);
    if (!isAnimating) _animationController!.stop();
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

  void toggleScoreOverlay() {
    state = state.copyWith(scoreOverlay: !state.scoreOverlay);
  }

  void toggleSquareOverlay() {
    state = state.copyWith(squareOverlay: !state.squareOverlay);
  }

  void toggleActionOpen() {
    if (state.actionsOpen) {
      state = state.copyWith(actionsOpen: false);
      actionsCloseTimer?.cancel();
    } else {
      state = state.copyWith(actionsOpen: true);
      if (state.isPlaying) {
        actionsCloseTimer = Timer(
          Duration(seconds: 3),
          () {
            state = state.copyWith(actionsOpen: false);
          },
        );
      }
    }
  }

  void cancelOverlayCloseTimer() {
    actionsCloseTimer?.cancel();
  }

  void togglePlayingStatus() {
    state = state.copyWith(isStatusChanging: true);
    Future.delayed(const Duration(milliseconds: 300), () {
      state = state.copyWith(isStatusChanging: false);
    });
  }

  void saveAndShare(BuildContext context) async {
    if (isMobile()) {
      final String? path =
          await repository.getStoryVideo(storyId: story.storyId, isAi: true);
    } else {
      customShowDialog(
        context: context,
        title: '웹에서는 공유가 지원되지 않습니다.',
        content: '모바일을 이용해주세요',
      );
    }
  }
}
