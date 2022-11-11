import 'package:flutter/material.dart';

class WaitingProgress extends StatelessWidget {
  const WaitingProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
