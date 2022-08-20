import 'package:climb_balance/providers/story_upload_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickVideo extends ConsumerWidget {
  const PickVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handlePick = ref.read(storyUploadProvider.notifier).handlePick;
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              handlePick(isCam: true, context: context);
            },
            child: const Text('직접 촬영하기'),
          ),
        ),
        SizedBox(
          height: 60,
          child: TextButton(
            onPressed: () {
              handlePick(isCam: false, context: context);
            },
            child: const Text('갤러리에서 선택하기'),
          ),
        )
      ],
    );
  }
}
