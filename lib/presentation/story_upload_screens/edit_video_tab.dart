import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_trimmer/video_trimmer.dart';

class EditVideoTab extends ConsumerStatefulWidget {
  final Trimmer trimmer;

  const EditVideoTab({
    Key? key,
    required this.trimmer,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EditVideoTabState();
}

class _EditVideoTabState extends ConsumerState<EditVideoTab> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (widget.trimmer.isInitialized) {
      isLoaded = true;
      setState(() {});
    } else {
      Stream<TrimmerEvent> _stream = widget.trimmer.eventStream;
      _stream.listen((event) {
        if (event == TrimmerEvent.initialized) {
          isLoaded = true;
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final updateVideoTrim =
        ref.read(storyUploadViewModelProvider.notifier).updateVideoTrim;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoaded)
              TrimEditor(
                circlePaintColor: Theme.of(context).colorScheme.tertiary,
                borderPaintColor: Theme.of(context).colorScheme.tertiary,
                scrubberPaintColor: Theme.of(context).colorScheme.primary,
                durationTextStyle: Theme.of(context).textTheme.bodyText2!,
                scrubberWidth: 5,
                trimmer: widget.trimmer,
                maxVideoLength: const Duration(minutes: 2),
                viewerWidth: MediaQuery.of(context).size.width - 20,
                thumbnailQuality: 15,
                onChangeEnd: (value) {
                  updateVideoTrim(context, widget.trimmer);
                },
                onChangeStart: (value) {
                  updateVideoTrim(context, widget.trimmer);
                },
                onChangePlaybackState: (value) {},
              ),
          ],
        ),
      ),
    );
  }
}
