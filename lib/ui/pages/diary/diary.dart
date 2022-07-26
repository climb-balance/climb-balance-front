import 'dart:math';

import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/models/user.dart';
import 'package:climb_balance/ui/widgets/botNavigationBar.dart';
import 'package:climb_balance/ui/widgets/safearea.dart';
import 'package:flutter/material.dart';

import '../../../models/tag.dart';

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> with TickerProviderStateMixin {
  late final UserProfile profile;
  late TabController _tabController;
  late Map<String, List<Story>> classifiedStories;
  static const tabItems = [
    Text('ALL'),
    Text('AI'),
    Text('EXPERT'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabItems.length, vsync: this);
    loadProfileData();
    loadStories();
    super.initState();
  }

  void loadProfileData() {
    setState(() {
      profile = UserProfile(
        nickName: '심규진',
        profileImagePath:
            'https://images.pexels.com/photos/12616283/pexels-photo-12616283.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        uniqueCode: 2131,
      );
    });
  }

  Story getRandomStory() {
    Random random = Random();
    return Story(
        tag: Tag(date: DateTime.now()),
        likes: random.nextInt(100),
        description: '안녕하세요',
        comments: random.nextInt(100),
        aiAvailable: random.nextInt(1) == 1,
        expertAvailable: random.nextInt(1) == 1,
        uploadDate: DateTime.now(),
        thumbnailPath: 'https://i.imgur.com/IAhL4iA.jpeg');
  }

  String formatDate(DateTime date) {
    return '${date.year.toString()}-${date.month.toString()}-${date.day.toString()}';
  }

  void loadStories() {
    List<Story> stories = [];
    for (int i = 0; i < 100; i++) {
      stories.add(getRandomStory());
    }
    Map<String, List<Story>> classifiedStories = {};
    for (Story story in stories) {
      String key = '${story.tag.location}/${formatDate(story.tag.date)}';
      if (classifiedStories.containsKey(key)) {
        classifiedStories[key]?.add(story);
      } else {
        classifiedStories[key] = [story];
      }
    }
    setState(() {
      this.classifiedStories = classifiedStories;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [const Icon(Icons.arrow_drop_down)],
        ),
        elevation: 1,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            Center(
              child: Column(
                children: [
                  ProfileInfo(
                    profile: profile,
                  ),
                  TabBar(
                    labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    controller: _tabController,
                    tabs: tabItems,
                    labelColor: theme.colorScheme.primary,
                    labelStyle: theme.textTheme.bodyText2
                        ?.copyWith(color: theme.colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: classifiedStories.values
                  .map((stories) => ClassifiedStory(stories: stories))
                  .toList(),
            ),
            Column(
              children: classifiedStories.values
                  .map((stories) => ClassifiedStory(stories: stories))
                  .toList(),
            ),
            Column(
              children: classifiedStories.values
                  .map((stories) => ClassifiedStory(stories: stories))
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 3),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final UserProfile profile;

  const ProfileInfo({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            foregroundImage: NetworkImage(profile.profileImagePath),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${profile.nickName}#${profile.uniqueCode}',
                style: theme.textTheme.headline6,
              ),
              const Text('계정 등급 : 1')
            ],
          )
        ],
      ),
    );
  }
}

class ClassifiedStory extends StatelessWidget {
  final List<Story> stories;

  const ClassifiedStory({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(stories[0].tag.date.toString()),
        Text(stories[0].tag.location),
        GridView.count(
          crossAxisCount: 3,
          children: stories.map((story) => StoryPreview(story: story)).toList(),
        ),
      ],
    );
  }
}

class StoryPreview extends StatelessWidget {
  final Story story;

  const StoryPreview({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Image.network(story.thumbnailPath),
    );
  }
}
