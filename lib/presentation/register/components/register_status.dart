import 'package:flutter/material.dart';

class RegisterStatus extends StatelessWidget {
  final int maxStep;
  final int currentStep;

  const RegisterStatus({
    Key? key,
    required this.maxStep,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < maxStep; i += 1)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: i == currentStep ? color.primary : color.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: 12,
                height: 12,
              ),
            ),
        ],
      ),
    );
  }
}
