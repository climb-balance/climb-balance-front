import 'package:climb_balance/providers/story_upload_provider.dart';
import 'package:climb_balance/ui/pages/story_upload_screens/tag_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_trimmer/video_trimmer.dart';

import 'bottom_step_bar.dart';

class EditVideo extends ConsumerWidget {
  const EditVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trimmer = ref.watch(storyUploadProvider.notifier).loadTrimmer();
    final handleEdit = ref.watch(storyUploadProvider.notifier).handleEditNext;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: VideoViewer(
                trimmer: trimmer,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                children: [
                  TrimEditor(
                    circlePaintColor: Theme.of(context).colorScheme.tertiary,
                    borderPaintColor: Theme.of(context).colorScheme.tertiary,
                    scrubberPaintColor: Theme.of(context).colorScheme.primary,
                    durationTextStyle: Theme.of(context).textTheme.bodyText2!,
                    scrubberWidth: 5,
                    trimmer: trimmer,
                    maxVideoLength: const Duration(minutes: 2),
                    viewerWidth: MediaQuery.of(context).size.width - 20,
                    thumbnailQuality: 15,
                    onChangeEnd: (value) {},
                    onChangeStart: (value) {},
                    onChangePlaybackState: (value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomStepBar(
        handleNext: () {
          handleEdit(context: context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const TagStory(),
            ),
          );
        },
      ),
    );
  }
}
