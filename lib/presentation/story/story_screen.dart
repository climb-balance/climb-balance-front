import 'package:climb_balance/presentation/common/components/no_effect_inkwell.dart';
import 'package:climb_balance/presentation/story/story_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../common/ui/theme/specific_theme.dart';
import 'components/progress_bar.dart';
import 'components/story_comments.dart';
import 'components/story_overlay.dart';

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
  late final VideoPlayerController _videoPlayerController;
  bool isStatusChanging = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(
      ref
          .read(storyViewModelProvider(widget.storyId).notifier)
          .getStoryVideoPath(),
      formatHint: VideoFormat.hls,
    )..initialize().then((value) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
  }

  void togglePlaying() {
    if (!_videoPlayerController.value.isInitialized) return;
    setState(() {
      isStatusChanging = true;
    });
    _videoPlayerController.value.isPlaying
        ? _videoPlayerController.pause()
        : _videoPlayerController.play();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isStatusChanging = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final overlayOpen = ref.watch(storyViewModelProvider(widget.storyId)
        .select((value) => value.overlayOpen));

    final commentOpen = ref.watch(storyViewModelProvider(widget.storyId)
        .select((value) => value.commentOpen));
    final toggleCommentOpen = ref
        .read(storyViewModelProvider(widget.storyId).notifier)
        .toggleCommentOpen;
    return StoryViewTheme(
      child: SafeArea(
        child: Stack(
          children: [
            NoEffectInkWell(
              onTap: () {
                if (commentOpen) {
                  toggleCommentOpen();
                } else {
                  ref
                      .read(storyViewModelProvider(widget.storyId).notifier)
                      .toggleOverlayOpen(
                          _videoPlayerController.value.isPlaying);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _videoPlayerController.value.isInitialized
                        ? Center(
                            child: AspectRatio(
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              child: Center(
                                child: VideoPlayer(_videoPlayerController),
                              ),
                            ),
                          )
                        : const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                  if (commentOpen)
                    StoryComments(
                      storyId: widget.storyId,
                    )
                ],
              ),
            ),
            if (overlayOpen) ...[
              StoryOverlay(
                storyId: widget.storyId,
                togglePlaying: togglePlaying,
                videoPlayerController: _videoPlayerController,
              ),
            ],
            Align(
              alignment: Alignment.bottomCenter,
              child: ProgressBar(
                videoPlayerController: _videoPlayerController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
