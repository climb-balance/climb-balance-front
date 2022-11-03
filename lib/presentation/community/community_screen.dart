import 'package:climb_balance/presentation/common/components/bot_navigation_bar.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('커뮤니티 기능은 곧 오픈 예정입니다.')),
      bottomNavigationBar: BotNavigationBar(
        currentIdx: 1,
      ),
    );
  }
}
