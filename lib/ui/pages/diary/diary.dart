import 'package:climb_balance/models/user.dart';
import 'package:climb_balance/ui/widgets/botNavigationBar.dart';
import 'package:climb_balance/ui/widgets/safearea.dart';
import 'package:flutter/material.dart';

class Diary extends StatefulWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> with TickerProviderStateMixin {
  late final UserProfile profile;
  late TabController _tabController;
  static const tabItems = [
    Text('ALL'),
    Text('AI'),
    Text('EXPERT'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabItems.length, vsync: this);
    loadProfileData();
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

  void loadStories() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('asa'),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              foregroundImage: NetworkImage(profile.profileImagePath),
            ),
            Text(
              '${profile.nickName}#${profile.uniqueCode}',
              style: theme.textTheme.headline5,
            ),
            Container(
              color: theme.colorScheme.primary,
              child: TabBar(
                controller: _tabController,
                tabs: tabItems,
                labelStyle: theme.textTheme.headline6,
              ),
            ),
            MySafeArea(
              child: Container(),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 3),
    );
  }
}
