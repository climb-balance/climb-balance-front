import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../register_view_model.dart';
import 'customRangeNumberField.dart';
import 'information.dart';

class WeightTab extends ConsumerWidget {
  const WeightTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('몸무게를 입력해주세요.', style: text.headline4),
        const SizedBox(
          height: 40,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomRangeNumberField(
              value: ref.watch(
                registerViewModelProvider.select((value) => value.weight),
              ),
              errorText: '잘못된 값입니다.',
              onChange: (value) {
                ref
                    .read(registerViewModelProvider.notifier)
                    .updateWeight(value);
              },
              maxValue: 120,
              minValue: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'kg',
              style: text.headline3,
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        const Information(),
      ],
    );
  }
}
