import 'package:climb_balance/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthType {
  String token;
  String type;

  AuthType({this.token = '', this.type = ''});

  void clear() {
    token = '';
    type = '';
  }
}

class AuthNotifier extends StateNotifier<AuthType> {
  AuthNotifier() : super(AuthType());

  void updateToken({required String token, required String type}) {
    state = AuthType(token: token, type: type);
    storeToken(token: token, type: type);
  }

  // https://stackoverflow.com/questions/64285037/flutter-riverpod-initialize-with-async-values
  void load() {
    getStoredToken().then((value) {
      debugPrint(value['token']);
      updateToken(token: value['token'] ?? '', type: value['type'] ?? '');
    });
  }

  Future<void> naverLogin() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    if (res.status == NaverLoginStatus.error) {
      throw Exception('네이버 소셜 로그인 오류 ${res.errorMessage}.');
    }
    NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;
    updateToken(token: token.accessToken, type: 'naver');
    debugPrint(token.accessToken);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthType>((ref) {
  AuthNotifier notifier = AuthNotifier();
  notifier.load();
  return notifier;
});
