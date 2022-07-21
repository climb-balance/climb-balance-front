import 'package:flutter/material.dart';

class BottomStepBar extends StatelessWidget {
  final void Function() handleNext;
  final String next;

  BottomStepBar({Key? key, required this.handleNext, this.next = "다음"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('이전'),
          ),
          ElevatedButton(
            onPressed: handleNext,
            child: Text(next),
          ),
        ],
      ),
    );
  }
}
