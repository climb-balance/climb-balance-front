import 'package:climb_balance/presentation/common/components/text_field.dart';
import 'package:climb_balance/presentation/register/components/sex_picker.dart';
import 'package:climb_balance/presentation/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/avatar_picker.dart';
import 'check_boxes.dart';

class RegisterFormTab extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const RegisterFormTab({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 36,
                ),
                Text(
                  '닉네임',
                  style: theme.textTheme.subtitle2,
                ),
                SizedBox(
                  height: 12,
                ),
                CustomTextInput(
                  onChanged: (value) {
                    ref
                        .read(registerViewModelProvider.notifier)
                        .updateNickname(value);
                    ref
                        .read(registerViewModelProvider.notifier)
                        .validateLast(formKey);
                  },
                  checkValue: (String? value) {
                    if (value == null) {
                      return '입력해주세요';
                    } else if (value.length < 2) {
                      return '2글자 이상 이여야 합니다.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 36,
                ),
                Text(
                  '프로필 사진',
                  style: theme.textTheme.subtitle2,
                ),
                SizedBox(
                  height: 12,
                ),
                AvatarPicker(
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
                SizedBox(
                  height: 36,
                ),
                Text(
                  '성별',
                  style: theme.textTheme.subtitle2,
                ),
                const SexPicker(),
                Text(
                  '자기 소개',
                  style: theme.textTheme.subtitle2,
                ),
                SizedBox(
                  height: 12,
                ),
                CustomTextInput(
                  onChanged: (value) {
                    ref
                        .read(registerViewModelProvider.notifier)
                        .updateDescription(value);
                    ref
                        .read(registerViewModelProvider.notifier)
                        .validateLast(formKey);
                  },
                  checkValue: (String? value) {
                    return null;
                  },
                  maxLines: 3,
                ),
                CheckBoxes(formKey: formKey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
