import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

import '../register_view_model.dart';
import 'information.dart';

class HeightTab extends ConsumerWidget {
  const HeightTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          const Information(
              title: '키를 입력해주세요',
              info:
                  '맞춤형 영상을 제공하기 위해 필요한 정보입니다. 동의가 없어도 서비스는 이용 가능하지만 원활한 이용을 위해 동의를 권장드립니다.'),
          NumberPicker(
            itemCount: 5,
            textStyle: Theme.of(context).textTheme.headline4,
            selectedTextStyle: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Theme.of(context).primaryColor),
            itemHeight: 50,
            minValue: 100,
            maxValue: 200,
            value: ref.watch(
                registerViewModelProvider.select((value) => value.height)),
            onChanged: (value) {
              ref.read(registerViewModelProvider.notifier).updateHeight(value);
            },
          ),
        ],
      ),
    );
  }
}
