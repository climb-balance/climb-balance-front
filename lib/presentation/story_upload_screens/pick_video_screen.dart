import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'edit_video_screen.dart';

class PickVideoScreen extends ConsumerWidget {
  const PickVideoScreen({Key? key}) : super(key: key);

  void handleNext(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const EditVideoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handlePick =
        ref.watch(storyUploadViewModelProvider.notifier).handlePick;
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              handlePick(isCam: true).then((_) {
                handleNext(context);
              });
            },
            child: const Text('직접 촬영하기'),
          ),
        ),
        SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              handlePick(isCam: false).then((_) {
                handleNext(context);
              });
            },
            child: const Text('갤러리에서 선택하기'),
          ),
        )
      ],
    );
  }
}
