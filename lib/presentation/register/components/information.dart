import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return Text(
      '맞춤형 영상을 제공하기 위해 필요한 정보입니다.\n동의 없이도 이용 가능하지만,\n원활한 이용을 위해 동의를 권장합니다.',
      style: text.bodyText2!.copyWith(
        color: color.onBackground.withOpacity(0.5),
      ),
    );
  }
}
