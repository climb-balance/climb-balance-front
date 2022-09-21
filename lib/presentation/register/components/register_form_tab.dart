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
                      handleUpdate: ref
                          .read(registerViewModelProvider.notifier)
                          .updateNickname,
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
            handleUpdate:
                ref.read(registerViewModelProvider.notifier).updateDescription,
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
  List<bool> values = [false, false, false, false];

  void updateValue(int idx) {
    if (idx == 0) {
      bool nxtVal = !values[0];
      values = values.map((value) => nxtVal).toList();
    } else {
      values[idx] = !values[idx];
    }

    setState(() {});
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
                value: values[0],
                onChanged: (_) {
                  updateValue(0);
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
                  updateValue(1);
                },
                value: values[1],
                label: Container(),
                validator: (bool? value) {
                  if (values[1] == false) {
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
                value: values[2],
                onChanged: (_) {
                  updateValue(2);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('여기 동의하시면 광고 선택 약관어쩌구'),
              Checkbox(
                value: values[3],
                onChanged: (_) {
                  updateValue(3);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
