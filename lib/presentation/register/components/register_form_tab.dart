import 'package:climb_balance/presentation/common/components/checkbox_formfield.dart';
import 'package:climb_balance/presentation/common/components/text_input.dart';
import 'package:climb_balance/presentation/register/components/sex_picker.dart';
import 'package:climb_balance/presentation/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/avatar_picker.dart';

class RegisterFormTab extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const RegisterFormTab({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            '성별',
            style: theme.textTheme.subtitle1,
          ),
          const SexPicker(),
          const Divider(),
          Row(
            children: [
              Flexible(
                child: AvatarPicker(
                  updateImagePath: (String imagePath) {
                    ref
                        .read(registerViewModelProvider.notifier)
                        .updateProfileImage(imagePath);
                  },
                  imagePath: ref.watch(
                    registerViewModelProvider
                        .select((value) => value.profileImage),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextInput(
                      handleUpdate: (value) {
                        ref
                            .read(registerViewModelProvider.notifier)
                            .updateNickname(value);
                        ref
                            .read(registerViewModelProvider.notifier)
                            .valid(formKey);
                      },
                      checkValue: (String? value) {
                        if (value == null) {
                          return '입력해주세요';
                        } else if (value.length < 2) {
                          return '2글자 이상 이여야 합니다.';
                        }
                        return null;
                      },
                      label: '닉네임',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          CustomTextInput(
            handleUpdate: (value) {
              ref
                  .read(registerViewModelProvider.notifier)
                  .updateDescription(value);
              ref.read(registerViewModelProvider.notifier).valid(formKey);
            },
            checkValue: (String? value) {
              return null;
            },
            maxLines: 3,
            label: '자기소개',
          ),
          CheckBoxes(formKey: formKey),
        ],
      ),
    );
  }
}

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
    ref.read(registerViewModelProvider.notifier).valid(widget.formKey);
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
              const Text('여기 동의하시면 필수 약관어쩌구'),
              CheckBoxFormField(
                onChanged: (value) {
                  if (value == null) return;
                  ref
                      .read(registerViewModelProvider.notifier)
                      .updateRequiredCheck(value);
                  ref
                      .read(registerViewModelProvider.notifier)
                      .valid(widget.formKey);
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
              const Text('여기 동의하시면 선택 약관어쩌구'),
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
              const Text('여기 동의하시면 광고 선택 약관어쩌구'),
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
