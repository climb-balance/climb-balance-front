import 'package:climb_balance/domain/util/duration_time.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/comment.dart';
import '../story_view_model.dart';

class StoryComments extends ConsumerWidget {
  final int storyId;

  const StoryComments({Key? key, required this.storyId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(storyViewModelProvider(storyId).notifier).loadComments();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      height: size.height * 0.6,
      width: size.width,
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          CommentActions(
            storyId: storyId,
          ),
          CommentsList(
            storyId: storyId,
          ),
        ],
      ),
    );
  }
}

class CommentActions extends ConsumerWidget {
  final int storyId;

  const CommentActions({Key? key, required this.storyId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggleCommentOpen =
        ref.read(storyViewModelProvider(storyId).notifier).toggleCommentOpen;
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surfaceVariant,
      child: Row(
        children: [
          IconButton(
            onPressed: toggleCommentOpen,
            icon: const Icon(Icons.arrow_back),
          ),
          Flexible(
            child: Text(
              '댓글',
              style: theme.textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children:
              comments.map((comment) => CommentView(comment: comment)).toList(),
        ),
      ),
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
