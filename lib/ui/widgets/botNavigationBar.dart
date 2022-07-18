import 'package:climb_balance/providers/mainRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BotNavigationBar extends ConsumerWidget {
  final int currentIdx;

  const BotNavigationBar({Key? key, required this.currentIdx})
      : super(key: key);
  static const paths = ['/home', '/home/video/get', '/home/account'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      currentIndex: currentIdx,
      onTap: (index) => {_onItemTapped(index, context, ref)},
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_a_photo), label: 'add'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'account')
      ],
    );
  }

  void _onItemTapped(int index, BuildContext context, WidgetRef ref) {
    ref
        .read(mainRouteProvider)
        .currentState
        ?.pushNamedAndRemoveUntil(paths[index], (route) => false);
  }
}
