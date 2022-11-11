import 'package:flutter/material.dart';

class AiBackground extends StatelessWidget {
  const AiBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AspectRatio(
              aspectRatio: 8 / 10,
              child: Container(
                decoration: BoxDecoration(
                  color: color.surface,
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://picsum.photos/250?image=9'),
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
              end: FractionalOffset.center + const FractionalOffset(0.1, 0),
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
