import 'dart:io';
import 'package:climb_balance/ui/pages/home/editVideo.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class GetVideo extends StatefulWidget {
  final bool isCam;

  const GetVideo({Key? key, this.isCam = false}) : super(key: key);

  @override
  State<GetVideo> createState() => GetVideoState();
}

class GetVideoState extends State<GetVideo> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getVideoFromSource(context);
  }

  void getVideoFromSource(context) async {
    final XFile? image = widget.isCam
        ? await _picker.pickVideo(source: ImageSource.camera)
        : await _picker.pickVideo(source: ImageSource.gallery);
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
