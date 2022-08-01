import 'package:climb_balance/models/tag.dart';
import 'package:climb_balance/models/user.dart';
import 'package:climb_balance/ui/theme/mainTheme.dart';
import 'package:climb_balance/ui/widgets/safearea.dart';
import 'package:climb_balance/ui/widgets/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../models/story.dart';
import '../../providers/tags.dart';

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
    _videoPlayerController =
        VideoPlayerController.network(testVideos[widget.story.videoId])
          ..initialize().then((_) {
            _videoPlayerController.setLooping(true);
            _videoPlayerController.play();
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const ColorScheme.dark();
    return Theme(
      data: mainDarkTheme().copyWith(
        iconTheme: IconThemeData(
          color: themeColor.onBackground,
          shadows: [
            Shadow(color: themeColor.shadow.withOpacity(0.5), blurRadius: 5),
          ],
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: themeColor.onBackground,
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
    _videoPlayerController.dispose();
  }
}

class StoryOverlay extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final Story story;
  final void Function() handleBack;

  const StoryOverlay(
      {Key? key,
      required this.story,
      required this.handleBack,
      required this.videoPlayerController})
      : super(key: key);

  @override
  State<StoryOverlay> createState() => _StoryOverlayState();
}

class _StoryOverlayState extends State<StoryOverlay> {
  bool openFeedBack = false;

  void toggleOpenFeedBack() {
    setState(() {
      openFeedBack = !openFeedBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: IconButton(
          icon:
              Icon(openFeedBack ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onPressed: toggleOpenFeedBack,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.handleBack,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: MySafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 100,
                      child: BottomStoryInfo(
                        story: widget.story,
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: const [
                              Icon(
                                Icons.thumb_up,
                                size: 35,
                              ),
                              Text('200k'),
                            ],
                          ),
                          Column(
                            children: const [
                              Icon(
                                Icons.comment,
                                size: 35,
                              ),
                              Text('200k'),
                            ],
                          ),
                          Column(
                            children: const [
                              Icon(
                                Icons.share,
                                size: 35,
                              ),
                              Text('공유'),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              BottomUserProfile(
                userProfile: genRandomUser(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.story.description),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProgressBar(
        videoPlayerController: widget.videoPlayerController,
      ),
    );
  }
}

class ProgressBar extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const ProgressBar({Key? key, required this.videoPlayerController})
      : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double progressDegree = 0;
  double befDegree = 0;
  int progressDuration = 500;

  void initProgress() {
    progressDuration = 0;
    progressDegree = 0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.videoPlayerController.addListener(() {
      if (progressDuration != 500) {
        progressDuration = 500;
      }
      final value = widget.videoPlayerController.value;
      befDegree = progressDegree;
      progressDegree =
          (value.position.inMilliseconds / value.duration.inMilliseconds);
      if (befDegree > progressDegree) {
        progressDegree = 1;
        progressDuration =
            (value.duration.inMilliseconds * (1.0 - befDegree)).toInt();
        Future.delayed(Duration(milliseconds: progressDuration), initProgress);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        children: [
          AnimatedContainer(
            height: 2,
            width: progressDegree * MediaQuery.of(context).size.width,
            color: const ColorScheme.dark().onSurface,
            duration: Duration(milliseconds: progressDuration),
          ),
        ],
      ),
    );
  }
}

class BottomStoryInfo extends ConsumerWidget {
  final Story story;

  const BottomStoryInfo({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refState = ref.watch(tagsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SuccessTag(success: story.tags.success),
        if (story.tags.difficulty != -1)
          DifficultyTag(
              difficulty: refState.difficulties[story.tags.difficulty + 1]),
        DateTag(
          dateString: story.getDateString(),
        ),
        if (story.tags.location != -1)
          LocationTag(location: refState.locations[story.tags.location + 1]),
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
              '${userProfile.height}cm/${userProfile.weight}kg',
              style: theme.textTheme.bodyText2?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
