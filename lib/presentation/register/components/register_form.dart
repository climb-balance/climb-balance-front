import 'dart:io';

import 'package:climb_balance/presentation/common/components/text_input.dart';
import 'package:climb_balance/presentation/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/avatar_picker.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          // const IntroduceTextInput(),
          // ExpertRegisterButton(formKey: _formKey)
        ],
      ),
    );
  }
}
