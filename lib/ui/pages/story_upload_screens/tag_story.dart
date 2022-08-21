import 'package:climb_balance/providers/story_upload_provider.dart';
import 'package:climb_balance/ui/pages/story_upload_screens/modal_picker.dart';
import 'package:climb_balance/ui/pages/story_upload_screens/write_desc.dart';
import 'package:climb_balance/ui/widgets/commons/safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../../providers/tag_selector_provider.dart';
import 'bottom_step_bar.dart';

class TagStory extends ConsumerWidget {
  const TagStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trimmer = ref.read(storyUploadProvider.notifier).getTrimmer;
    final success =
        ref.watch(storyUploadProvider.select((value) => value.success));
    final date = ref.watch(storyUploadProvider.select((value) => value.date));
    final locationDatas = ref
        .watch(locationSelectorProvider.notifier)
        .getFilteredLocationSelector;
    final locationUpdateQuery = ref
        .read(locationSelectorProvider.notifier)
        .updateFilteredLocationSelector;
    final difficultyUpdateQuery = ref
        .read(difficultySelectorProvider.notifier)
        .updateFilteredDifficultySelector;
    final difficultyDatas = ref
        .watch(difficultySelectorProvider.notifier)
        .getFilteredDifficultySelector;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '태그 달기',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Container(),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: VideoViewer(
              trimmer: trimmer,
            ),
          ),
          MySafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('실패/성공:'),
                    Switch(
                      value: success,
                      onChanged:
                          ref.read(storyUploadProvider.notifier).handleSuccess,
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
                          initialDate: date!,
                          firstDate: DateTime(2010),
                          lastDate: DateTime.now(),
                        ).then((value) => ref
                            .read(storyUploadProvider.notifier)
                            .handleDatePick);
                      },
                      child: Text('${date?.year}-${date?.month}-${date?.day}'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('위치:'),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ModalPicker(
                            searchLabel: "클라이밍장 이름을 검색해주세요",
                            datas: locationDatas,
                            updateQuery: locationUpdateQuery,
                          ),
                        );
                      },
                      child: Text('${date?.year}-${date?.month}-${date?.day}'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('난이도:'),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ModalPicker(
                            searchLabel: "난이도 태그를 검색해주세요",
                            datas: difficultyDatas,
                            updateQuery: difficultyUpdateQuery,
                          ),
                        );
                      },
                      child: Text('${date?.year}-${date?.month}-${date?.day}'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomStepBar(
        handleNext: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WriteDesc(trimmer: trimmer),
            ),
          );
        },
      ),
    );
  }
}
