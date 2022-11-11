import 'package:flutter/material.dart';

class NoEffectInkWell extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  const NoEffectInkWell({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: child,
    );
  }
}
