import 'dart:async';

import 'package:climb_balance/presentation/story/story_view_model.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/story_repository_impl.dart';
import '../../domain/model/story.dart';
import '../../domain/repository/story_repository.dart';
import 'models/ai_feedback_state.dart';

final aiFeedbackViewModelProvider = StateNotifierProvider.autoDispose
    .family<AiFeedbackViewModel, AiFeedbackState, int>((ref, storyId) {
  AiFeedbackViewModel notifier = AiFeedbackViewModel(
    ref: ref,
    ref.read(storyRepositoryImplProvider),
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

  @override
  void dispose() {
    actionsCloseTimer?.cancel();
    super.dispose();
  }

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

  void toggleScoreOverlay() {
    state = state.copyWith(scoreOverlay: !state.scoreOverlay);
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
    final String? path = await repository.getStoryVideo(
      storyId: story.storyId,
      isAi: true,
    );
  }
}
