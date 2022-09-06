import 'dart:io';

import 'package:climb_balance/services/server_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../data/data_source/result.dart';
import '../models/story_upload.dart';

class StoryUploadNotifier extends StateNotifier<StoryUpload> {
  StoryUploadNotifier() : super(const StoryUpload());

  final Trimmer _trimmer = Trimmer();

  Future<void> handlePick({required bool isCam}) async {
    state = StoryUpload(videoDate: DateTime.now());

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

  void handleEditNext() {
    state = state.copyWith(
      start: _trimmer.videoStartPos.toInt() == 0
          ? null
          : _trimmer.videoStartPos / 1000,
      end: _trimmer.videoEndPos.toInt() ==
              _trimmer.videoPlayerController!.value.duration.inMilliseconds
          ? null
          : _trimmer.videoEndPos / 1000,
    );
  }

  void handleDatePick(DateTime? newDate) async {
    if (newDate == null) return;

    state = state.copyWith(videoDate: newDate);
  }

  void updateLocation({int? location}) {
    if (location == null) return;
    state = state.copyWith(location: location);
  }

  void updateDifficulty({int? difficulty}) {
    if (difficulty == null) return;
    state = state.copyWith(difficulty: difficulty);
  }

  void updateDescription(String? description) {
    description ??= '';
    state = state.copyWith(description: description);
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
    super.dispose();
    _trimmer.dispose();
  }
}

final storyUploadProvider =
    StateNotifierProvider.autoDispose<StoryUploadNotifier, StoryUpload>((ref) {
  StoryUploadNotifier notifier = StoryUploadNotifier();
  return notifier;
});
