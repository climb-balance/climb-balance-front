import 'package:flutter/material.dart';

class FullSizeBtn extends StatelessWidget {
  final Function onPressed;
  final String text;
  final int type;
  const FullSizeBtn(
      {Key? key, required this.onPressed, required this.text, this.type = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: () {},
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
