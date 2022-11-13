import 'dart:io';

import 'package:climb_balance/presentation/story_upload_screens/edit_video_tab.dart';
import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:climb_balance/presentation/story_upload_screens/tag_story_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_trimmer/video_trimmer.dart';

import 'components/bottom_step_bar.dart';
import 'components/upload_video_preview.dart';
import 'desc_story_tab.dart';

class StoryUploadScreen extends ConsumerStatefulWidget {
  const StoryUploadScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _StoryUploadScreenState();
}

class _StoryUploadScreenState extends ConsumerState<StoryUploadScreen>
    with SingleTickerProviderStateMixin {
  Trimmer trimmer = Trimmer();
  late TabController _tabController;
  int _index = 0;

  void _initVideo() {
    Future.microtask(() {
      trimmer.loadVideo(
          videoFile: File(ref.watch(storyUploadViewModelProvider
              .select((value) => value.videoPath!))));
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initVideo();
    _tabController.addListener(() {
      _index = _tabController.index;
      setState(() {});
    });
  }

  @override
  void dispose() {
    trimmer.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ref.watch(storyUploadViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UploadVideoPreview(
              trimmer: trimmer,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  EditVideoTab(
                    trimmer: trimmer,
                  ),
                  const TagStoryTab(),
                  const DescStoryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomStepBar(
        handleNext: () {
          if (_index < 2) {
            _tabController.animateTo(_index + 1);
          } else {
            ref.read(storyUploadViewModelProvider.notifier).upload(context);
          }
        },
        handleBack: () {
          if (_index == 0) {
            context.pop();
          } else {
            _tabController.animateTo(_index - 1);
          }
        },
        next: _index == 2 ? '업로드' : '다음',
      ),
    );
  }
}
