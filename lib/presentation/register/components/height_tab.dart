import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../register_view_model.dart';
import 'customRangeNumberField.dart';
import 'information.dart';

class HeightTab extends ConsumerWidget {
  const HeightTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('키를 입력해주세요.', style: text.headline4),
        const SizedBox(
          height: 40,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomRangeNumberField(
              value: ref.watch(
                registerViewModelProvider.select((value) => value.height),
              ),
              errorText: '잘못된 값입니다.',
              onChange: (value) {
                ref
                    .read(registerViewModelProvider.notifier)
                    .updateHeight(value);
              },
              maxValue: 200,
              minValue: 100,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'cm',
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
