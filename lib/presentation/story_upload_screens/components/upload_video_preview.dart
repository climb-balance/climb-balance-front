import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_trimmer/video_trimmer.dart';

class UploadVideoPreview extends ConsumerWidget {
  final Trimmer? trimmer;

  const UploadVideoPreview({
    Key? key,
    required this.trimmer,
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
          child: trimmer == null
              ? Container()
              : VideoViewer(
                  trimmer: trimmer!,
                ),
        );
      },
    );
  }
}
