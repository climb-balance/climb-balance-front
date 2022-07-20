import 'dart:io';
import 'package:climb_balance/ui/widgets/video_trimmer/trimEditor.dart';
import 'package:climb_balance/ui/widgets/video_trimmer/trimmer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/video_trimmer/videoViewer.dart';

class VideoPreview extends StatefulWidget {
  final File video;

  const VideoPreview({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  Trimmer trimmer = Trimmer();
  bool trimmerLoaded = false;

  @override
  void initState() {
    super.initState();
    // https://github.com/sbis04/video_trimmer/issues/146
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trimmer.loadVideo(videoFile: widget.video);
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
      appBar: AppBar(title: Text('dddd')),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: VideoViewer(
              trimmer: trimmer,
            ),
          ),
          SafeArea(
            minimum: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              children: [
                Visibility(
                  child: TrimEditor(
                    trimmer: trimmer,
                    maxVideoLength: const Duration(minutes: 2),
                    viewerWidth: MediaQuery.of(context).size.width - 80,
                    thumbnailQuality: 25,
                  ),
                  visible: trimmerLoaded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditVideo extends StatefulWidget {
  final File video;

  const EditVideo({Key? key, required this.video}) : super(key: key);

  @override
  State<EditVideo> createState() => _EditVideoState();
}

class _EditVideoState extends State<EditVideo> {
  @override
  Widget build(BuildContext context) {
    return VideoPreview(
      video: widget.video,
    );
  }
}
