import 'package:climb_balance/ui/widgets/bot_navigation_Bar.dart';
import 'package:flutter/material.dart';

class Community extends StatelessWidget {
  const Community({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text('구현중입니다.')),
      bottomNavigationBar: BotNavigationBar(currentIdx: 1),
    );
  }
}
