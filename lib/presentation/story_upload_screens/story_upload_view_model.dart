import 'package:climb_balance/common/const/route_name.dart';
import 'package:climb_balance/data/repository/story_repository_impl.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../common/models/result.dart';
import '../../common/provider/tag_selector_provider.dart';
import '../common/custom_dialog.dart';
import 'components/modal_picker.dart';
import 'story_upload_state.dart';

final storyUploadViewModelProvider =
    StateNotifierProvider<StoryUploadViewModel, StoryUploadState>((ref) {
  StoryUploadViewModel notifier = StoryUploadViewModel(
    ref: ref,
    repository: ref.watch(storyRepositoryImplProvider),
  );
  notifier._init();
  return notifier;
});

class StoryUploadViewModel extends StateNotifier<StoryUploadState> {
  final ref;
  final StoryRepository repository;

  StoryUploadViewModel({required this.repository, required this.ref})
      : super(const StoryUploadState());

  void _init() {
    state =
        StoryUploadState(videoTimestamp: DateTime.now().millisecondsSinceEpoch);
  }

  void pickVideo(
      {required bool isFromCam, required BuildContext context}) async {
    final ImagePicker picker = ImagePicker();
    _init();
    picker
        .pickVideo(source: isFromCam ? ImageSource.camera : ImageSource.gallery)
        .then((image) async {
      if (image == null) {
        return;
      }
      state = state.copyWith(videoPath: image.path);
      Future.microtask(
        () {
          Navigator.of(context).pop();
          context.pushNamed(storyUploadRouteName);
        },
      );
    });
  }

  void updateVideoTrim(BuildContext context, Trimmer trimmer) {
    state = state.copyWith(
      start: trimmer.videoStartPos.toInt() == 0
          ? null
          : trimmer.videoStartPos / 1000,
      end: trimmer.videoEndPos.toInt() ==
              trimmer.videoPlayerController!.value.duration.inMilliseconds
          ? null
          : trimmer.videoEndPos / 1000,
    );
  }

  void pickTimestamp(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(state.videoTimestamp),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
      locale: const Locale('ko', "KR"),
    ).then((value) {
      if (value == null) return;
      state = state.copyWith(videoTimestamp: value.millisecondsSinceEpoch);
    });
  }

  void pickLocation(BuildContext context) {
    showDialog<int>(
      context: context,
      builder: (context) => ModalPicker(
        searchLabel: "클라이밍장 이름을 검색해주세요",
        provider: locationSelectorProvider,
      ),
    ).then((location) {
      if (location == null) return;
      state = state.copyWith(location: location);
    });
  }

  void pickDifficulty(BuildContext context) {
    showDialog<int>(
      context: context,
      builder: (context) => ModalPicker(
        searchLabel: "난이도 태그를 검색해주세요",
        provider: difficultySelectorProvider,
      ),
    ).then((difficulty) {
      if (difficulty == null) return;
      state = state.copyWith(difficulty: difficulty);
    });
  }

  void updateDescription(String? description) {
    description ??= '';
    state = state.copyWith(description: description);
  }

  void updateSuccess(final value) {
    state = state.copyWith(success: value);
  }

  void upload(BuildContext context) async {
    final Result<void> result =
        await repository.createStory(storyUpload: state);
    result.when(
      success: (value) {
        context.pop();
      },
      error: (message) {
        customShowDialog(context: context, title: '에러', content: message);
      },
    );
    dispose();
  }
}
