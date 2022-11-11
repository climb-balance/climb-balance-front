import 'package:flutter/material.dart';

class AvgCompare extends StatelessWidget {
  const AvgCompare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          '유저 상위 ',
          style: text.headline6?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '53% ',
          style: text.headline6?.copyWith(
            color: color.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '입니다!',
          style: text.headline6?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
