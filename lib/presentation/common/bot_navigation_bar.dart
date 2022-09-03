import 'package:climb_balance/providers/settings.dart';
import 'package:climb_balance/routes/route_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../ui/pages/story_upload_screens/pick_video.dart';

class BotNavigationBar extends ConsumerWidget {
  final int currentIdx;

  const BotNavigationBar({Key? key, required this.currentIdx})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isExpert =
        ref.watch(settingsProvider.select((value) => value.expertMode));
    final List<String> paths = [
      HOME_PAGE_PATH,
      COMMUNITY_PAGE_PATH,
      '',
      isExpert ? FEEDBACK_PAGE_PATH : DIARY_PAGE_PATH,
      ACCOUNT_PAGE_PATH
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
    if (index == 2) {
      showModalBottomSheet(
          context: context, builder: (context) => const PickVideo());
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, paths[index], (route) => false);
    }
  }
}
