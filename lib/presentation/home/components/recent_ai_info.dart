import 'package:climb_balance/presentation/home/components/recent_ai_stat.dart';
import 'package:flutter/material.dart';

class RecentAiInfo extends StatelessWidget {
  const RecentAiInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '최근 AI 평가',
          style: text.bodyText1,
        ),
        const SizedBox(
          height: 16,
        ),
        const RecentAiStat(),
      ],
    );
  }
}
