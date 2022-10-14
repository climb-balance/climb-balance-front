import 'package:flutter/material.dart';

class MySafeArea extends StatelessWidget {
  final Widget child;

  const MySafeArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: child,
    );
  }
}
