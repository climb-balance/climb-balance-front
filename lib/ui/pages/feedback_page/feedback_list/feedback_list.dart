import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:flutter/material.dart';

class FeedbackList extends StatelessWidget {
  const FeedbackList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('d'),
      ),
      bottomNavigationBar: BotNavigationBar(
        currentIdx: 3,
      ),
    );
  }
}
