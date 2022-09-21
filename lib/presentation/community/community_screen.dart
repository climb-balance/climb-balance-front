import 'package:flutter/material.dart';

import '../common/components/bot_navigation_bar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text('구현중입니다.')),
      bottomNavigationBar: BotNavigationBar(currentIdx: 1),
    );
  }
}
