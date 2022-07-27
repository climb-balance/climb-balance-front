import 'package:climb_balance/ui/theme/mainTheme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/story.dart';

class StoryPreview extends StatelessWidget {
  final Story story;

  const StoryPreview({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StoryView(
                story: story,
              ),
            ),
          );
        },
        child: Image.network(story.thumbnailPath));
  }
}

class StoryView extends StatefulWidget {
  final Story story;

  const StoryView({Key? key, required this.story}) : super(key: key);

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  late final VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")
      ..initialize().then((_) {
        _videoPlayerController.setLooping(true);
        _videoPlayerController.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainDarkTheme(),
      child: Center(
        child: _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}
