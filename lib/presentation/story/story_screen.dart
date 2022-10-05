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
  bool isCommentOpen = false;
  bool isStatusChanging = false;

  void toggleCommentOpen() {
    setState(() {
      isCommentOpen = !isCommentOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      ref
          .read(storyViewModelProvider(widget.storyId).notifier)
          .getStoryVideoPath(),
      formatHint: VideoFormat.hls,
    );
    _videoPlayerController.initialize().then((_) {
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
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        isStatusChanging = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoryViewTheme(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isCommentOpen) toggleCommentOpen();
                    },
                    // TODO 가운데만 클릭된다.
                    child: _videoPlayerController.value.isInitialized
                        ? AspectRatio(
                            aspectRatio:
                                _videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController),
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
                if (isCommentOpen)
                  StoryComments(toggleCommentOpen: toggleCommentOpen)
              ],
            ),
            if (!isCommentOpen) ...[
              StoryOverlay(
                storyId: widget.storyId,
                toggleCommentOpen: toggleCommentOpen,
                togglePlaying: togglePlaying,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ProgressBar(
                  videoPlayerController: _videoPlayerController,
                ),
              ),
            ],
            GestureDetector(
              onTap: () {
                togglePlaying();
              },
              child: AnimatedOpacity(
                opacity: isStatusChanging ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: Center(
                  child: _videoPlayerController.value.isPlaying
                      ? Icon(
                          Icons.play_arrow,
                          size: 100,
                        )
                      : Icon(
                          Icons.pause,
                          size: 100,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
