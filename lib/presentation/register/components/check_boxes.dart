import 'package:climb_balance/presentation/register/components/terms_description.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/checkbox_formfield.dart';
import '../register_view_model.dart';

class CheckBoxes extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const CheckBoxes({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CheckBoxesState();
}

class _CheckBoxesState extends ConsumerState<CheckBoxes> {
  bool allCheck = false;

  void updateValue() {
    allCheck = !allCheck;
    ref.read(registerViewModelProvider.notifier).updatePersonalCheck(allCheck);
    ref.read(registerViewModelProvider.notifier).updatePromotionCheck(allCheck);
    ref.read(registerViewModelProvider.notifier).updateRequiredCheck(allCheck);

    setState(() {});
    ref.read(registerViewModelProvider.notifier).validateLast(widget.formKey);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('모두 동의하기'),
              Checkbox(
                value: allCheck,
                onChanged: (_) {
                  updateValue();
                },
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TermsDescription(
                name: '필수 약관',
              ),
              CheckBoxFormField(
                onChanged: (value) {
                  if (value == null) return;
                  ref
                      .read(registerViewModelProvider.notifier)
                      .updateRequiredCheck(value);
                  ref
                      .read(registerViewModelProvider.notifier)
                      .validateLast(widget.formKey);
                },
                value: ref.watch(registerViewModelProvider
                    .select((value) => value.requiredCheck)),
                label: Container(),
                validator: (bool? value) {
                  if (value == null || value == false) {
                    return '필수입니다.';
                  }
                  return null;
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TermsDescription(
                name: '개인정보 선택 약관',
              ),
              Checkbox(
                value: ref.watch(registerViewModelProvider
                    .select((value) => value.personalCheck)),
                onChanged: (value) {
                  if (value == null) return;
                  ref
                      .watch(registerViewModelProvider.notifier)
                      .updatePersonalCheck(value);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TermsDescription(
                name: '광고 선택 약관',
              ),
              Checkbox(
                value: ref.watch(registerViewModelProvider
                    .select((value) => value.promotionCheck)),
                onChanged: (value) {
                  if (value == null) return;
                  ref
                      .watch(registerViewModelProvider.notifier)
                      .updatePromotionCheck(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
