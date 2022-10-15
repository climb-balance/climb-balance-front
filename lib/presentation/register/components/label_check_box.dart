import 'package:flutter/material.dart';

class LabelCheckBox extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  final Widget label;
  final bool required;

  const LabelCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.required = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        label,
        Flexible(
            child: required && !value
                ? Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '필수입니다!',
                        style: text.subtitle2?.copyWith(
                          color: color.error,
                        ),
                      ),
                    ],
                  )
                : Container()),
        SizedBox(
          height: 35.0,
          width: 18,
          child: Checkbox(
            value: value,
            onChanged: (newValue) {
              onChanged(newValue!);
            },
            activeColor: color.primary,
            checkColor: color.onPrimary,
          ),
        ),
      ],
    );
  }
}
