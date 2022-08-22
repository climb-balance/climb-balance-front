import 'package:climb_balance/ui/widgets/story/story_comments.dart';
import 'package:climb_balance/ui/widgets/story/story_overlay.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../models/story.dart';
import '../../theme/specific_theme.dart';

List<String> testVideos = [
  'http://15.164.163.153:3000/story/1/video?type=raw',
  'http://15.164.163.153:3000/story/1/video?type=ai',
  'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-abstract-video-of-a-man-with-heads-like-matrushka-32647-large.mp4',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/house-painter-promotion-video-template-design-b0d4f2ba5aa5af51d385d0bbf813c908_screen.mp4?ts=1614933517',
];

class StoryPreview extends StatelessWidget {
  final Story story;

  const StoryPreview({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.surfaceVariant,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StoryView(
                story: story,
                handleBack: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(story.thumbnailUrl),
            ),
          ),
        ),
      ),
    );
  }
}

class StoryView extends StatefulWidget {
  final Story story;
  final void Function() handleBack;

  const StoryView({Key? key, required this.story, required this.handleBack})
      : super(key: key);

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
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
    _videoPlayerController =
        VideoPlayerController.network(testVideos[widget.story.storyId])
          ..initialize().then((_) {
            _videoPlayerController.setLooping(true);
            _videoPlayerController.play();
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
