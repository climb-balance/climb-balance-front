import 'package:climb_balance/domain/util/duration_time.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/comment.dart';
import '../story_view_model.dart';

class CommentsList extends ConsumerWidget {
  final int storyId;

  const CommentsList({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(
        storyViewModelProvider(storyId).select((value) => value.comments));
    return Column(
      children: comments
          .map((comment) => CommentView(
                comment: comment,
                storyId: storyId,
              ))
          .toList(),
    );
  }
}

class CommentView extends ConsumerStatefulWidget {
  final Comment comment;
  final int storyId;

  const CommentView({
    Key? key,
    required this.comment,
    required this.storyId,
  }) : super(key: key);

  @override
  ConsumerState<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends ConsumerState<CommentView> {
  Offset _tapPosition = Offset.zero;

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _showStoryOptions(
      {required RenderBox overlay, required BuildContext context}) {
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _tapPosition & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          onTap: () {
            ref
                .read(storyViewModelProvider(widget.storyId).notifier)
                .deleteComment(
                  commentId: widget.comment.commentId,
                  context: context,
                );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Icon(Icons.delete),
              Text("삭제하기"),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Theme.of(context).colorScheme;
    return InkWell(
      onTapDown: (details) {
        _storePosition(details);
      },
      onLongPress: () {
        final RenderBox overlay =
            Overlay.of(context)?.context.findRenderObject() as RenderBox;
        _showStoryOptions(
          overlay: overlay,
          context: context,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage(widget.comment.userProfileImage),
                    ),
                    if (widget.comment.rank == 1)
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '전문가',
                            style: TextStyle(
                              color: color.primary,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.comment.nickname,
                      style: theme.textTheme.subtitle2
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatTimestampToPassedString(
                        widget.comment.createdTimestamp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.comment.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
