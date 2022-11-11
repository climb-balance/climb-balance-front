import 'package:climb_balance/presentation/home/components/skill_info.dart';
import 'package:flutter/material.dart';

import 'ai_background.dart';
import 'avg_compare.dart';

class RecentAiStat extends StatelessWidget {
  const RecentAiStat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          const AiBackground(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AvgCompare(),
                SizedBox(
                  height: 20,
                ),
                SkillInfo(
                  title: '기술',
                  skilDegree: 0.9,
                ),
                SizedBox(
                  height: 7,
                ),
                SkillInfo(
                  title: '유연성',
                  skilDegree: 0.4,
                ),
                SizedBox(
                  height: 7,
                ),
                SkillInfo(
                  title: '자세',
                  skilDegree: 0.7,
                ),
                SizedBox(
                  height: 7,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
