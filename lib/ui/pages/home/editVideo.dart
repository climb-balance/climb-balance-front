import 'dart:io';
import 'package:climb_balance/providers/upload.dart';
import 'package:climb_balance/ui/pages/home/tagVideo.dart';
import 'package:climb_balance/ui/widgets/video_trimmer/trimEditor.dart';
import 'package:climb_balance/ui/widgets/video_trimmer/trimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/bottomStepBar.dart';
import '../../widgets/video_trimmer/trimVideoViewer.dart';

class VideoPreview extends ConsumerStatefulWidget {
  const VideoPreview({Key? key}) : super(key: key);

  @override
  VideoPreviewState createState() => VideoPreviewState();
}

class VideoPreviewState extends ConsumerState<VideoPreview> {
  Trimmer trimmer = Trimmer();
  bool trimmerLoaded = false;
  double _start = 0, _end = 0;

  void handleNext() {
    final prov = ref.read(uploadProvider);
    prov.start = _start;
    prov.end = _end;
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
  void initState() {
    super.initState();
    // https://github.com/sbis04/video_trimmer/issues/146
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final video = ref.watch(
        uploadProvider.select((value) => value.file),
      );
      if (video == null) {
        return;
      }
      trimmer.loadVideo(
        videoFile: video,
      );
      setState(() {
        trimmerLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    trimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '영상 자르기',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Container(),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: TrimVideoViewer(
              trimmer: trimmer,
            ),
          ),
          SafeArea(
            minimum: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              children: [
                Visibility(
                  visible: trimmerLoaded,
                  child: TrimEditor(
                    circlePaintColor: Theme.of(context).colorScheme.tertiary,
                    borderPaintColor: Theme.of(context).colorScheme.tertiary,
                    durationTextStyle: Theme.of(context).textTheme.bodyText2!,
                    trimmer: trimmer,
                    maxVideoLength: const Duration(minutes: 2),
                    viewerWidth: MediaQuery.of(context).size.width - 80,
                    thumbnailQuality: 25,
                    onChangeStart: (value) {
                      setState(() {
                        _start = value;
                      });
                    },
                    onChangeEnd: (value) {
                      setState(() {
                        _end = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: BottomStepBar(
        handleNext: handleNext,
      ),
    );
  }
}

class EditVideo extends StatefulWidget {
  const EditVideo({Key? key}) : super(key: key);

  @override
  State<EditVideo> createState() => _EditVideoState();
}

class _EditVideoState extends State<EditVideo> {
  @override
  Widget build(BuildContext context) {
    return VideoPreview();
  }
}
