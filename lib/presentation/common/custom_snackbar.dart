import 'package:flutter/material.dart';

import 'components/logo.dart';

void showCustomSnackbar(
    {required BuildContext context, required String message}) {
  final color = Theme.of(context).colorScheme;
  final snackBar = SnackBar(
    backgroundColor: color.tertiary,
    content: Row(
      children: [
        Container(
          width: 25,
          height: 25,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Logo(),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(message),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: '닫기',
      textColor: color.onTertiary,
      onPressed: () {},
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
