import 'package:climb_balance/domain/util/stories_filter.dart';
import 'package:climb_balance/presentation/diary/diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterTabBar extends StatelessWidget {
  const FilterTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.cardColor,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      pinned: true,
      elevation: 1,
      forceElevated: true,
      toolbarHeight: 40,
      flexibleSpace: FlexibleSpaceBar(
        background: Row(
          children: const [
            FilterItem(filterTitle: '전체', filter: StoriesFilter.noFilter()),
            FilterItem(filterTitle: 'AI', filter: StoriesFilter.aiOnly()),
            FilterItem(filterTitle: '전문가', filter: StoriesFilter.expertOnly()),
          ],
        ),
      ),
    );
  }
}

class FilterItem extends ConsumerWidget {
  final String filterTitle;
  final StoriesFilter filter;

  const FilterItem({
    required this.filterTitle,
    required this.filter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter =
        ref.watch(diaryViewModelProvider.select((value) => value.storyFilter));
    final theme = Theme.of(context);
    return Flexible(
      fit: FlexFit.tight,
      child: InkWell(
        onTap: () {
          ref.read(diaryViewModelProvider.notifier).filterStories(filter);
        },
        child: Center(
          child: Text(
            filterTitle,
            style: TextStyle(
              color: currentFilter == filter
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
