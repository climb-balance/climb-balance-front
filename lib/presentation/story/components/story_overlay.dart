import 'package:climb_balance/presentation/story/components/story_actions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../common/components/user_profile_info.dart';
import '../../common/custom_fab.dart';
import '../story_view_model.dart';
import 'overlay_bottom_gradient.dart';
import 'story_overlay_appbar.dart';

class StoryOverlay extends ConsumerWidget {
  final void Function() toggleCommentOpen;
  final void Function() togglePlaying;
  final VideoPlayerController videoPlayerController;
  final int storyId;

  const StoryOverlay({
    Key? key,
    required this.toggleCommentOpen,
    required this.storyId,
    required this.togglePlaying,
    required this.videoPlayerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final story = ref
        .watch(storyViewModelProvider(storyId).select((value) => value.story));

    return Stack(
      children: [
        const OverlayBottomGradient(),
        GestureDetector(
          onTap: () {
            ref
                .read(storyViewModelProvider(storyId).notifier)
                .toggleOverlayOpen(videoPlayerController.value.isPlaying);
          },
          child: Scaffold(
            floatingActionButton: StoryActions(
              storyId: storyId,
              toggleCommentOpen: toggleCommentOpen,
            ),
            floatingActionButtonAnimator: NoFabScalingAnimation(),
            floatingActionButtonLocation: CustomFabLoc(),
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                StoryOverlayAppBar(
                  tags: story.tags,
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                  ),
                  child: BottomUserProfile(
                    user: ref.watch(storyViewModelProvider(storyId)
                        .select((value) => value.uploader)),
                    description: story.description,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            togglePlaying();
          },
          child: AnimatedOpacity(
            opacity: 0.75,
            duration: const Duration(milliseconds: 250),
            child: Center(
              child: videoPlayerController.value.isPlaying
                  ? const Icon(
                      Icons.pause_circle,
                      size: 75,
                    )
                  : const Icon(
                      Icons.play_circle,
                      size: 75,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
