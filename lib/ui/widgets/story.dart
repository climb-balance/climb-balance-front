import 'package:climb_balance/models/user.dart';
import 'package:climb_balance/ui/theme/mainTheme.dart';
import 'package:climb_balance/ui/widgets/safearea.dart';
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
        child: Image.network(story.thumbnailUrl));
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
  bool openFeedBack = false;

  void toggleOpenFeedBack() {
    setState(() {
      openFeedBack = !openFeedBack;
    });
  }

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")
      ..initialize().then((_) {
        _videoPlayerController.setLooping(true);
        _videoPlayerController.play();
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainDarkTheme(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: IconButton(
                icon: Icon(
                    openFeedBack ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                onPressed: toggleOpenFeedBack,
              ),
              centerTitle: true,
              leading: Container(),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: MySafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  BottomStoryInfo(
                    story: widget.story,
                  ),
                  BottomUserProfile(
                    userProfile: genRandomUser(),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}

class BottomStoryInfo extends StatelessWidget {
  final Story story;

  const BottomStoryInfo({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${story.tags.location}'),
        Text('${story.tags.difficulty}'),
        Text('${story.tags.videoDate}'),
        Text('${story.tags.success}'),
      ],
    );
  }
}

class BottomUserProfile extends StatelessWidget {
  final UserProfile userProfile;

  const BottomUserProfile({Key? key, required this.userProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  Image.network(userProfile.profileImagePath).image,
              radius: 20,
            ),
            Text(userProfile.nickName),
            Text('#${userProfile.uniqueCode.toString()}'),
            const Spacer(),
            Text(
              '${userProfile.height.toString()}/${userProfile.weight.toString()}',
              style: theme.textTheme.bodyText2?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
