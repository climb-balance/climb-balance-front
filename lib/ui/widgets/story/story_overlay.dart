import 'package:climb_balance/models/tag.dart';
import 'package:climb_balance/ui/widgets/story/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../models/story.dart';
import '../../../models/user.dart';
import '../../../providers/tags.dart';
import '../user_profile_info.dart';

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
        appBar: StoryOverlayAppBar(
            tags: widget.story.tags, handleBack: widget.handleBack),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomUserProfile(
                    userProfile: genRandomUser(),
                    description: widget.story.description,
                  ),
                  FeedbackOptions(),
                ],
              )
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

class StoryOverlayAppBar extends StatelessWidget with PreferredSizeWidget {
  final Tags tags;
  final void Function() handleBack;

  const StoryOverlayAppBar(
      {Key? key, required this.tags, required this.handleBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: StoryTagInfo(
        tags: tags,
      ),
      titleTextStyle: Theme.of(context).textTheme.bodyText2,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: handleBack,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
  final Tags tags;

  const StoryTagInfo({Key? key, required this.tags}) : super(key: key);

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
              dateString: tags.getDateString(),
            ),
            SuccessTag(success: tags.success),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (tags.location != -1)
              LocationTag(location: refState.locations[tags.location + 1]),
            if (tags.difficulty != -1)
              DifficultyTag(
                  difficulty: refState.difficulties[tags.difficulty + 1]),
          ],
        ),
      ],
    );
  }
}

class FeedbackOptions extends StatefulWidget {
  const FeedbackOptions({Key? key}) : super(key: key);

  @override
  State<FeedbackOptions> createState() => _FeedbackOptionsState();
}

class _FeedbackOptionsState extends State<FeedbackOptions> {
  bool openFeedBack = false;

  void toggleOpenFeedBack() {
    setState(() {
      openFeedBack = !openFeedBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: toggleOpenFeedBack,
          child:
              openFeedBack ? Icon(Icons.arrow_left) : Icon(Icons.arrow_right),
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
    );
  }
}
