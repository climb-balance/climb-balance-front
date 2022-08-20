import 'package:climb_balance/services/server_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/web_view.dart';

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  void onNaverLogin(
      BuildContext context, WidgetRef ref, bool toRegisterd) async {
    final result = await ServerService.getLoginHtml();
    result.when(
      success: (success) async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NaverWebView(html: success.value),
          ),
        ).then((res) => toRegisterd
            ? Navigator.pushNamed(context, '/register')
            : Navigator.pop(context));
      },
      loading: () {},
      error: (error) {},
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final notifier = AuthNotifier();
  return notifier;
});
