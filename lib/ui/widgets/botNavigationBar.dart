import 'dart:io';

import 'package:climb_balance/configs/routeConfig.dart';
import 'package:climb_balance/providers/upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class PickVideo extends ConsumerStatefulWidget {
  const PickVideo({Key? key}) : super(key: key);

  @override
  ConsumerState<PickVideo> createState() => PickVideoState();
}

class PickVideoState extends ConsumerState<PickVideo> {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickFile({required bool isCam}) async {
    return isCam
        ? await _picker.pickVideo(source: ImageSource.camera)
        : await _picker.pickVideo(source: ImageSource.gallery);
  }

  void handlePick({required bool isCam}) {
    pickFile(isCam: isCam).then((image) {
      if (image == null) {
        return;
      }
      ref.read(uploadProvider.notifier).setFile(file: File(image.path));
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => EditVideo(),
        ),
      );
    });
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
