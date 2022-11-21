import 'package:better_player/better_player.dart';
import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:climb_balance/presentation/ai_feedback/components/ai_feedback_actions.dart';
import 'package:climb_balance/presentation/common/components/no_effect_inkwell.dart';
import 'package:climb_balance/presentation/common/components/videos/video_loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  void _onTap() {
    final bool isInformOpen = ref.watch(
        aiFeedbackViewModelProvider(widget.storyId)
            .select((value) => value.isInformOpen));
    if (!isInformOpen) {
      ref
          .read(aiFeedbackViewModelProvider(widget.storyId).notifier)
          .toggleActionOpen();
      return;
    }
    ref
        .read(aiFeedbackViewModelProvider(widget.storyId).notifier)
        .toggleInformation();
  }

  @override
  Widget build(BuildContext context) {
    final bool actionsOpen = ref.watch(
        aiFeedbackViewModelProvider(widget.storyId)
            .select((value) => value.actionsOpen));
    final bool isInformOpen = ref.watch(
        aiFeedbackViewModelProvider(widget.storyId)
            .select((value) => value.isInformOpen));
    final isPlaying = ref.watch(aiFeedbackViewModelProvider(widget.storyId)
        .select((value) => value.isPlaying));
    final isInitialized = ref.watch(aiFeedbackViewModelProvider(widget.storyId)
        .select((value) => value.isInitialized));
    final betterPlayerController = ref
        .read(aiFeedbackViewModelProvider(widget.storyId).notifier)
        .betterPlayerController;
    if (betterPlayerController == null || !isInitialized) {
      return const VideoLoading();
    }

    return StoryViewTheme(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: NoEffectInkWell(
                    onTap: _onTap,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: betterPlayerController
                            .videoPlayerController!.value.aspectRatio,
                        child: Stack(
                          children: [
                            BetterPlayer(
                              controller: betterPlayerController,
                            ),
                            AbsorbPointer(
                              child: AiFeedbackOverlay(
                                storyId: widget.storyId,
                                betterPlayerController: betterPlayerController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (isInformOpen)
                  AiFeedbackInformation(
                    storyId: widget.storyId,
                  ),
              ],
            ),
            if (actionsOpen && !isInformOpen)
              AiFeedbackActions(
                storyId: widget.storyId,
              ),
            if (!isInformOpen)
              Align(
                alignment: Alignment.bottomCenter,
                child: AiFeedbackProgressBar(
                  storyId: widget.storyId,
                  betterPlayerController: betterPlayerController,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
