import 'package:climb_balance/presentation/story/components/story_actions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../common/components/user_profile_info.dart';
import '../../common/custom_fab_loc.dart';
import '../story_view_model.dart';
import 'progress_bar.dart';
import 'story_overlay_appbar.dart';

class StoryOverlay extends ConsumerWidget {
  final VideoPlayerController videoPlayerController;
  final void Function() toggleCommentOpen;
  final int storyId;

  const StoryOverlay({
    Key? key,
    required this.videoPlayerController,
    required this.toggleCommentOpen,
    required this.storyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final story = ref
        .watch(storyViewModelProvider(storyId).select((value) => value.story));

    return GestureDetector(
      onTapUp: (_) {
        if (!videoPlayerController.value.isInitialized) return;
        videoPlayerController.value.isPlaying
            ? videoPlayerController.pause()
            : videoPlayerController.play();
      },
      child: Scaffold(
        floatingActionButton: StoryActions(
          storyId: storyId,
          toggleCommentOpen: toggleCommentOpen,
        ),
        floatingActionButtonLocation: CustomFabLoc(),
        backgroundColor: Colors.transparent,
        appBar: StoryOverlayAppBar(
          tags: story.tags,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(story.description),
                  ],
                ),
              ),
              BottomUserProfile(
                user: ref.watch(storyViewModelProvider(storyId)
                    .select((value) => value.uploader)),
                description: story.description,
              ),
            ],
          ),
        ),
        bottomNavigationBar: videoPlayerController.value.isInitialized
            ? ProgressBar(
                videoPlayerController: videoPlayerController,
              )
            : Container(),
      ),
    );
  }
}
