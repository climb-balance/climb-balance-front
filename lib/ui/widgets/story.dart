import 'package:climb_balance/ui/theme/mainTheme.dart';
import 'package:climb_balance/ui/widgets/storyOverlay.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/story.dart';

List<String> testVideos = [
  'https://assets.mixkit.co/videos/preview/mixkit-mysterious-pale-looking-fashion-woman-at-winter-39878-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-abstract-video-of-a-man-with-heads-like-matrushka-32647-large.mp4',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/house-painter-promotion-video-template-design-b0d4f2ba5aa5af51d385d0bbf813c908_screen.mp4?ts=1614933517',
];

class StoryPreview extends StatelessWidget {
  final Story story;

  const StoryPreview({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.network(story.thumbnailUrl),
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

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(testVideos[widget.story.videoId])
          ..initialize().then((_) {
            _videoPlayerController.setLooping(true);
            _videoPlayerController.play();
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = ColorScheme.dark();
    final mainWhite = themeColor.onBackground;
    return Theme(
      data: mainDarkTheme().copyWith(
        iconTheme: IconThemeData(
          color: mainWhite,
          shadows: [
            Shadow(color: themeColor.shadow.withOpacity(0.5), blurRadius: 5),
          ],
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              mainWhite,
            ),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                color: mainWhite,
                shadows: [
                  Shadow(
                      color: themeColor.shadow.withOpacity(0.5), blurRadius: 5),
                ],
              ),
            ),
          ),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: mainWhite,
            shadows: [
              Shadow(color: themeColor.shadow.withOpacity(0.5), blurRadius: 5),
            ],
          ),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : const CircularProgressIndicator(),
          ),
          StoryOverlay(
            story: widget.story,
            handleBack: widget.handleBack,
            videoPlayerController: _videoPlayerController,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('드소프즈즞');
    _videoPlayerController.dispose();
    // TODO ON dispose시 다음으로
  }
}
