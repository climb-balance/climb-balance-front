import 'package:flutter/material.dart';

class SkillInfo extends StatelessWidget {
  final String title;
  final double skilDegree;

  const SkillInfo({
    Key? key,
    required this.title,
    required this.skilDegree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            title,
            style: text.subtitle2?.copyWith(fontSize: 14),
          ),
        ),
        Stack(
          children: [
            Container(
              width: 100,
              height: 12,
              decoration: BoxDecoration(
                color: color.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              width: 100 * skilDegree,
              height: 12,
              decoration: BoxDecoration(
                color: color.primary,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
