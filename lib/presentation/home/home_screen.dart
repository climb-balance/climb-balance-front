import 'package:climb_balance/presentation/home/components/continuous_statistics.dart';
import 'package:climb_balance/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/components/bot_navigation_bar.dart';
import '../common/components/safe_area.dart';
import 'components/ai_promotion.dart';
import 'components/home_app_bar.dart';
import 'components/recect_stat.dart';
import 'components/recent_ai_info.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final aiStat =
        ref.watch(homeViewModelProvider.select((value) => value.aiStat));
    return Scaffold(
      backgroundColor: color.background,
      appBar: const HomeAppBar(),
      body: MySafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              aiStat == null ? const AiPromotion() : const RecentAiInfo(),
              const SizedBox(
                height: 36,
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
                        const SizedBox(
                          height: 16,
                        ),
                        const RecentStat(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
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
                        const SizedBox(
                          height: 16,
                        ),
                        const ContinuousStatistics(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 0),
    );
  }
}
