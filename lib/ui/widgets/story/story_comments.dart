import 'package:flutter/material.dart';

class StoryComments extends StatelessWidget {
  final void Function() toggleCommentOpen;

  const StoryComments({Key? key, required this.toggleCommentOpen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      height: size.height * 0.6,
      width: size.width,
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          CommentActions(toggleCommentOpen: toggleCommentOpen),
          const CommentsList(),
        ],
      ),
    );
  }
}

class CommentActions extends StatelessWidget {
  final void Function() toggleCommentOpen;

  const CommentActions({Key? key, required this.toggleCommentOpen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: const [
            Comment(
              profileImage: 'https://i.imgur.com/4rhu9D0.png',
              name: '클라임바운스 한성희',
              score: '2.1점',
              content:
                  '영상 잘봤습니다. 전체적으로 자세가 너무 아쉽네요. 00:38 같은 경우에는 더 잘할 수 있을 것 같은데, 무게 중심을 너무 조급하게 잡으시는 것 같아요.',
            ),
            SizedBox(
              height: 20,
            ),
            Comment(
              profileImage: 'https://i.imgur.com/dlNIA10.jpeg',
              name: '정글짐 이시선',
              score: '3점',
              content: '00:12의 발 무브가 정말 좋네요. 그러나 좀 더 아웃사이드로 밟으셨다면 좋겠네요.',
            ),
          ],
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String profileImage;
  final String name;
  final String score;
  final String content;

  const Comment(
      {Key? key,
      required this.profileImage,
      required this.name,
      required this.score,
      required this.content})
      : super(key: key);

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
                backgroundImage: NetworkImage(profileImage),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.subtitle2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Text('1일전')
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(score),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Text(
              content,
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
