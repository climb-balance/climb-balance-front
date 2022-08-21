import 'package:climb_balance/providers/story_upload_provider.dart';
import 'package:climb_balance/ui/pages/story_upload_screens/upload_video_preview.dart';
import 'package:climb_balance/ui/widgets/commons/global_dialog.dart';
import 'package:climb_balance/ui/widgets/commons/safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/result.dart';
import 'bottom_step_bar.dart';

class WriteDesc extends ConsumerStatefulWidget {
  const WriteDesc({Key? key}) : super(key: key);

  @override
  ConsumerState<WriteDesc> createState() => _DetailVideoState();
}

class _DetailVideoState extends ConsumerState<WriteDesc> {
  void handleUpload() async {
    Result<bool> result = await ref.read(storyUploadProvider.notifier).upload();
    result.when(
        success: (value) {
          ref.refresh(storyUploadProvider);
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
        loading: () {},
        error: (message) {
          customShowDialog(context: context, title: '에러', content: message);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const UploadVideoPreview(),
            MySafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  WriteDescription(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomStepBar(
        handleNext: handleUpload,
        next: '업로드',
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
    final updateDetail = ref.read(storyUploadProvider.notifier).updateDetail;
    return TextField(
      maxLines: 4,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '내용을 적어주세요',
      ),
      onChanged: updateDetail,
    );
  }
}
