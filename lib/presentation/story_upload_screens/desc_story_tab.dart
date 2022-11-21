import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../presentation/common/components/safe_area.dart';

class DescStoryTab extends ConsumerWidget {
  const DescStoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MySafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(
            height: 10,
          ),
          WriteDescription(),
        ],
      ),
    );
  }
}

class WriteDescription extends ConsumerWidget {
  const WriteDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateDetail =
        ref.read(storyUploadViewModelProvider.notifier).updateDescription;
    return TextField(
      maxLines: 1,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '내용을 적어주세요',
      ),
      onChanged: updateDetail,
    );
  }
}
