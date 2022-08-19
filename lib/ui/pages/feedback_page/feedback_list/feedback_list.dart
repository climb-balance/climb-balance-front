import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/serverConfig.dart';
import '../../../../providers/serverRequest.dart';
import '../../../widgets/story/tags.dart';

class FeedbackList extends ConsumerStatefulWidget {
  const FeedbackList({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedbackList> createState() => _FeedbackListState();
}

class _FeedbackListState extends ConsumerState<FeedbackList> {
  late List<Story> stories = [];

  @override
  void initState() {
    loadStories();
    super.initState();
  }

  void loadStories() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      List<Story> newStories = [];
      final body = await ref
          .read(serverRequestPrivider)
          .get(ServerUrl + ServerStoryPath);
      for (final data in body['stories']) {
        final story = Story.fromJson(data);
        newStories.add(story);
      }
      stories = newStories;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children:
                stories.map((story) => FeedbackCard(story: story)).toList(),
          ),
        ),
      ),
      bottomNavigationBar: BotNavigationBar(
        currentIdx: 3,
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final Story story;

  const FeedbackCard({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 700,
      child: Column(
        children: [
          Flexible(
            child: Image.network(story.thumbnailUrl),
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
                          tags: story.tags,
                        ),
                      ],
                    ),
                    Divider(),
                    Text('요청 사항', style: theme.textTheme.subtitle1),
                    Text('00:23의 스타트 부분이 너무 어렵습니다.'),
                    Divider(),
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
      ),
    );
  }
}
