import 'dart:math';

import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:climb_balance/ui/widgets/commons/my_icons.dart';
import 'package:climb_balance/ui/widgets/commons/safe_area.dart';
import 'package:climb_balance/ui/widgets/story/story.dart';
import 'package:climb_balance/utils/durations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../providers/feedback_status.dart';
import 'continuous_statistics.dart';
import 'heat_map.dart';
import 'image_banner.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int currentPage = 0;
  List<Widget> pageItems = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    pageItems.add(StoryView(
      story: getRandomStory(),
      handleBack: handleBack,
    ));
  }

  Widget handlePage(BuildContext context, int idx) {
    if (idx == 0) {
      return const MainPage();
    }

    if (pageItems.length < idx) {
      pageItems.add(StoryView(
        story: getRandomStory(),
        handleBack: handleBack,
      ));
    }
    return pageItems[idx - 1];
  }

  bool handlePop() {
    if (currentPage == 0) {
      return true;
    }
    _pageController.animateToPage(_pageController.initialPage,
        curve: Curves.elasticOut, duration: const Duration(milliseconds: 500));
    return false;
  }

  void handleBack() {
    _pageController.animateToPage(_pageController.initialPage,
        curve: Curves.elasticOut, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => handlePop());
      },
      child: PageView.custom(
        onPageChanged: (page) {
          debugPrint("이미 넘어갔다.");
          currentPage = page;
        },
        controller: _pageController,
        scrollDirection: Axis.vertical,
        childrenDelegate: SliverChildBuilderDelegate(handlePage),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: HomeAppBar(),
      body: MySafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ImageBanner(),
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
                Flexible(
                  child: AiFeedbackStatus(),
                  fit: FlexFit.tight,
                ),
                Flexible(
                  child: ExpertFeedbackStatus(),
                  fit: FlexFit.tight,
                ),
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

class ExpertFeedbackStatus extends ConsumerWidget {
  const ExpertFeedbackStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final finishedExpertFeedback = ref.watch(
        feedbackStatusProvider.select((value) => value.finishedExpertFeedback));
    final waitingExpertFeedback = ref.watch(
        feedbackStatusProvider.select((value) => value.waitingExpertFeedback));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              '전문가',
              style: theme.textTheme.subtitle2,
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${waitingExpertFeedback}/${finishedExpertFeedback}',
                    style: theme.textTheme.subtitle1,
                  ),
                  Text(
                    '대기/완료',
                    style: theme.textTheme.subtitle2,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AiFeedbackStatus extends ConsumerWidget {
  const AiFeedbackStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final aiStatus = ref.watch(feedbackStatusProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              '인공지능',
              style: theme.textTheme.subtitle2,
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 110,
              child: aiStatus.aiIsWaiting
                  ? const AiFeedbackStatusInform()
                  : const NoFeedbackInform(),
            ),
          ],
        ),
      ),
    );
  }
}

class AiFeedbackStatusInform extends ConsumerWidget {
  const AiFeedbackStatusInform({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final aiStatus = ref.watch(feedbackStatusProvider);
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 10,
                startDegreeOffset: 270,
                sectionsSpace: 0,
                sections: [
                  PieChartSectionData(
                    showTitle: false,
                    color: theme.colorScheme.primary,
                    value: aiStatus.aiWaitingTime.inSeconds.toDouble() -
                        aiStatus.aiLeftTime.inSeconds,
                    radius: 30,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    color: theme.colorScheme.secondary,
                    value: aiStatus.aiLeftTime.inSeconds.toDouble(),
                    radius: 30,
                  ),
                ],
              ),
              swapAnimationDuration: const Duration(milliseconds: 850),
              swapAnimationCurve: Curves.linear,
            ),
          ),
        ),
        Text(formatDuration(aiStatus.aiLeftTime),
            style: theme.textTheme.subtitle1),
      ],
    );
  }
}

class NoFeedbackInform extends StatelessWidget {
  const NoFeedbackInform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '요청한 피드백이 완료되었거나 없습니다.',
      overflow: TextOverflow.fade,
    );
  }
}

class MainStatistics extends StatelessWidget {
  const MainStatistics({Key? key}) : super(key: key);

  Future<List<int>> loadDatas() async {
    Random random = Random();
    List<int> result = [];
    for (int i = 0; i < 30; i++) {
      result.add(random.nextInt(10));
    }
    return Future.delayed(const Duration(seconds: 1), () {
      return result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 2 - 30,
      child: FutureBuilder(
        future: loadDatas(),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Row(
              children: [
                Flexible(
                  child: HeatMap(
                    datas: snapshot.data!,
                  ),
                ),
                Flexible(
                  child: ContinuousStatistics(
                    datas: snapshot.data!,
                  ),
                ),
              ],
            );
          }
          return Row(
            children: [
              Flexible(
                child: HeatMap(
                  datas: List<int>.filled(30, 0),
                ),
              ),
              Flexible(
                child: HeatMap(
                  datas: List<int>.filled(30, 0),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 5,
          ),
          Container(
            height: 25,
            width: 25,
            child: SvgPicture.asset(
              'assets/logo.svg',
              color: theme.colorScheme.primary,
            ),
          ),
          Text(
            '클라임밸런스',
            style: TextStyle(
              color: theme.colorScheme.onBackground,
            ),
          ),
        ],
      ),
      actions: [
        Icon(
          Icons.notifications,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
