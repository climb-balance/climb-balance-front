import 'package:climb_balance/providers/current_user.dart';
import 'package:climb_balance/providers/diary_provider.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/user_profile_info.dart';
import 'classified_story.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Diary extends ConsumerWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final classifiedStories = ref.watch(diaryProvider);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          scrollBehavior: NoGlowScrollBehavior(),
          slivers: [
            const SliverProfile(),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 10),
              sliver: FixedTabBar(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                classifiedStories
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

class FixedTabBar extends ConsumerStatefulWidget {
  const FixedTabBar({Key? key}) : super(key: key);

  @override
  ConsumerState<FixedTabBar> createState() => _FixedTabBarState();
}

class _FixedTabBarState extends ConsumerState<FixedTabBar>
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
              ref.read(diaryProvider.notifier).filterStories(filters[idx]);
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
