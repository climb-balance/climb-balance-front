import 'package:climb_balance/presentation/story/components/story_actions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/user_profile_info.dart';
import '../../common/components/videos/playing_status.dart';
import '../../common/custom_fab.dart';
import '../story_view_model.dart';
import 'overlay_bottom_gradient.dart';
import 'story_overlay_appbar.dart';

class StoryOverlay extends ConsumerWidget {
  final int storyId;

  const StoryOverlay({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(
        storyViewModelProvider(storyId).select((value) => value.isPlaying));
    final togglePlaying =
        ref.read(storyViewModelProvider(storyId).notifier).togglePlaying;
    final story = ref
        .watch(storyViewModelProvider(storyId).select((value) => value.story));
    final isInitialized = ref.watch(
        storyViewModelProvider(storyId).select((value) => value.isInitialized));
    final overlayOpen = ref.watch(
        storyViewModelProvider(storyId).select((value) => value.overlayOpen));
    if (!isInitialized || !overlayOpen) return Container();
    return Stack(
      children: [
        const OverlayBottomGradient(),
        GestureDetector(
          onTap: () {
            ref
                .read(storyViewModelProvider(storyId).notifier)
                .toggleOverlayOpen();
          },
          child: Scaffold(
            floatingActionButton: StoryActions(
              storyId: storyId,
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
          child: PlayingStatus(
            isPlaying: isPlaying,
          ),
        ),
      ],
    );
  }
}
