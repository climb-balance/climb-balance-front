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
                  updateImagePath: (String imagePath) {
                    ref
                        .read(expertRegisterViewModelProvider.notifier)
                        .updateProfilePicture(imagePath);
                  },
                  imagePath: ref.watch(expertRegisterViewModelProvider
                      .select((value) => value.profileImagePath)),
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
