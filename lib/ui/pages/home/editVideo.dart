import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  final File video;

  const VideoPreview({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  Duration _startValue = Duration.zero;
  late Duration _endValue;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video);
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.addListener(handle_loopback);
    _controller.setLooping(true);
    _controller.play();
  }

  void handle_loopback() {
    debugPrint('============');
    debugPrint(_controller.value.position.toString());
    debugPrint(_startValue.toString());
    debugPrint(_endValue.toString());
    if (_controller.value.position >= _endValue) {
      _controller.seekTo(_startValue);
    }
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('dddd')),
      body: Column(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _endValue = _controller.value.duration;
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: VideoPlayer(_controller),
                  ),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SafeArea(
            minimum: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      if (_startValue < _endValue - Duration(seconds: 1))
                        setState(() {
                          _startValue =
                              _startValue + Duration(milliseconds: 250);
                        });
                    },
                    icon: Icon(Icons.arrow_right_rounded)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _endValue = _endValue - Duration(milliseconds: 250);
                      });
                    },
                    icon: Icon(Icons.arrow_left_rounded))
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
