import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/models/user.dart';
import 'package:climb_balance/providers/current_user.dart';
import 'package:climb_balance/providers/serverRequest.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/serverConfig.dart';
import '../../../widgets/user_profile_info.dart';
import 'classified_story.dart';

enum FilterType { noFilter, aiOnly, expertOnly }

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Diary extends ConsumerStatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  ConsumerState<Diary> createState() => _DiaryState();
}

class _DiaryState extends ConsumerState<Diary> {
  late List<Story> stories;
  late Map<String, List<Story>> treatedStories = {};
  FilterType currentFilter = FilterType.noFilter;

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
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          scrollBehavior: NoGlowScrollBehavior(),
          slivers: [
            SliverProfile(),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 10),
              sliver: FixedTabBar(
                updateFilter: updateFilter,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                treatedStories.values
                    .map((stories) => ClassifiedStories(stories: stories))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(
        currentIdx: 3,
      ),
    );
  }
}

class SliverProfile extends ConsumerWidget {
  const SliverProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: const [
              ProfileOptions(),
            ],
          ),
        ),
      ],
      toolbarHeight: 150,
      flexibleSpace: TopProfileInfo(profile: ref.watch(currentUserProvider)),
    );
  }
}

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton<int>(
        icon: Icon(
          Icons.more_vert,
          color: theme.colorScheme.onBackground,
        ),
        itemBuilder: (context) => [
          // popupmenu item 1
          PopupMenuItem(
            value: 1,
            // row has two child icon and text.
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: theme.colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("수정하기")
              ],
            ),
          ),
          // popupmenu item 2
          PopupMenuItem(
            value: 2,
            // row has two child icon and text
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.notifications,
                  color: theme.colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("알림"),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "2",
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 2,
      ),
    );
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
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.cardColor,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      pinned: true,
      elevation: 1,
      forceElevated: true,
      toolbarHeight: 40,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TabBar(
            onTap: (idx) {
              widget.updateFilter(filters[idx]);
            },
            controller: _tabController,
            tabs: tabItems,
            labelPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            labelColor: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
