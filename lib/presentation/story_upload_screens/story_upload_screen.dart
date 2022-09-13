import 'dart:io';

import 'package:climb_balance/presentation/story_upload_screens/edit_video_tab.dart';
import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:climb_balance/presentation/story_upload_screens/tag_story_tab.dart';
import 'package:flutter/material.dart';
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

class _StoryUploadScreenState extends ConsumerState<StoryUploadScreen> {
  Trimmer trimmer = Trimmer();

  @override
  void dispose() {
    trimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    trimmer.loadVideo(
        videoFile: File(ref.watch(
            storyUploadViewModelProvider.select((value) => value.videoPath!))));
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UploadVideoPreview(
              trimmer: trimmer,
            ),
            TabBar(
              tabs: [
                EditVideoTab(trimmer: trimmer),
                const TagStoryTab(),
                const DescStoryTab(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomStepBar(
        handleNext: () {},
      ),
    );
  }
}
