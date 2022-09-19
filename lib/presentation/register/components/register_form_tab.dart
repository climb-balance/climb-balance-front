import 'dart:io';

import 'package:climb_balance/presentation/common/components/text_input.dart';
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
          Divider(),
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
          Divider(),
          CustomTextInput(
            handleUpdate:
                ref.read(registerViewModelProvider.notifier).updateDescription,
            checkValue: (String? value) {
              return null;
            },
            maxLines: 3,
            label: '자기소개',
          ),
        ],
      ),
    );
  }
}

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
