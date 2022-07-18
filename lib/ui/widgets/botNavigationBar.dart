import 'package:climb_balance/providers/mainRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BotNavigationBar extends ConsumerStatefulWidget {
  const BotNavigationBar({Key? key}) : super(key: key);

  @override
  BotNavigationBarState createState() => BotNavigationBarState();
}

class BotNavigationBarState extends ConsumerState {
  static const paths = ['/', '/video/get', '/account'];
  int currentIdx = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIdx,
      onTap: (index) => {_onItemTapped(index, context)},
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_a_photo), label: 'add'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'account')
      ],
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    ref
        .read(mainRouteProvider)
        .currentState
        ?.pushReplacementNamed(paths[index]);
    setState(() {
      currentIdx = index;
    });
  }
}
