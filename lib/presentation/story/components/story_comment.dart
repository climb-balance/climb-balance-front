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
      children:
          comments.map((comment) => CommentView(comment: comment)).toList(),
    );
  }
}

class CommentView extends StatelessWidget {
  final Comment comment;

  const CommentView({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(comment.userProfileImage),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.nickname,
                    style: theme.textTheme.subtitle2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(formatTimestampToPassedString(comment.createdTimestamp)),
                ],
              ),
            ],
          ),
          const Divider(),
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Text(
              comment.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
