import 'package:climb_balance/configs/routeConfig.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:climb_balance/ui/pages/home/editVideo.dart';
import 'package:image_picker/image_picker.dart';

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
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIdx,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 36,
      onTap: (index) => {_onItemTapped(index, context)},
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'community'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
              color: Theme.of(context).errorColor,
            ),
            label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'diary'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'account')
      ],
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    if (index == 2) {
      showModalBottomSheet(context: context, builder: (context) => PickVideo());
    } else
      Navigator.pushNamedAndRemoveUntil(
          context, paths[index], (route) => false);
  }
}

class PickVideo extends StatefulWidget {
  const PickVideo({Key? key}) : super(key: key);

  @override
  State<PickVideo> createState() => _PickVideoState();
}

class _PickVideoState extends State<PickVideo> {
  final ImagePicker _picker = ImagePicker();

  void handlePick({required bool isCam}) async {
    final XFile? image = isCam
        ? await _picker.pickVideo(source: ImageSource.camera)
        : await _picker.pickVideo(source: ImageSource.gallery);
    debugPrint(image?.path);
    if (image == null) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EditVideo(
          video: File(image.path),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: 60,
          child: TextButton(
            onPressed: () {
              handlePick(isCam: true);
            },
            child: Text('직접 촬영하기'),
          ),
        ),
        Container(
          height: 60,
          child: TextButton(
            onPressed: () {
              handlePick(isCam: false);
            },
            child: Text('갤러리에서 선택하기'),
          ),
        )
      ],
    );
  }
}
