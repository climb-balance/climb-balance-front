import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/story_upload.dart';
import '../ui/pages/story_upload_screens/edit_video.dart';

class StoryUploadNotifier extends StateNotifier<StoryUpload> {
  StoryUploadNotifier() : super(const StoryUpload());

  final ImagePicker _picker = ImagePicker();

  void handlePick({required bool isCam, required BuildContext context}) async {
    isCam
        ? await _picker.pickVideo(source: ImageSource.camera)
        : await _picker.pickVideo(source: ImageSource.gallery).then((image) {
            if (image == null) {
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => EditVideo(video: File(image.path)),
              ),
            );
          });
  }
}

final storyUploadProvider =
    StateNotifierProvider<StoryUploadNotifier, StoryUpload>((ref) {
  StoryUploadNotifier notifier = StoryUploadNotifier();
  return notifier;
});
