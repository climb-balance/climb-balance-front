import 'dart:io';

import 'package:climb_balance/data/repository/story_repository_impl.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../common/models/result.dart';
import 'story_upload_state.dart';

final storyUploadViewModelProvider =
    StateNotifierProvider.autoDispose<StoryUploadViewModel, StoryUploadState>(
        (ref) {
  StoryUploadViewModel notifier = StoryUploadViewModel(
    ref: ref,
    repository: ref.watch(storyRepositoryImplProvider),
  );
  return notifier;
});

class StoryUploadViewModel extends StateNotifier<StoryUploadState> {
  final ref;
  final StoryRepository repository;

  StoryUploadViewModel({required this.repository, required this.ref})
      : super(const StoryUploadState());

  final Trimmer _trimmer = Trimmer();

  Future<void> handlePick({required bool isCam}) async {
    state =
        StoryUploadState(videoTimestamp: DateTime.now().millisecondsSinceEpoch);

    final ImagePicker picker = ImagePicker();
    final image = isCam
        ? await picker.pickVideo(source: ImageSource.camera)
        : await picker.pickVideo(source: ImageSource.gallery);
    if (image == null) {
      throw '에러';
    }
  }

  Trimmer loadTrimmer() {
    return _trimmer..loadVideo(videoFile: File(state.videoPath!));
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

  void handleDatePick(int newTimestamp) async {
    state = state.copyWith(videoTimestamp: newTimestamp);
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

  Future<Result<void>> upload() async {
    final Result<void> result =
        await repository.createStory(storyUpload: state);
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    _trimmer.dispose();
  }
}
