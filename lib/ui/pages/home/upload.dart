import 'dart:io';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class VideoPopup extends StatefulWidget {
  XFile file;

  VideoPopup({Key? key, required this.file}) : super(key: key);

  @override
  State<VideoPopup> createState() => _VideoPopupState();
}

class _VideoPopupState extends State<VideoPopup> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.file.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: _controller.value.isPlaying ? Text('멈춤') : Text("재생"),
          )
        ],
      ),
    );
  }
}

class Upload extends ConsumerStatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  UploadState createState() => UploadState();
}

class UploadState extends ConsumerState {
  final ImagePicker _picker = ImagePicker();

  void _getVideoFromGallery(context) async {
    final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    debugPrint(image?.path);
    if (image == null) {
      return;
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => VideoPopup(file: image)));
  }

  void _getVideoFromCamera() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('갤러리에서 사진 가져오기'),
                onPressed: () {
                  _getVideoFromGallery(context);
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    _getVideoFromCamera();
                  },
                  child: const Text('사진 촬영하기'))
            ],
          ),
        ),
      ),
    );
  }
}
