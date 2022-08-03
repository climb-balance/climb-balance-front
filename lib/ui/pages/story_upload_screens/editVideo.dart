import 'dart:io';

import 'package:climb_balance/providers/upload.dart';
import 'package:climb_balance/ui/pages/story_upload_screens/tag_video.dart';
import 'package:climb_balance/ui/widgets/safearea.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/bottomStepBar.dart';

import 'package:video_trimmer/video_trimmer.dart';

class EditVideo extends ConsumerStatefulWidget {
  final File video;

  const EditVideo({Key? key, required this.video}) : super(key: key);

  @override
  VideoPreviewState createState() => VideoPreviewState();
}

class VideoPreviewState extends ConsumerState<EditVideo> {
  Trimmer trimmer = Trimmer();

  @override
  void initState() {
    super.initState();
    // https://github.com/sbis04/video_trimmer/issues/146

    _loadVideo();
  }

  void _loadVideo() {
    trimmer.loadVideo(
      videoFile: widget.video,
    );
  }

  void handleNext() {
    ref
        .read(uploadProvider.notifier)
        .setTrim(startPos: trimmer.videoStartPos, endPos: trimmer.videoEndPos);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => TagVideo(
          trimmer: trimmer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: VideoViewer(
              trimmer: trimmer,
            ),
          ),
          MySafeArea(
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
                  viewerWidth: MediaQuery.of(context).size.width - 80,
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
      bottomNavigationBar: BottomStepBar(
        handleNext: handleNext,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('디스포즈되었ㄷ가.');
    trimmer.dispose();
    ref.refresh(uploadProvider);
    debugPrint('디스포즈되었ㄷ가.');
  }
}
