import 'package:climb_balance/common/const/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthViewModel extends StateNotifier<bool> {
  AuthViewModel() : super(false);

  void onNaverLogin(
      BuildContext context, WidgetRef ref, bool toRegister) async {
    context.pushNamed(authNaverRouteName);
  }
// TODO webview load
}

final authViewModelProvider = StateNotifierProvider<AuthViewModel, bool>((ref) {
  final notifier = AuthViewModel();
  return notifier;
});
