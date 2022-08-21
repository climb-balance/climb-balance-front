import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../../providers/story_upload_provider.dart';

class UploadVideoPreview extends ConsumerWidget {
  const UploadVideoPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.secondaryContainer,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: VideoViewer(
        trimmer: ref.watch(storyUploadProvider.notifier).trimmer,
      ),
    );
  }
}
