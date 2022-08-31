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
      success: (value) async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NaverWebView(html: value),
          ),
        ).then((res) => toRegisterd
            ? Navigator.pushNamed(context, '/register')
            : Navigator.pop(context));
      },
      error: (error) {},
    );
  }
}

final authProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, bool>((ref) {
  final notifier = AuthNotifier();
  return notifier;
});
