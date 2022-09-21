import 'package:flutter/material.dart';

class RowIconDetail extends StatelessWidget {
  final Widget icon;
  final String detail;

  const RowIconDetail({Key? key, required this.icon, this.detail = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        icon,
        const SizedBox(
          width: 10,
        ),
        Text(detail),
      ],
    );
  }
}
