import 'package:climb_balance/presentation/home/components/continuous_statistics.dart';
import 'package:flutter/material.dart';

import '../common/components/bot_navigation_bar.dart';
import '../common/components/safe_area.dart';
import 'components/home_app_bar.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '최근 AI 평가',
              style: text.bodyText1,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '최근 5주',
                        style: text.bodyText1,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '현재 상태',
                        style: text.bodyText1,
                      ),
                      ContinuousStatistics(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 0),
    );
  }
}
