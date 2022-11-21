import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../home_view_model.dart';

class AiBackground extends ConsumerWidget {
  const AiBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(
        homeViewModelProvider.select((value) => value.aiStat!.thumbnail))!;
    final color = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AspectRatio(
              aspectRatio: 9 / 10,
              child: Container(
                decoration: BoxDecoration(
                  color: color.surface,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(thumbnail),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: FractionalOffset.centerRight,
              end: FractionalOffset.center + const FractionalOffset(0.05, 0),
              colors: [
                Colors.transparent,
                color.surface,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
