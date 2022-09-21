import 'dart:convert';

import 'package:climb_balance/data/repository/user_repository_impl.dart';
import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:climb_balance/presentation/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/const/route_name.dart';
import '../../domain/repository/user_repository.dart';
import 'auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider.autoDispose<AuthViewModel, AuthState>((ref) {
  final notifier = AuthViewModel(
      repository: ref.watch(userRepositoryImplProvider), ref: ref);
  return notifier;
});

class AuthViewModel extends StateNotifier<AuthState> {
  final UserRepository repository;
  final AutoDisposeStateNotifierProviderRef<AuthViewModel, AuthState> ref;

  AuthViewModel({required this.repository, required this.ref})
      : super(const AuthState());

  void onNaverLogin(BuildContext context) async {
    context.pushNamed(authNaverRouteName);
  }

  String getAuthUrl() {
    return repository.getAuthUrl();
  }

  void authComplete(WebViewController controller, BuildContext context) async {
    final link = ref.keepAlive();
    await controller
        .runJavascriptReturningResult(
            "window.document.getElementsByTagName('html')[0].innerText;")
        .then((html) {
      state = AuthState.fromJson(jsonDecode(jsonDecode(html)));
      if (state.needsRegister) {
        context.pop();
        context.pushNamed(registerRouteName);
        ref
            .watch(registerViewModelProvider.notifier)
            .updateAccessToken(state.accessToken);
      } else {
        () => ref
            .read(currentUserProvider.notifier)
            .updateToken(accessToken: state.accessToken);
        // TODO update>?
        context.pop();
        context.go('/');
      }
    }).catchError((_) {
      context.pop();
    });
    link.close();
  }
}