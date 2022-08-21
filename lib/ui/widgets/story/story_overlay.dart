import 'package:climb_balance/models/story_tag.dart';
import 'package:climb_balance/providers/feedback_status.dart';
import 'package:climb_balance/providers/user_provider.dart';
import 'package:climb_balance/ui/pages/feedback_page/ai_feedback_request/ai_feedback_ads.dart';
import 'package:climb_balance/ui/widgets/commons/global_dialog.dart';
import 'package:climb_balance/ui/widgets/story/progress_bar.dart';
import 'package:climb_balance/ui/widgets/story/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../models/story.dart';
import '../../../models/user.dart';
import '../commons/row_icon_detail.dart';
import '../user_profile_info.dart';

class StoryOverlay extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final Story story;
  final void Function() handleBack;
  final void Function() toggleCommentOpen;

  const StoryOverlay({
    Key? key,
    required this.story,
    required this.handleBack,
    required this.videoPlayerController,
    required this.toggleCommentOpen,
  }) : super(key: key);

  @override
  State<StoryOverlay> createState() => _StoryOverlayState();
}

class _StoryOverlayState extends State<StoryOverlay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        widget.videoPlayerController.value.isPlaying
            ? widget.videoPlayerController.pause()
            : widget.videoPlayerController.play();
      },
      child: Scaffold(
        floatingActionButton: StoryButtons(
          story: widget.story,
          toggleCommentOpen: widget.toggleCommentOpen,
        ),
        floatingActionButtonLocation: CustomFabLoc(),
        backgroundColor: Colors.transparent,
        appBar: StoryOverlayAppBar(
          tags: widget.story.tags,
          handleBack: widget.handleBack,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.story.description),
                  ],
                ),
              ),
              BottomUserProfile(
                userProfile: genRandomUser(),
                description: widget.story.description,
              ),
            ],
          ),
        ),
        bottomNavigationBar: ProgressBar(
          videoPlayerController: widget.videoPlayerController,
        ),
      ),
    );
  }
}

class StoryOverlayAppBar extends StatelessWidget with PreferredSizeWidget {
  final StoryTags tags;
  final void Function() handleBack;

  const StoryOverlayAppBar(
      {Key? key, required this.tags, required this.handleBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: StoryTagInfo(
        tags: tags,
      ),
      titleTextStyle: Theme.of(context).textTheme.bodyText2,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: handleBack,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomFabLoc extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
      scaffoldGeometry.scaffoldSize.width -
          scaffoldGeometry.floatingActionButtonSize.width,
      scaffoldGeometry.scaffoldSize.height -
          scaffoldGeometry.floatingActionButtonSize.height,
    );
  }
}

class StoryButtons extends ConsumerWidget {
  final Story story;
  final void Function() toggleCommentOpen;

  const StoryButtons(
      {Key? key, required this.story, required this.toggleCommentOpen})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curUserId = ref.watch(userProvider.select((value) => value.userId));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (curUserId == curUserId && story.aiAvailable == 3)
          TextButton(
            onPressed: () {},
            child: Column(
              children: const [
                Icon(
                  Icons.android,
                  size: 35,
                ),
              ],
            ),
          ),
        TextButton(
          onPressed: () {},
          child: Column(
            children: [
              const Icon(
                Icons.thumb_up,
                size: 35,
              ),
              Text('${story.likes}'),
            ],
          ),
        ),
        TextButton(
          onPressed: toggleCommentOpen,
          child: Column(
            children: [
              const Icon(
                Icons.comment,
                size: 35,
              ),
              Text('${story.comments}'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Column(
            children: const [
              Icon(
                Icons.share,
                size: 35,
              ),
              Text('공유'),
            ],
          ),
        ),
        if (curUserId == curUserId &&
            (story.aiAvailable == 1 || story.expertAvailable == 1))
          StoryFeedbackBtn(story: story),
      ],
    );
  }
}

class StoryFeedbackBtn extends StatelessWidget {
  const StoryFeedbackBtn({
    Key? key,
    required this.story,
  }) : super(key: key);

  final Story story;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          enableDrag: true,
          context: context,
          builder: (context) => FeedbackRequestSheet(
            story: story,
          ),
        );
      },
      child: Column(
        children: const [
          Icon(
            Icons.more,
            size: 35,
          ),
          Text('피드백'),
        ],
      ),
    );
  }
}

class FeedbackRequestSheet extends ConsumerWidget {
  final Story story;

  const FeedbackRequestSheet({Key? key, required this.story}) : super(key: key);

  void handleAiFeedbackBtnClick(context, int rank, WidgetRef ref) async {
    if (rank == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const AiFeedbackAds()));
      return;
    }
    String waitMessage = rank == 2 ? '5분' : '24시간';
    bool result = await customShowConfirm(
        context: context,
        title: 'AI 피드백 요청',
        content: '소요 시간은 시간은 최대 $waitMessage입니다.');
    if (!result) {
      return;
    }
    customShowDialog(
        context: context,
        title: '성공',
        content: '요청이 완료되었습니다. 진행 상태는 메인 페이지에서 확인할 수 있습니다.');
    ref.read(feedbackStatusProvider.notifier).addTimer(
        timerTime:
            rank == 2 ? const Duration(minutes: 5) : const Duration(days: 1));
    Navigator.pop(context);
  }

  void handleExpertFeedbackBtnClick(BuildContext context) async {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => const ExpertFeedbackRequest()));
    bool result = await customShowConfirm(
        context: context, title: '전문가 피드백 요청', content: '정말로 신청하시겠습니까?');
    if (!result) {
      return;
    }
    customShowDialog(
        context: context,
        title: '성공',
        content: '요청이 완료되었습니다. 진행 상태는 메인 페이지에서 확인할 수 있습니다.');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int rank = ref.watch(userProvider.select((value) => value.rank));
    return ListView(
      shrinkWrap: true,
      children: [
        if (story.aiAvailable == 1)
          SizedBox(
            height: 60,
            child: TextButton(
              onPressed: () {
                handleAiFeedbackBtnClick(context, rank, ref);
              },
              child: const RowIconDetail(
                  icon: Icon(Icons.android), detail: 'AI 피드백 요청하기'),
            ),
          ),
        if (story.expertAvailable == 1)
          SizedBox(
            height: 60,
            child: TextButton(
              onPressed: () {
                handleExpertFeedbackBtnClick(context);
              },
              child: const RowIconDetail(
                  icon: Icon(Icons.my_library_books), detail: '전문가 피드백 요청하기'),
            ),
          ),
      ],
    );
  }
}
