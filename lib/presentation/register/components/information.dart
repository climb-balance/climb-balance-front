import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  final String title;
  final String info;

  const Information({Key? key, required this.title, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(title, style: theme.textTheme.headline4),
        Text(info, style: theme.textTheme.bodyText1),
      ],
    );
  }
}
