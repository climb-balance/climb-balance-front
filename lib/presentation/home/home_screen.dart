import 'package:flutter/material.dart';

import '../common/components/bot_navigation_bar.dart';
import '../common/components/safe_area.dart';
import 'components/ai_feedback_status.dart';
import 'components/expert_feedback_status.dart';
import 'components/home_app_bar.dart';
import 'components/main_statistics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.background,
      appBar: HomeAppBar(),
      body: MySafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '통계',
                    style: text.headline6,
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: color.primary,
                  ),
                ],
              ),
            ),
            const MainStatistics(),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '피드백',
                    style: text.headline6,
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: color.primary,
                  ),
                ],
              ),
            ),
            Row(
              children: const [
                AiFeedbackStatus(),
                ExpertFeedbackStatus(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 0),
    );
  }
}
