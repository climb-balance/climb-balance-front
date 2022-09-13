import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PickVideoScreen extends ConsumerWidget {
  const PickVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickVideo = ref.read(storyUploadViewModelProvider.notifier).pickVideo;
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              pickVideo(isFromCam: true, context: context);
            },
            child: const Text('직접 촬영하기'),
          ),
        ),
        SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              pickVideo(isFromCam: false, context: context);
            },
            child: const Text('갤러리에서 선택하기'),
          ),
        )
      ],
    );
  }
}
