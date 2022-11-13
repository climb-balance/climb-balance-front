import 'dart:async';

import 'package:climb_balance/domain/common/downloader_provider.dart';
import 'package:climb_balance/presentation/story/story_view_model.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/repository/story_repository_impl.dart';
import '../../domain/model/story.dart';
import '../../domain/repository/story_repository.dart';
import 'models/ai_feedback_state.dart';

final aiFeedbackViewModelProvider = StateNotifierProvider.autoDispose
    .family<AiFeedbackViewModel, AiFeedbackState, int>((ref, storyId) {
  AiFeedbackViewModel notifier = AiFeedbackViewModel(
    ref: ref,
    ref.watch(storyRepositoryImplProvider),
    ref.watch(storyViewModelProvider(storyId).select((value) => value.story)),
  );
  notifier._loadDatas();
  return notifier;
});

class AiFeedbackViewModel extends StateNotifier<AiFeedbackState> {
  final StoryRepository repository;
  final Story story;
  final AutoDisposeStateNotifierProviderRef ref;
  Timer? actionsCloseTimer;
  AnimationController? _animationController;

  AiFeedbackViewModel(this.repository, this.story, {required this.ref})
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

  void initAnimationController(AnimationController? animationController) {
    _animationController = animationController;
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

  void toggleSquareOverlay() {
    state = state.copyWith(squareOverlay: !state.squareOverlay);
  }

  void toggleActionOpen(bool isPlaying) {
    if (state.actionsOpen) {
      state = state.copyWith(actionsOpen: false);
      actionsCloseTimer?.cancel();
    } else {
      state = state.copyWith(actionsOpen: true);
      if (isPlaying) {
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

  void saveAndShare() async {
    final url = repository.getStoryVideoUrl(storyId: story.storyId, isAi: true);
    final documentDirectory = await getTemporaryDirectory();
    final taskId = await ref.read(downloaderProvider.notifier).addDownload(
          url: url,
          dir: '${documentDirectory.path}/tmp.mp4',
        );

    // Share.shareFiles(
    //   [videoFile.path],
    //   mimeTypes: ['video/mp4'],
    // );
  }
}
