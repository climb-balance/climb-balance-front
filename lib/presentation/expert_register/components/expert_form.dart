import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/avatar_picker.dart';
import '../expert_register_view_model.dart';
import 'expert_register_button.dart';
import 'expert_register_text_input.dart';

class ExpertForm extends ConsumerStatefulWidget {
  const ExpertForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ExpertForm> createState() => _ExpertFormState();
}

class _ExpertFormState extends ConsumerState<ExpertForm> {
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
                        .read(expertRegisterViewModelProvider.notifier)
                        .updateProfilePicture(image);
                  },
                  image: ref.watch(expertRegisterViewModelProvider
                      .select((value) => value.tmpImage)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CodeTextInput(),
                    NickNameTextInput(),
                  ],
                ),
              ),
            ],
          ),
          const IntroduceTextInput(),
          ExpertRegisterButton(formKey: _formKey)
        ],
      ),
    );
  }
}
