import 'dart:io';

import 'package:climb_balance/services/server_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../models/result.dart';
import '../models/story_upload.dart';

class StoryUploadNotifier extends StateNotifier<StoryUpload> {
  StoryUploadNotifier() : super(const StoryUpload());

  final Trimmer _trimmer = Trimmer();

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
    return _trimmer..loadVideo(videoFile: state.file!);
  }

  get trimmer => _trimmer;

  void handleEditNext({required BuildContext context}) {
    state.copyWith(
      start: _trimmer.videoStartPos,
      end: _trimmer.videoEndPos,
    );
  }

  void handleDatePick(DateTime? newDate) async {
    if (newDate == null) return;

    state = state.copyWith(date: newDate);
  }

  void updateLocation({int? location}) {
    if (location == null) return;
    state = state.copyWith(location: location);
  }

  void updateDifficulty({int? difficulty}) {
    if (difficulty == null) return;
    state = state.copyWith(difficulty: difficulty);
  }

  void updateDetail(String? detail) {
    detail ??= '';
    state = state.copyWith(detail: detail);
  }

  void handleSuccess(final value) {
    state = state.copyWith(success: value);
  }

  Future<Result<bool>> upload() async {
    final Result<bool> result = await ServerService.storyUpload(state);
    return result;
  }

  @override
  void dispose() {
    _trimmer.videoPlayerController?.dispose();

    _trimmer.dispose();

    super.dispose();
  }
}

final storyUploadProvider =
    StateNotifierProvider.autoDispose<StoryUploadNotifier, StoryUpload>((ref) {
  StoryUploadNotifier notifier = StoryUploadNotifier();
  return notifier;
});
