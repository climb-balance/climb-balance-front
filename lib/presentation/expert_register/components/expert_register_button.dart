import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/common/current_user_provider.dart';
import '../../../domain/model/expert_profile.dart';
import '../expert_register_view_model.dart';

class ExpertRegisterButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const ExpertRegisterButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('성공')),
            );

            final expertProfile = ref.watch(expertRegisterViewModelProvider);
            ref
                .read(currentUserProvider.notifier)
                .updateExpertInfo(ExpertProfile(
                  nickname: expertProfile.nickname,
                  description: expertProfile.description,
                ));
            ref.read(expertRegisterViewModelProvider.notifier).clear();
            context.pop();
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('실패')),
          );
        },
        child: Text('등록하기'),
      ),
    );
  }
}
