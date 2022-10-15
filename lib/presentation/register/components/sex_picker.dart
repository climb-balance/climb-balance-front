import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../register_view_model.dart';

class SexPicker extends ConsumerWidget {
  const SexPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sex =
        ref.watch(registerViewModelProvider.select((value) => value.sex));
    final color = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 125,
          child: RadioListTile<String>(
            contentPadding: EdgeInsets.zero,
            value: 'M',
            groupValue: sex,
            onChanged: (value) {
              ref.read(registerViewModelProvider.notifier).updateSex(value!);
            },
            title: Text('남성'),
            activeColor: color.primary,
          ),
        ),
        SizedBox(
          width: 125,
          child: RadioListTile<String>(
            contentPadding: EdgeInsets.zero,
            value: 'W',
            groupValue: sex,
            onChanged: (value) {
              ref.read(registerViewModelProvider.notifier).updateSex(value!);
            },
            title: Text('여성'),
            activeColor: color.primary,
          ),
        ),
      ],
    );
  }
}
