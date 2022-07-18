import 'package:flutter/material.dart';

class BotNavigationBar extends StatefulWidget {
  final GlobalKey<NavigatorState> navKey;

  const BotNavigationBar({Key? key, required this.navKey}) : super(key: key);

  @override
  State<BotNavigationBar> createState() => _BotNavigationBarState();
}

class _BotNavigationBarState extends State<BotNavigationBar> {
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
    widget.navKey.currentState?.pushReplacementNamed(paths[index]);
    setState(() {
      currentIdx = index;
    });
  }
}
