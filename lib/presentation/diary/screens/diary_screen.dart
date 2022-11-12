import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/bot_navigation_bar.dart';
import '../../common/components/safe_area.dart';
import '../../common/scroll_behavior.dart';
import '../components/classified_story.dart';
import '../components/filter_tab_bar.dart';
import '../components/sliver_profile.dart';
import '../diary_view_model.dart';

class DiaryScreen extends ConsumerWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  Future<void> _pullRefresh(Future<void> Function() reload) async {
    await reload();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classifiedStories = ref.watch(
        diaryViewModelProvider.select((value) => value.classifiedStories));
    final reload = ref.read(diaryViewModelProvider.notifier).loadStories;
    return Scaffold(
      body: MySafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _pullRefresh(reload);
          },
          child: CustomScrollView(
            scrollBehavior: NoGlowScrollBehavior(),
            slivers: [
              const SliverProfile(),
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 10),
                sliver: FilterTabBar(),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  classifiedStories
                      .map((stories) => ClassifiedStories(stories: stories))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(
        currentIdx: 3,
      ),
    );
  }
}
