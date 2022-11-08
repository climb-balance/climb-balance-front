import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:climb_balance/presentation/ai_feedback/components/ai_feedback_actions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../common/ui/theme/specific_theme.dart';
import 'components/ai_feedback_information.dart';
import 'components/ai_feedback_overlay.dart';
import 'components/ai_feedback_progress_bar.dart';

class AiFeedbackScreen extends ConsumerStatefulWidget {
  final int storyId;

  const AiFeedbackScreen({Key? key, required this.storyId}) : super(key: key);

  @override
  ConsumerState<AiFeedbackScreen> createState() => _AiFeedbackScreenState();
}

class _AiFeedbackScreenState extends ConsumerState<AiFeedbackScreen>
    with TickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  void togglePlaying() {
    if (!_videoPlayerController.value.isInitialized) return;
    _videoPlayerController.value.isPlaying
        ? _videoPlayerController.pause()
        : _videoPlayerController.play();
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      ref
          .read(aiFeedbackViewModelProvider(widget.storyId).notifier)
          .getStoryAiVideoPath(),
      formatHint: VideoFormat.hls,
    );
    _videoPlayerController.initialize().then((_) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool isInformOpen = ref.watch(
        aiFeedbackViewModelProvider(widget.storyId)
            .select((value) => value.isInformOpen));
    final bool actionsOpen = ref.watch(
        aiFeedbackViewModelProvider(widget.storyId)
            .select((value) => value.actionsOpen));
    return StoryViewTheme(
      child: GestureDetector(
        onTap: () {
          ref
              .read(aiFeedbackViewModelProvider(widget.storyId).notifier)
              .toggleActionOpen(_videoPlayerController.value.isPlaying);
        },
        child: SafeArea(
          child: Stack(
            children: [
              _videoPlayerController.value.isInitialized
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Center(
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController.value.aspectRatio,
                                  child: VideoPlayer(
                                    _videoPlayerController,
                                  ),
                                ),
                                AiFeedbackOverlay(
                                  videoPlayerController: _videoPlayerController,
                                  ticker: this,
                                  storyId: widget.storyId,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isInformOpen)
                          AiFeedbackInformation(
                            storyId: widget.storyId,
                          ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              if (actionsOpen && !isInformOpen)
                AiFeedbackActions(
                  togglePlaying: togglePlaying,
                  storyId: widget.storyId,
                  videoPlayerController: _videoPlayerController,
                ),
              if (!isInformOpen)
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AiFeedbackProgressBar(
                      storyId: widget.storyId,
                      controller: _videoPlayerController,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
