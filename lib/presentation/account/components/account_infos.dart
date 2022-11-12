import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:climb_balance/presentation/common/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountEmail extends ConsumerWidget {
  const AccountEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(currentUserProvider.select((value) => value.email));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('계정 이메일'),
        Text(email),
      ],
    );
  }
}

class AccountPromotion extends ConsumerWidget {
  const AccountPromotion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promotionCheck =
        ref.watch(currentUserProvider.select((value) => value.promotionCheck));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('광고성 정보 수신 동의'),
        Checkbox(
          value: promotionCheck,
          onChanged: (bool? value) async {
            if (value == null) return;
            if (value == false) {
              final result = await customShowConfirm(
                  context: context,
                  title: '정말 취소 하시겠습니까?',
                  content: '광고성 정보를 통해 클라임 밸런스 서비스 유용한 정보를 받아보실 수 있습니다.');
              if (!result) {
                return;
              }
              ref
                  .read(currentUserProvider.notifier)
                  .updateUserInfo(promotionCheck: true);
              return;
            }
            ref
                .read(currentUserProvider.notifier)
                .updateUserInfo(personalCheck: false);
          },
        ),
      ],
    );
  }
}

class AccountPersonal extends ConsumerWidget {
  const AccountPersonal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalCheck =
        ref.watch(currentUserProvider.select((value) => value.personalCheck));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('개인정보 이용 동의'),
        Checkbox(
          value: personalCheck,
          onChanged: (bool? value) async {
            if (value == null) return;
            if (value == false) {
              final result = await customShowConfirm(
                  context: context,
                  title: '정말 취소 하시겠습니까?',
                  content: '개인정보는 클라임 밸런스 서비스의 퀄리티를 높이기 위해서 꼭 필요합니다.');
              if (!result) {
                return;
              }
              ref
                  .read(currentUserProvider.notifier)
                  .updateUserInfo(personalCheck: true);
              return;
            }
            ref
                .read(currentUserProvider.notifier)
                .updateUserInfo(personalCheck: false);
          },
        ),
      ],
    );
  }
}
