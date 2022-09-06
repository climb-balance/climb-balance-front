import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiFeedbackStatus extends ConsumerWidget {
  const AiFeedbackStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Flexible(
      fit: FlexFit.tight,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(
                '인공지능',
                style: theme.textTheme.subtitle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 110,
                // TODO connect main state
                child: true
                    ? const AiFeedbackStatusInform()
                    : const NoFeedbackInform(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AiFeedbackStatusInform extends ConsumerWidget {
  const AiFeedbackStatusInform({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 80,
          child: AspectRatio(aspectRatio: 1, child: Text('s')),
        ),
      ],
    );
  }
}

class NoFeedbackInform extends StatelessWidget {
  const NoFeedbackInform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '요청한 피드백이 완료되었거나 없습니다.',
      overflow: TextOverflow.fade,
    );
  }
}
