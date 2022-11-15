import 'package:climb_balance/presentation/common/components/bot_navigation_bar.dart';
import 'package:climb_balance/presentation/community/community_view_model.dart';
import 'package:climb_balance/presentation/story/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/const/route_name.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  late PageController _pageController;
  int currentPage = 0;
  bool showBottomNavigation = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  bool handlePop(BuildContext context) {
    if (currentPage == 0) {
      context.goNamed(homePageRouteName);
      return false;
    }
    _pageController.animateToPage(_pageController.initialPage,
        curve: Curves.elasticOut, duration: const Duration(milliseconds: 500));
    return false;
  }

  void handleBack() {
    if (currentPage == 0) return;
    _pageController.animateToPage(currentPage - 1,
        curve: Curves.elasticOut, duration: const Duration(milliseconds: 500));
  }

  void handleNext() {
    _pageController.animateToPage(currentPage + 1,
        curve: Curves.elasticOut, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storyIds =
        ref.watch(communityViewModelProvider.select((value) => value.storyIds));

    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return Future(() => handlePop(context));
        },
        child: storyIds.isEmpty
            ? Container()
            : PageView.custom(
                pageSnapping: true,
                physics: (currentPage == storyIds.length)
                    ? OnlyUpScrollPhysics()
                    : null,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });

                  if (page % 10 == 9) {
                    ref
                        .read(communityViewModelProvider.notifier)
                        .loadDatas(page: page + 1);
                  }
                },
                controller: _pageController,
                scrollDirection: Axis.vertical,
                childrenDelegate:
                    SliverChildBuilderDelegate((BuildContext context, int idx) {
                  if (idx == storyIds.length) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    );
                  }
                  return StoryScreen(storyId: storyIds[idx].storyId);
                }),
              ),
      ),
      bottomNavigationBar: showBottomNavigation
          ? const BotNavigationBar(
              currentIdx: 1,
            )
          : const SizedBox(
              width: 0,
              height: 0,
            ),
    );
  }
}

class OnlyUpScrollPhysics extends ScrollPhysics {
  OnlyUpScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  bool isDown = false;

  @override
  OnlyUpScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return OnlyUpScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    isDown = offset.sign > 0;
    return offset;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError(
            '$runtimeType.applyBoundaryConditions() was called redundantly.\n'
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.\n'
            'The physics object in question was:\n'
            '  $this\n'
            'The position object in question was:\n'
            '  $position\n');
      }
      return true;
    }());
    if (value < position.pixels && position.pixels <= position.minScrollExtent)
      return value - position.pixels;
    if (position.maxScrollExtent <= position.pixels && position.pixels < value)
      return value - position.pixels;
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels)
      return value - position.minScrollExtent;

    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value)
      return value - position.maxScrollExtent;

    if (!isDown) {
      return value - position.pixels;
    }
    return 0.0;
  }
}
