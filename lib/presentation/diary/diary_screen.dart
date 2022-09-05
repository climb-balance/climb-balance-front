import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/components/bot_navigation_bar.dart';
import '../common/scroll_behavior.dart';
import 'components/classified_story.dart';
import 'components/filter_tab_bar.dart';
import 'components/sliver_profile.dart';
import 'diary_view_model.dart';

class DiaryScreen extends ConsumerWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classifiedStories = ref.watch(
        diaryViewModelProvider.select((value) => value.classifiedStories));
    return Scaffold(
      body: SafeArea(
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
      bottomNavigationBar: const BotNavigationBar(
        currentIdx: 3,
      ),
    );
  }
}
