import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/models/user.dart';

import 'package:climb_balance/providers/serverRequest.dart';
import 'package:climb_balance/ui/widgets/botNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/serverConfig.dart';
import '../../widgets/profileInfo.dart';
import '../../widgets/story.dart';

const locations = [
  '클라임 바운스',
  '클라임 바운스 이천',
  '더클라임 양재',
  '더클라임 홍대',
  '더클라임 연남',
  '타잔클라이밍',
  '클라임 바운스 수원',
  '클라임 바운스',
  '클라임 바운스',
  '클라임 바운스',
  '클라임 바운스',
];

enum FilterType { noFilter, aiOnly, expertOnly }

class Diary extends ConsumerStatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  ConsumerState<Diary> createState() => _DiaryState();
}

class _DiaryState extends ConsumerState<Diary> {
  late final UserProfile profile;

  late List<Story> stories;
  late Map<String, List<Story>> treatedStories = {};
  FilterType currentFilter = FilterType.noFilter;

  @override
  void initState() {
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
      List<Story> newStories = [];
      final body = await ref
          .read(serverRequestPrivider)
          .get(ServerUrl + ServerStoryPath);
      for (final data in body['stories']) {
        final story = Story.fromJson(data);
        newStories.add(story);
      }
      stories = newStories;
      updateFilter(FilterType.noFilter);
    });
  }

  void updateFilter(FilterType filter) {
    treatedStories = <String, List<Story>>{};
    for (final story in stories) {
      final String key = story.makeKey();
      if (filter == FilterType.aiOnly && story.aiAvailable != 2) {
        continue;
      } else if (filter == FilterType.expertOnly &&
          story.expertAvailable != 2) {
        continue;
      }
      if (treatedStories.containsKey(key)) {
        treatedStories[key]?.add(story);
      } else {
        treatedStories[key] = [story];
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ProfileInfo(profile: profile),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Builder(
            builder: (context) => CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context)),
                FixedTabBar(
                  updateFilter: updateFilter,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    treatedStories.values
                        .map((stories) => ClassifiedStory(stories: stories))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(
        currentIdx: 3,
      ),
    );
  }
}

class ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  UserProfile profile;

  ProfileHeaderDelegate({required this.profile});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ProfileInfo(profile: profile);
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

class FixedTabBar extends StatefulWidget {
  final void Function(FilterType) updateFilter;

  const FixedTabBar({Key? key, required this.updateFilter}) : super(key: key);

  @override
  State<FixedTabBar> createState() => _FixedTabBarState();
}

class _FixedTabBarState extends State<FixedTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  static const tabItems = [
    Text('ALL'),
    Text('AI'),
    Text('EXPERT'),
  ];
  static const filters = [
    FilterType.noFilter,
    FilterType.aiOnly,
    FilterType.expertOnly,
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: TabBar(
          onTap: (idx) {
            widget.updateFilter(filters[idx]);
          },
          controller: _tabController,
          tabs: tabItems,
          labelPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          labelColor: theme.colorScheme.primary,
        ),
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
        Text(stories[0].getDate()),
        Text(stories[0].tags.location.toString()),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: stories.map((story) => StoryPreview(story: story)).toList(),
        ),
      ],
    );
  }
}
