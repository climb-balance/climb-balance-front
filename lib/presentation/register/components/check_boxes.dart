import 'package:climb_balance/presentation/register/components/terms_description.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../register_view_model.dart';
import 'label_check_box.dart';

class CheckBoxes extends ConsumerStatefulWidget {
  const CheckBoxes({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CheckBoxesState();
}

class _CheckBoxesState extends ConsumerState<CheckBoxes> {
  bool allCheck = false;

  void updateValue(bool _) {
    allCheck = !allCheck;
    ref.read(registerViewModelProvider.notifier).updatePersonalCheck(allCheck);
    ref.read(registerViewModelProvider.notifier).updatePromotionCheck(allCheck);
    ref.read(registerViewModelProvider.notifier).updateRequiredCheck(allCheck);

    setState(() {});
    ref.read(registerViewModelProvider.notifier).validateLast();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LabelCheckBox(
          value: allCheck,
          onChanged: updateValue,
          label: Text(
            '모두 동의하기',
            style: text.bodyText1,
          ),
        ),
        LabelCheckBox(
          value: ref.watch(
              registerViewModelProvider.select((value) => value.requiredCheck)),
          onChanged:
              ref.read(registerViewModelProvider.notifier).updateRequiredCheck,
          label: const TermsDescription(
            name: '필수 약관',
            required: true,
            url: 'https://www.climb-balance.com/policy/service',
          ),
          required: true,
        ),
        LabelCheckBox(
          value: ref.watch(registerViewModelProvider
              .select((value) => value.promotionCheck)),
          onChanged: ref
              .watch(registerViewModelProvider.notifier)
              .updatePromotionCheck,
          label: const TermsDescription(
            name: '광고 선택 약관',
            url: 'https://www.climb-balance.com/policy/promotion',
          ),
        ),
        LabelCheckBox(
          value: ref.watch(
              registerViewModelProvider.select((value) => value.personalCheck)),
          onChanged:
              ref.watch(registerViewModelProvider.notifier).updatePersonalCheck,
          label: const TermsDescription(
            name: '개인정보 선택 약관',
            url: 'https://www.climb-balance.com/policy/privacy',
          ),
        ),
      ],
    );
  }
}
