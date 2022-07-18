import 'package:climb_balance/configs/routeConfig.dart';
import 'package:climb_balance/providers/mainRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BotNavigationBar extends StatelessWidget {
  final int currentIdx;

  const BotNavigationBar({Key? key, required this.currentIdx})
      : super(key: key);
  static const paths = [
    HOME_PAGE_PATH,
    COMMUNITY_PAGE_PATH,
    '',
    DIARY_PAGE_PATH,
    ACCOUNT_PAGE_PATH
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIdx,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 36,
      onTap: (index) => {_onItemTapped(index, context)},
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
              color: Theme.of(context).errorColor,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'account')
      ],
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, paths[index], (route) => false);
  }
}
