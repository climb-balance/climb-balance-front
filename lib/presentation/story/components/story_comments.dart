import 'package:climb_balance/presentation/story/components/story_comment.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../story_view_model.dart';
import 'comment_write.dart';

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
      child: CustomScrollView(
        slivers: [
          CommentActions(
            storyId: storyId,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Divider(
                  height: 2,
                  thickness: 1.5,
                ),
                CommentWrite(storyId: storyId),
                const SizedBox(
                  height: 10,
                ),
                CommentsList(
                  storyId: storyId,
                ),
              ],
            ),
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
    return SliverAppBar(
      pinned: true,
      leading: IconButton(
        onPressed: toggleCommentOpen,
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        '댓글',
        style: theme.textTheme.headline6,
      ),
    );
  }
}
