import 'package:climb_balance/common/const/route_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../account/account_view_model.dart';
import '../../story_upload_screens/pick_video_screen.dart';

class BotNavigationBar extends ConsumerWidget {
  final int currentIdx;

  const BotNavigationBar({Key? key, required this.currentIdx})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isExpert =
        ref.watch(accountViewModelProvider.select((value) => value.expertMode));
    final List<String> paths = [
      homePageRoute,
      communityPageRoute,
      '',
      isExpert ? feedbackPageRoute : diaryPageRoute,
      accountPageRoute
    ];
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIdx,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 36,
      onTap: (index) => {_onItemTapped(index, context, paths)},
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.people), label: 'community'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            label: ''),
        isExpert
            ? const BottomNavigationBarItem(
                icon: Icon(Icons.feedback), label: 'feedback')
            : const BottomNavigationBarItem(
                icon: Icon(Icons.book), label: 'diary'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'account')
      ],
    );
  }

  void _onItemTapped(int index, BuildContext context, List<String> paths) {
    debugPrint(GoRouter.of(context).location);
    if (index == 2) {
      showModalBottomSheet(
          context: context, builder: (context) => const PickVideoScreen());
    } else {
      GoRouter.of(context).go(paths[index]);
    }
  }
}
