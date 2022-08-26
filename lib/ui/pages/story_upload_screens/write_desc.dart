import 'package:climb_balance/providers/story_upload_provider.dart';
import 'package:climb_balance/ui/pages/story_upload_screens/upload_video_preview.dart';
import 'package:climb_balance/ui/widgets/commons/global_dialog.dart';
import 'package:climb_balance/ui/widgets/commons/safe_area.dart';
import 'package:climb_balance/ui/widgets/commons/waiting_progress.dart';
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
  bool isWaiting = false;

  void handleUpload() async {
    isWaiting = true;
    setState(() {});
    Result<bool> result = await ref.read(storyUploadProvider.notifier).upload();
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
        ref.read(storyUploadProvider.notifier).updateDescription;
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
