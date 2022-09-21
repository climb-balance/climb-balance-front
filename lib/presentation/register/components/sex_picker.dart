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
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          child: Flexible(
            child: Icon(
              Icons.male,
              size: 100,
              color: sex == 'M'
                  ? theme.colorScheme.primary
                  : theme.colorScheme.secondary,
            ),
          ),
          onTap: () {
            ref.read(registerViewModelProvider.notifier).updateSex(true);
          },
        ),
        InkWell(
          child: Flexible(
            child: Icon(
              Icons.female,
              size: 100,
              color: sex == 'F'
                  ? theme.colorScheme.primary
                  : theme.colorScheme.secondary,
            ),
          ),
          onTap: () {
            ref.read(registerViewModelProvider.notifier).updateSex(false);
          },
        ),
      ],
    );
  }
}
