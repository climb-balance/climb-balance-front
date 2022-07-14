import 'package:flutter/material.dart';

class BotNavigationBar extends StatelessWidget {
  final int currentIdx;
  static const paths = ['/', '/upload', '/account'];

  const BotNavigationBar({Key? key, this.currentIdx = 0}) : super(key: key);

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
    Navigator.pushReplacementNamed(context, paths[index]);
  }
}
