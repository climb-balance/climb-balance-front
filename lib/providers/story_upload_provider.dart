import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../models/story_upload.dart';
import '../ui/pages/story_upload_screens/write_desc.dart';

class StoryUploadNotifier extends StateNotifier<StoryUpload> {
  StoryUploadNotifier() : super(const StoryUpload());

  Trimmer trimmer = Trimmer();

  Future<void> handlePick({required bool isCam}) async {
    state = StoryUpload(date: DateTime.now());

    final ImagePicker picker = ImagePicker();
    final image = isCam
        ? await picker.pickVideo(source: ImageSource.camera)
        : await picker.pickVideo(source: ImageSource.gallery);
    if (image == null) {
      throw '에러';
    }
    state = state.copyWith(
      file: File(image.path),
    );
  }

  Trimmer loadTrimmer() {
    return trimmer..loadVideo(videoFile: state.file!);
  }

  get getTrimmer => trimmer;

  void handleEditNext({required BuildContext context}) {
    state.copyWith(
      start: trimmer.videoStartPos,
      end: trimmer.videoEndPos,
    );
  }

  void handleDatePick(DateTime? newDate) async {
    if (newDate == null) return;

    state = state.copyWith(date: newDate);
  }

  void handleTagNext({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WriteDesc(trimmer: trimmer),
      ),
    );
  }

  void handleSuccess(final value) {
    state = state.copyWith(success: value);
  }
}

final storyUploadProvider =
    StateNotifierProvider.autoDispose<StoryUploadNotifier, StoryUpload>((ref) {
  StoryUploadNotifier notifier = StoryUploadNotifier();
  return notifier;
});
