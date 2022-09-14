import 'package:flutter/material.dart';

import '../../../../presentation/common/components/button.dart';

class BottomStepBar extends StatelessWidget {
  final void Function() handleNext;
  final void Function() handleBack;
  final String next;

  const BottomStepBar(
      {Key? key,
      required this.handleNext,
      required this.handleBack,
      this.next = "다음"})
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
              onPressed: handleBack,
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
