import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../common/components/button.dart';
import '../register_view_model.dart';
import 'information.dart';

class WeightInfo extends ConsumerStatefulWidget {
  const WeightInfo({Key? key}) : super(key: key);

  @override
  ConsumerState<WeightInfo> createState() => _WeightInfoState();
}

class _WeightInfoState extends ConsumerState<WeightInfo> {
  int weight = 65;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          const Information(
              title: '몸무게를 입력해주세요',
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
            minValue: 25,
            maxValue: 150,
            value: weight,
            onChanged: (value) {
              setState(() {
                weight = value;
              });
            },
          ),
          FullSizeBtn(
            onPressed: () {
              final regiRef = ref.read(registerViewModelProvider.notifier);
              regiRef.updateWeight(weight);
              regiRef.nextPage();
            },
            text: '완료',
          ),
          FullSizeBtn(onPressed: () {}, text: '비밀로 할래요', type: 1),
        ],
      ),
    );
  }
}
