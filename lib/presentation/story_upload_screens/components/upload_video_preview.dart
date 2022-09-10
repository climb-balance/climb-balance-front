import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../story_upload_view_model.dart';

class UploadVideoPreview extends ConsumerWidget {
  const UploadVideoPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final size = constraints.maxWidth;
        return Container(
          width: size,
          height: size,
          color: theme.colorScheme.secondaryContainer,
          child: VideoViewer(
            trimmer: ref.watch(storyUploadViewModelProvider.notifier).trimmer,
          ),
        );
      },
    );
  }
}
