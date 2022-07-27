import 'dart:convert';

import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/models/user.dart';
import 'package:climb_balance/providers/api.dart';
import 'package:climb_balance/providers/serverRequest.dart';
import 'package:climb_balance/ui/widgets/botNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/serverConfig.dart';
import '../../widgets/profileInfo.dart';
import '../../widgets/story.dart';

class Diary extends ConsumerStatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  ConsumerState<Diary> createState() => _DiaryState();
}

class _DiaryState extends ConsumerState<Diary> with TickerProviderStateMixin {
  late final UserProfile profile;
  late TabController _tabController;
  late Map<String, List<Story>> classifiedStories = {};

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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

  void loadStories() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      classifiedStories = <String, List<Story>>{};
      final body = await ref
          .read(serverRequestPrivider)
          .get(ServerUrl + ServerStoryPath);
      for (final data in body['stories']) {
        final story = Story.fromJson(data);
        final String key = story.makeKey();
        if (classifiedStories.containsKey(key)) {
          classifiedStories[key]!.add(story);
        } else {
          classifiedStories[key] = [story];
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ProfileInfo(profile: profile),
            ...classifiedStories.values
                .map((stories) => ClassifiedStory(stories: stories))
                .toList()
          ],
        ),
      ),
      bottomNavigationBar: BotNavigationBar(
        currentIdx: 3,
      ),
    );
  }
}

class DelegateTabBar extends SliverPersistentHeaderDelegate {
  TabController tabController;
  static const tabItems = [
    Text('ALL'),
    Text('AI'),
    Text('EXPERT'),
  ];

  DelegateTabBar({required this.tabController});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 50,
      child: TabBar(
        labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        controller: tabController,
        tabs: tabItems,
        labelColor: theme.colorScheme.primary,
        labelStyle: theme.textTheme.bodyText2
            ?.copyWith(color: theme.colorScheme.onSurface),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class ClassifiedStory extends StatelessWidget {
  final List<Story> stories;

  const ClassifiedStory({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(stories[0].getDate()),
        Text(stories[0].tags.location.toString()),
        GridView.count(
          children: stories.map((story) => StoryPreview(story: story)).toList(),
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
