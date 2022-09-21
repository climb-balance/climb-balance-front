import 'dart:io';

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
                  updateFile: (File image) {
                    ref
                        .read(registerViewModelProvider.notifier)
                        .updateProfileImage(image.path);
                  },
                  image: ref.watch(
                    registerViewModelProvider
                        .select((value) => File(value.profileImage)),
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('여기 동의하시면 필수 약관어쩌구'),
                    Checkbox(
                      value: false,
                      onChanged: (_) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('여기 동의하시면 선택 약관어쩌구'),
                    Checkbox(
                      value: false,
                      onChanged: (_) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
