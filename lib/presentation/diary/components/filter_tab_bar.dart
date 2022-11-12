import 'package:climb_balance/domain/util/stories_filter.dart';
import 'package:climb_balance/presentation/diary/diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterTabBar extends ConsumerWidget {
  const FilterTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final diaryFilters =
        ref.watch(diaryViewModelProvider.select((value) => value.diaryFilters));
    final bool isFilter = diaryFilters.isNotEmpty;
    return SliverAppBar(
      backgroundColor: color.background,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      pinned: true,
      elevation: 0,
      forceElevated: true,
      toolbarHeight: isFilter ? 96 : 48,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 48,
              child: Row(
                children: const [
                  FilterItem(
                      filterTitle: 'ALL', filter: StoriesFilter.noFilter()),
                  FilterItem(filterTitle: 'AI', filter: StoriesFilter.aiOnly()),
                  // FilterItem(
                  //     filterTitle: 'EXPERT', filter: StoriesFilter.expertOnly()),
                ],
              ),
            ),
            if (isFilter)
              Row(
                children: [
                  for (int i = 0; i < diaryFilters.length; i++)
                    FilterTag(idx: i, name: diaryFilters[i].name)
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class FilterTag extends ConsumerWidget {
  final int idx;
  final String name;

  const FilterTag({
    required this.idx,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final deleteFilter = ref.read(diaryViewModelProvider.notifier).deleteFilter;
    return Container(
      decoration: BoxDecoration(
        color: color.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Text(name),
          SizedBox(
            width: 16,
            height: 16,
            child: IconButton(
              splashRadius: 16,
              padding: EdgeInsets.zero,
              onPressed: () {
                deleteFilter(idx);
              },
              icon: const Icon(Icons.close),
              iconSize: 16,
            ),
          ),
        ],
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
    final text = Theme.of(context).textTheme;
    return Flexible(
      fit: FlexFit.tight,
      child: InkWell(
        onTap: () {
          ref.read(diaryViewModelProvider.notifier).addAiFilter(filter);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: currentFilter == filter
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Center(
            child: Text(
              filterTitle,
              style: text.bodyText1?.copyWith(
                color: currentFilter == filter
                    ? theme.colorScheme.onBackground
                    : theme.colorScheme.surfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
