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
    final theme = Theme.of(context);
    return Flexible(
      fit: FlexFit.tight,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$cont회', style: theme.textTheme.headline6),
            Icon(
              Icons.local_fire_department,
              color: theme.colorScheme.tertiary.withOpacity(cont / 30),
              size: 75,
            ),
            const Text('연속 클라이밍'),
          ],
        ),
      ),
    );
  }
}
