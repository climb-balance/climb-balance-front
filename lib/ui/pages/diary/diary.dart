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
        title: Row(
          children: [const Icon(Icons.arrow_drop_down)],
        ),
        elevation: 1,
      ),
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
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
                          Text('계정 등급 : 1')
                        ],
                      )
                    ],
                  ),
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
            Container(),
          ],
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 3),
    );
  }
}
