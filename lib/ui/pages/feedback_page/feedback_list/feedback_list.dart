import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/story/tags.dart';

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
          scrollDirection: Axis.vertical,
          childrenDelegate: SliverChildListDelegate(
            [
              FeedbackCard(
                story: getRandomStory(),
              ),
              FeedbackCard(
                story: getRandomStory(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotNavigationBar(
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Flexible(child: Text('1') //VideoPlayer(),
            ),
        Card(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('태그 정보', style: theme.textTheme.subtitle1),
                  Row(
                    children: [
                      StoryTagInfo(
                        tags: widget.story.tags,
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                  ),
                  Text('요청 사항', style: theme.textTheme.subtitle1),
                  Text('00:23의 스타트 부분이 너무 어렵습니다.'),
                  Divider(
                    height: 30,
                  ),
                  Text('피드백', style: theme.textTheme.subtitle1),
                  TextField(
                    maxLines: 4,
                    style: theme.textTheme.bodyText2,
                  ),
                  Center(
                    child:
                        ElevatedButton(onPressed: () {}, child: Text('제출하기')),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
