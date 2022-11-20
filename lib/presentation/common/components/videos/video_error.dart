import 'package:flutter/material.dart';

class VideoError extends StatelessWidget {
  const VideoError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: Text(
          '문제가 발생해 비디오를 재생할 수 없습니다.',
          style: TextStyle(
            color: color.error,
          ),
        ),
      ),
    );
  }
}
