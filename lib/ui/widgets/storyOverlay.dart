import 'package:climb_balance/ui/widgets/safearea.dart';
import 'package:climb_balance/ui/widgets/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../models/story.dart';
import '../../models/user.dart';
import '../../providers/tags.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        widget.videoPlayerController.value.isPlaying
            ? widget.videoPlayerController.pause()
            : widget.videoPlayerController.play();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: StoryTagInfo(
            story: widget.story,
          ),
          titleTextStyle: Theme.of(context).textTheme.bodyText2,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.handleBack,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.story.description),
                    StoryButtons(),
                  ],
                ),
              ),
              BottomUserProfile(
                userProfile: genRandomUser(),
                description: widget.story.description,
              ),
            ],
          ),
        ),
        bottomNavigationBar: ProgressBar(
          videoPlayerController: widget.videoPlayerController,
        ),
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
      final value = widget.videoPlayerController.value;
      progressDegree =
          (value.position.inMilliseconds / value.duration.inMilliseconds);

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
        mainAxisAlignment: MainAxisAlignment.center,
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

class StoryButtons extends StatelessWidget {
  const StoryButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: Column(
            children: const [
              Icon(
                Icons.thumb_up,
                size: 35,
              ),
              Text('200k')
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Column(
            children: const [
              Icon(
                Icons.comment,
                size: 35,
              ),
              Text('200k'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Column(
            children: const [
              Icon(
                Icons.share,
                size: 35,
              ),
              Text('공유'),
            ],
          ),
        ),
      ],
    );
  }
}

class StoryTagInfo extends ConsumerWidget {
  final Story story;

  const StoryTagInfo({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refState = ref.watch(tagsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DateTag(
              dateString: story.getDateString(),
            ),
            SuccessTag(success: story.tags.success),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (story.tags.location != -1)
              LocationTag(
                  location: refState.locations[story.tags.location + 1]),
            if (story.tags.difficulty != -1)
              DifficultyTag(
                  difficulty: refState.difficulties[story.tags.difficulty + 1]),
          ],
        ),
      ],
    );
  }
}

class BottomUserProfile extends StatefulWidget {
  final UserProfile userProfile;
  final String description;

  const BottomUserProfile(
      {Key? key, required this.userProfile, required this.description})
      : super(key: key);

  @override
  State<BottomUserProfile> createState() => _BottomUserProfileState();
}

class _BottomUserProfileState extends State<BottomUserProfile> {
  bool openFeedBack = false;

  void toggleOpenFeedBack() {
    setState(() {
      openFeedBack = !openFeedBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:
                  Image.network(widget.userProfile.profileImagePath).image,
              radius: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(widget.userProfile.nickName),
                    Text('#${widget.userProfile.uniqueCode.toString()}'),
                  ],
                ),
                Text(
                  '${widget.userProfile.height}cm/${widget.userProfile.weight}kg',
                  style: theme.textTheme.bodyText2?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: toggleOpenFeedBack,
              child: openFeedBack
                  ? Icon(Icons.arrow_left)
                  : Icon(Icons.arrow_right),
            ),
            if (openFeedBack)
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.adb),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.emoji_people),
                    onPressed: () {},
                  ),
                ],
              ),
          ],
        )
      ],
    );
  }
}
