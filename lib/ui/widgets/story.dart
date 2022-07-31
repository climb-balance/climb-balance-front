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
          StoryOverlay(story: widget.story, handleBack: widget.handleBack),
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

class StoryOverlay extends StatefulWidget {
  final Story story;
  final void Function() handleBack;

  const StoryOverlay({Key? key, required this.story, required this.handleBack})
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
    );
  }
}

class BottomStoryInfo extends ConsumerWidget {
  final Story story;

  const BottomStoryInfo({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refState = ref.watch(tagsProvider);
    debugPrint(refState.difficulties.toString());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocationTag(location: refState.locations[story.tags.difficulty + 1]),
        DifficultyTag(
            difficulty: refState.difficulties[story.tags.location + 1]),
        Text('${story.getDateString()}'),
        SuccessTag(success: story.tags.success),
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
