import 'package:climb_balance/presentation/common/components/my_icons.dart';
import 'package:flutter/material.dart';

import '../common/components/bot_navigation_bar.dart';
import '../common/components/safe_area.dart';
import 'components/ai_feedback_status.dart';
import 'components/expert_feedback_status.dart';
import 'components/home_app_bar.dart';
import 'components/image_banner_preview.dart';
import 'components/main_statistics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const HomeAppBar(),
      body: MySafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ImageBannerPreview(),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '통계',
                    style: theme.textTheme.headline6,
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: theme.colorScheme.primary,
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
                    style: theme.textTheme.headline6,
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: theme.colorScheme.primary,
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GradientIcon(
                  icon: Icons.keyboard_double_arrow_up,
                  size: 50,
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.secondary,
                      theme.colorScheme.tertiary,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 0),
    );
  }
}
