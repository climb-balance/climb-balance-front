import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/model/story.dart';
import '../../data/repository/story_repository_impl.dart';
import '../../ui/theme/specific_theme.dart';
import 'components/story_comments.dart';
import 'components/story_overlay.dart';

class StoryScreen extends ConsumerStatefulWidget {
  final Story story;
  final void Function() handleBack;

  const StoryScreen({Key? key, required this.story, required this.handleBack})
      : super(key: key);

  @override
  ConsumerState<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen> {
  late final VideoPlayerController _videoPlayerController;
  bool isCommentOpen = false;

  void toggleCommentOpen() {
    setState(() {
      isCommentOpen = !isCommentOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    final repository = ref.watch(storyRepositoryImplProvider);
    _videoPlayerController = VideoPlayerController.network(
      repository.getStoryVideoPathById(widget.story.storyId!),
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
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = ColorScheme.dark();
    return StoryViewTheme(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      if (isCommentOpen) toggleCommentOpen();
                    },
                    // TODO 가운데만 클릭된다.
                    child: Center(
                      child: _videoPlayerController.value.isInitialized
                          ? AspectRatio(
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            )
                          : const CircularProgressIndicator(),
                    ),
                  ),
                ),
                if (isCommentOpen)
                  StoryComments(toggleCommentOpen: toggleCommentOpen),
              ],
            ),
            if (!isCommentOpen)
              StoryOverlay(
                story: widget.story,
                handleBack: widget.handleBack,
                videoPlayerController: _videoPlayerController,
                toggleCommentOpen: toggleCommentOpen,
              ),
          ],
        ),
      ),
    );
  }
}
