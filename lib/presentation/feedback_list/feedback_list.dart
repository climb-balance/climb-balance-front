import 'package:climb_balance/domain/model/story.dart';
import 'package:climb_balance/services/server_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../../presentation/common/components/tags.dart';
import '../common/components/bot_navigation_bar.dart';
import '../common/components/stars.dart';
import '../common/components/waiting_progress.dart';

class FeedbackList extends ConsumerStatefulWidget {
  const FeedbackList({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedbackList> createState() => _FeedbackListState();
}

class _FeedbackListState extends ConsumerState<FeedbackList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.custom(
          scrollDirection: Axis.horizontal,
          childrenDelegate: SliverChildListDelegate(
            [
              FeedbackCard(
                story: genRandomStory(),
              ),
              FeedbackCard(
                story: genRandomStory(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(
        currentIdx: 3,
      ),
    );
  }
}

class FeedbackCard extends StatefulWidget {
  final Story story;

  const FeedbackCard({Key? key, required this.story}) : super(key: key);

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ServerService.tmpStoryVideo(widget.story.storyId);
    _controller.initialize().then((value) {
      _controller.play();
      _controller.setLooping(true);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.width,
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
          FeedbackWrite(
            story: widget.story,
          ),
        ],
      ),
    );
  }
}

class FeedbackWrite extends StatelessWidget {
  final Story story;

  const FeedbackWrite({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('피드백', style: theme.textTheme.subtitle1),
              const StarsPicker(),
              TextField(
                maxLines: 4,
                style: theme.textTheme.bodyText2,
              ),
              const Divider(
                height: 25,
              ),
              Text('태그 정보', style: theme.textTheme.subtitle1),
              Row(
                children: [
                  StoryTagInfo(
                    tags: story.tags,
                  ),
                ],
              ),
              const Divider(
                height: 25,
              ),
              Text('요청 사항', style: theme.textTheme.subtitle1),
              const Text('00:23의 스타트 부분이 너무 어렵습니다.'),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WaitingProgress(),
                        fullscreenDialog: true,
                      ),
                    );
                    await Future.delayed(
                      Duration(milliseconds: 500),
                    );
                    Navigator.popUntil(context, (route) {
                      debugPrint(ModalRoute.of(context)?.settings.name);
                      return false;
                    });
                  },
                  child: const Text('제출하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
