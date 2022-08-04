import 'dart:math';

import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:climb_balance/ui/widgets/story/story.dart';
import 'package:flutter/material.dart';

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
                  width: MediaQuery.of(context).size.width / 2,
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
