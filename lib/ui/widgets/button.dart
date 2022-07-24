import 'package:flutter/material.dart';

class FullSizeBtn extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final int type;

  const FullSizeBtn(
      {Key? key, required this.onPressed, required this.text, this.type = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: type == 1
              ? MaterialStateProperty.all(Colors.grey)
              : MaterialStateProperty.all(theme.primaryColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

enum BtnType { primary, secondary, tertiary }

class CustomBtn extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final BtnType type;

  const CustomBtn(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.type = BtnType.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: type == BtnType.primary
                ? MaterialStateProperty.all(theme.colorScheme.primary)
                : MaterialStateProperty.all(theme.colorScheme.secondary),
          ),
          child: child,
        ),
      ),
    );
  }
}
