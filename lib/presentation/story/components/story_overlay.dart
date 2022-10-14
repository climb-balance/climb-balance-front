import 'package:climb_balance/presentation/story/components/story_actions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/user_profile_info.dart';
import '../../common/custom_fab.dart';
import '../story_view_model.dart';
import 'story_overlay_appbar.dart';

class StoryOverlay extends ConsumerWidget {
  final void Function() toggleCommentOpen;
  final void Function() togglePlaying;
  final int storyId;

  const StoryOverlay({
    Key? key,
    required this.toggleCommentOpen,
    required this.storyId,
    required this.togglePlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final story = ref
        .watch(storyViewModelProvider(storyId).select((value) => value.story));

    return GestureDetector(
      onTap: () {
        togglePlaying();
      },
      child: Scaffold(
        floatingActionButton: StoryActions(
          storyId: storyId,
          toggleCommentOpen: toggleCommentOpen,
        ),
        floatingActionButtonAnimator: NoFabScalingAnimation(),
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
