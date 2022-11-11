import 'package:flutter/material.dart';

class AiInformationTabBar extends StatelessWidget {
  const AiInformationTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      color: color.surface,
      child: TabBar(
        indicatorColor: color.primary,
        labelPadding: const EdgeInsets.all(10),
        tabs: const [Text('점수'), Text('분석'), Text('통계')],
      ),
    );
  }
}
