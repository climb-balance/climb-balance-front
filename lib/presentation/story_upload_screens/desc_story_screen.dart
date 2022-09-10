import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/models/result.dart';
import '../../../presentation/common/components/safe_area.dart';
import '../../../presentation/common/components/waiting_progress.dart';
import '../../../presentation/common/custom_dialog.dart';
import 'components/bottom_step_bar.dart';
import 'components/upload_video_preview.dart';

class DescStoryScreen extends ConsumerStatefulWidget {
  const DescStoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DescStoryScreen> createState() => _DescStoryScreenState();
}

class _DescStoryScreenState extends ConsumerState<DescStoryScreen> {
  bool isWaiting = false;

  void handleUpload() async {
    isWaiting = true;
    setState(() {});
    Result<void> result =
        await ref.read(storyUploadViewModelProvider.notifier).upload();
    result.when(
      success: (value) {
        // TODO : fix route
        Navigator.popUntil(context, ModalRoute.withName("/"));
      },
      error: (message) {
        customShowDialog(context: context, title: '에러', content: message);
        isWaiting = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const UploadVideoPreview(),
                  MySafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                        WriteDescription(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomStepBar(
            handleNext: handleUpload,
            next: '업로드',
          ),
        ),
        if (isWaiting) WaitingProgress(),
      ],
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
      maxLines: 4,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '내용을 적어주세요',
      ),
      onChanged: updateDetail,
    );
  }
}
