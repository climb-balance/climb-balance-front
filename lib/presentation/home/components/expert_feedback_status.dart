import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../home_view_model.dart';

class ExpertFeedbackStatus extends ConsumerWidget {
  const ExpertFeedbackStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final finishedExpertFeedback = ref.watch(
        homeViewModelProvider.select((value) => value.completedExpertFeedback));
    final waitingExpertFeedback = ref.watch(
        homeViewModelProvider.select((value) => value.waitingExpertFeedback));

    return Flexible(
      fit: FlexFit.tight,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(
                '전문가',
                style: theme.textTheme.subtitle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${waitingExpertFeedback}/${finishedExpertFeedback}',
                      style: theme.textTheme.subtitle1,
                    ),
                    Text(
                      '대기/완료',
                      style: theme.textTheme.subtitle2,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
