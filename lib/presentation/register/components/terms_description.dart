import 'package:flutter/material.dart';

class TermsDescription extends StatelessWidget {
  final String name;

  const TermsDescription({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Text('본인은 '),
        InkWell(
            child: Text(
              name,
              style: TextStyle(color: theme.colorScheme.primary),
            ),
            onTap: () {}),
        const Text('에 동의하십니다.'),
      ],
    );
  }
}
