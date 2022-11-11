import 'package:flutter/material.dart';

class TermsDescription extends StatelessWidget {
  final String name;
  final bool required;

  const TermsDescription({Key? key, required this.name, this.required = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(required ? '[필수] ' : '[선택] ', style: text.subtitle2),
        InkWell(
            child: Text(
              name,
              style: text.subtitle2!.copyWith(color: color.primary),
            ),
            onTap: () {}),
        Text('에 동의합니다.', style: text.subtitle2),
      ],
    );
  }
}
