import 'package:better_player/better_player.dart';
import 'package:climb_balance/presentation/common/components/no_effect_inkwell.dart';
import 'package:climb_balance/presentation/story/story_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/ui/theme/specific_theme.dart';
import 'components/progress_bar.dart';
import 'components/story_comments.dart';

class StoryScreen extends ConsumerWidget {
  final int storyId;

  const StoryScreen({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(storyViewModelProvider(storyId)
            .select((value) => value.story.storyId)) ==
        storyId) {
      return _Story(storyId: storyId);
    }
    return Container();
  }
}

class _Story extends ConsumerStatefulWidget {
  final int storyId;

  const _Story({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  @override
  ConsumerState<_Story> createState() => _StoryState();
}

class _StoryState extends ConsumerState<_Story> with TickerProviderStateMixin {
  bool isStatusChanging = false;

  @override
  Widget build(BuildContext context) {
    final commentOpen = ref.watch(storyViewModelProvider(widget.storyId)
        .select((value) => value.commentOpen));
    final toggleCommentOpen = ref
        .read(storyViewModelProvider(widget.storyId).notifier)
        .toggleCommentOpen;

    final betterPlayerController = ref
        .watch(storyViewModelProvider(widget.storyId).notifier)
        .betterPlayerController;
    final initialized = ref.watch(storyViewModelProvider(widget.storyId)
        .select((value) => value.isInitialized));
    if (betterPlayerController == null || !initialized) return Container();
    return StoryViewTheme(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: NoEffectInkWell(
                    onTap: () {
                      if (commentOpen) {
                        toggleCommentOpen();
                      } else {
                        ref
                            .read(
                                storyViewModelProvider(widget.storyId).notifier)
                            .toggleOverlayOpen();
                      }
                    },
                    child: initialized
                        ? BetterPlayer(
                            controller: betterPlayerController,
                          )
                        : const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                ),
                if (commentOpen)
                  StoryComments(
                    storyId: widget.storyId,
                  )
              ],
            ),
            if (!commentOpen && initialized)
              Align(
                alignment: Alignment.bottomCenter,
                child: ProgressBar(
                  betterPlayerController: betterPlayerController,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
