import 'dart:typed_data';

import 'package:climb_balance/data/repository/story_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../domain/model/story.dart';
import '../../providers/tag_selector_provider.dart';
import '../story/story_screen.dart';

// TODO rollback to stateless
class StoryPreview extends ConsumerStatefulWidget {
  final Story story;

  const StoryPreview({Key? key, required this.story}) : super(key: key);

  @override
  ConsumerState<StoryPreview> createState() => _StoryPreviewState();
}

class _StoryPreviewState extends ConsumerState<StoryPreview> {
  Uint8List? data;

  void getThumbnail() async {
    final repository = ref.watch(storyRepositoryImplProvider);
    data = await VideoThumbnail.thumbnailData(
      video: repository.getStoryThumbnailPath(widget.story.storyId),
      imageFormat: ImageFormat.JPEG,
      quality: 100,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.surfaceVariant,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StoryScreen(
                story: widget.story,
                handleBack: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (data == null
                      ? const NetworkImage('https://i.imgur.com/wJuxMJU.jpeg')
                      : MemoryImage(data!) as ImageProvider),
                ),
              ),
            ),
            StoryPreviewIcon(story: widget.story)
          ],
        ),
      ),
    );
  }
}

class StoryPreviewIcon extends ConsumerWidget {
  final Story story;

  const StoryPreviewIcon({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficultyColor = ref
            .read(difficultySelectorProvider.notifier)
            .getSelector(story.tags.difficulty)
            .color ??
        Colors.white;
    return Stack(
      children: [
        Icon(
          Icons.bookmark,
          color: difficultyColor,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 6,
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.white,
            ),
            child: Icon(
              story.tags.success ? Icons.check_circle : Icons.change_circle,
              size: 12,
            ),
          ),
        ),
      ],
    );
  }
}
