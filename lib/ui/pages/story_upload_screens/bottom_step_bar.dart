import 'package:flutter/material.dart';

import '../../widgets/commons/button.dart';

class BottomStepBar extends StatelessWidget {
  final void Function() handleNext;
  final String next;

  BottomStepBar({Key? key, required this.handleNext, this.next = "다음"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomBtn(
              onPressed: () {
                Navigator.pop(context);
              },
              type: BtnType.secondary,
              child: const Text('이전'),
            ),
          ),
          Expanded(
            child: CustomBtn(
              onPressed: handleNext,
              type: BtnType.primary,
              child: Text(next),
            ),
          ),
        ],
      ),
    );
  }
}
