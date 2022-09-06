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
        background: Row(),
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
    return OutlinedButton(
      onPressed: () {
        ref.read(diaryViewModelProvider.notifier).filterStories(filter);
      },
      child: Text(filterTitle),
    );
  }
}
