import 'package:climb_balance/domain/util/duration_time.dart';
import 'package:climb_balance/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContinuousStatistics extends ConsumerWidget {
  const ContinuousStatistics({Key? key}) : super(key: key);

  int _getCont(datas) {
    for (int i = 1; i < datas.length + 1; i++) {
      if (datas[datas.length - i] > 0) {
        continue;
      }
      return i - 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cont = _getCont(ref
        .watch(homeViewModelProvider.select((value) => value.climbingDatas)));
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: color.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '12회',
                style: text.headline2?.copyWith(
                  color: color.primary,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '연속 클라이밍\n중이에요!',
                style: text.bodyText1,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    formatDatetimeToAll(
                      DateTime.now(),
                    ),
                    style: text.bodyText2?.copyWith(
                      color: color.onBackground.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
