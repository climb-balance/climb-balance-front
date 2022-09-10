import 'package:climb_balance/presentation/story_upload_screens/desc_story_screen.dart';
import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/provider/tag_selector_provider.dart';
import '../../../presentation/common/components/safe_area.dart';
import '../../../presentation/common/components/tags.dart';
import 'components/bottom_step_bar.dart';
import 'components/modal_picker.dart';
import 'components/upload_video_preview.dart';

class TagStoryScreen extends ConsumerWidget {
  const TagStoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final success = ref
        .watch(storyUploadViewModelProvider.select((value) => value.success));
    final date = ref.watch(
        storyUploadViewModelProvider.select((value) => value.videoTimestamp));
    final location = ref
        .watch(storyUploadViewModelProvider.select((value) => value.location));
    final difficulty = ref.watch(
        storyUploadViewModelProvider.select((value) => value.difficulty));
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '태그 달기',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Container(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UploadVideoPreview(),
            MySafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('실패/성공:'),
                      Switch(
                        value: success,
                        onChanged: ref
                            .read(storyUploadViewModelProvider.notifier)
                            .handleSuccess,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('날짜:'),
                      TextButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate:
                                DateTime.fromMillisecondsSinceEpoch(date),
                            firstDate: DateTime(2010),
                            lastDate: DateTime.now(),
                            locale: const Locale('ko', "KR"),
                          ).then(
                            (value) => ref
                                .read(storyUploadViewModelProvider.notifier)
                                .handleDatePick(
                                  value == null
                                      ? DateTime.now().millisecondsSinceEpoch
                                      : value!.millisecondsSinceEpoch,
                                ),
                          );
                        },
                        child: DateTag(
                          date: DateTime.fromMillisecondsSinceEpoch(date),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('위치:'),
                      TextButton(
                        onPressed: () {
                          showDialog<int>(
                            context: context,
                            builder: (context) => ModalPicker(
                              searchLabel: "클라이밍장 이름을 검색해주세요",
                              provider: locationSelectorProvider,
                            ),
                          ).then(
                            (value) => ref
                                .read(storyUploadViewModelProvider.notifier)
                                .updateLocation(
                                  location: value,
                                ),
                          );
                        },
                        child: LocationTag(
                          location: location,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('난이도:'),
                      TextButton(
                        onPressed: () {
                          showDialog<int>(
                            context: context,
                            builder: (context) => ModalPicker(
                              searchLabel: "난이도 태그를 검색해주세요",
                              provider: difficultySelectorProvider,
                            ),
                          ).then(
                            (value) => ref
                                .read(storyUploadViewModelProvider.notifier)
                                .updateDifficulty(
                                  difficulty: value,
                                ),
                          );
                        },
                        child: DifficultyTag(
                          difficulty: difficulty,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomStepBar(
        handleNext: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DescStoryScreen(),
            ),
          );
        },
      ),
    );
  }
}
