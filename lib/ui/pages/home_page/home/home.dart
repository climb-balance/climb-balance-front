import 'dart:math';

import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:climb_balance/ui/widgets/story/story.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/ai_feedback_status.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [Icon(Icons.balance), Text('클라임밸런스')],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Card(child: ImageBanner()),
            MainStatistics(),
            // TODO stack으로 옮겨야함.
            FeedbackStatus(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Icon(
                  Icons.keyboard_double_arrow_up,
                  size: 50,
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

class FeedbackStatus extends ConsumerWidget {
  const FeedbackStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final aiStatus = ref.watch(aiFeedbackStatusProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              'AI 피드백 진행상황',
              style: theme.textTheme.headline6,
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 80,
              child: aiStatus.waiting
                  ? PieChart(
                      PieChartData(
                        centerSpaceRadius: 10,
                        sections: [
                          PieChartSectionData(
                            title: '',
                            color: theme.colorScheme.primary,
                            value: 25,
                            radius: 25,
                          ),
                        ],
                      ),
                      swapAnimationDuration: Duration(milliseconds: 150),
                      swapAnimationCurve: Curves.linear,
                    )
                  : const NoFeedbackInform(),
            ),
          ],
        ),
      ),
    );
  }
}

class NoFeedbackInform extends StatelessWidget {
  const NoFeedbackInform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('요청한 피드백이 완료되었거나 없습니다.'),
      ],
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
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 5,
                  child: HeatMap(
                    datas: snapshot.data!,
                  ),
                ),
                ContinuousStatistics(
                  datas: snapshot.data!,
                ),
              ],
            );
          }
          return Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: HeatMap(
                  datas: List<int>.filled(30, 0),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
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
