import 'dart:io';
import 'package:climb_balance/ui/pages/home/editVideo.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/botNavigationBar.dart';

class GetVideo extends ConsumerStatefulWidget {
  const GetVideo({Key? key}) : super(key: key);

  @override
  GetVideoState createState() => GetVideoState();
}

class GetVideoState extends ConsumerState {
  final ImagePicker _picker = ImagePicker();

  void _getVideoFromGallery(context) async {
    final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    debugPrint(image?.path);
    if (image == null) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EditVideo(
          video: File(image.path),
        ),
      ),
    );
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
      bottomNavigationBar: BotNavigationBar(
        currentIdx: 2,
      ),
    );
  }
}
