import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).shadowColor.withOpacity(0.2),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
