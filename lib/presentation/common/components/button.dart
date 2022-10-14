import 'package:flutter/material.dart';

class FullSizeBtnDeprecated extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final int type;

  const FullSizeBtnDeprecated(
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

class FullSizeBtn extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color color;

  const FullSizeBtn({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color = Colors.tealAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: child,
    );
  }
}

enum BtnType { primary, secondary, tertiary }

class CustomBtn extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final BtnType type;
  final double height;

  const CustomBtn(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.height = 40,
      this.type = BtnType.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
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
