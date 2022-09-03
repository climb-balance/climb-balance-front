import 'package:climb_balance/ui/widgets/story/story_comments.dart';
import 'package:climb_balance/ui/widgets/story/story_overlay.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/model/story.dart';
import '../../../services/server_service.dart';
import '../../ui/theme/specific_theme.dart';

class StoryScreen extends StatefulWidget {
  final Story story;
  final void Function() handleBack;

  const StoryScreen({Key? key, required this.story, required this.handleBack})
      : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
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
    // TODO 복구
    // _videoPlayerController = ServerService.tmpStoryVideo(1)
    //   ..initialize().then((_) {
    //     _videoPlayerController.play();
    //     _videoPlayerController.setLooping(true);
    //     setState(() {});
    //   });
    // ServerService.gerStoryVideo(widget.story.storyId).then((result) {
    //   result.when(
    //       error: (String message) {},
    //       success: (value) {
    //         _videoPlayerController = value;
    //         _videoPlayerController.initialize().then((_) {
    //           _videoPlayerController.play();
    //           _videoPlayerController.setLooping(true);
    //           setState(() {});
    //         });
    //       });
    // });
    _videoPlayerController = VideoPlayerController.network(
      ServerService.getStoryVideoPath(widget.story.storyId!),
      formatHint: VideoFormat.hls,
    );
    _videoPlayerController.initialize().then((_) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {});
    });
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

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}
