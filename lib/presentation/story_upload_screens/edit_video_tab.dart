import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_trimmer/video_trimmer.dart';

class EditVideoTab extends ConsumerWidget {
  final Trimmer? trimmer;

  const EditVideoTab({
    Key? key,
    required this.trimmer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateVideoTrim =
        ref.read(storyUploadViewModelProvider.notifier).updateVideoTrim;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        children: [
          if (trimmer != null)
            TrimEditor(
              circlePaintColor: Theme.of(context).colorScheme.tertiary,
              borderPaintColor: Theme.of(context).colorScheme.tertiary,
              scrubberPaintColor: Theme.of(context).colorScheme.primary,
              durationTextStyle: Theme.of(context).textTheme.bodyText2!,
              scrubberWidth: 5,
              trimmer: trimmer!,
              maxVideoLength: const Duration(minutes: 2),
              viewerWidth: MediaQuery.of(context).size.width - 20,
              thumbnailQuality: 15,
              onChangeEnd: (value) {
                updateVideoTrim(context, trimmer!);
              },
              onChangeStart: (value) {
                updateVideoTrim(context, trimmer!);
              },
              onChangePlaybackState: (value) {},
            ),
        ],
      ),
    );
  }
}
