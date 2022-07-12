import 'package:climb_balance/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TokenType {
  String token;
  String type;

  TokenType({this.token = '', this.type = ''});

  void clear() {
    token = '';
    type = '';
  }
}

class TokenNotifier extends StateNotifier<TokenType> {
  TokenNotifier() : super(TokenType());

  bool isEmpty() {
    return state.token == '';
  }

  void updateToken({required String token, required String type}) {
    state = TokenType(token: token, type: type);
    storeStoredToken(token: token, type: type);
  }

  void clearToken() {
    state = TokenType();
    clearStoredToken();
  }

  // https://stackoverflow.com/questions/64285037/flutter-riverpod-initialize-with-async-values
  void loadTokenFromStorage() {
    getStoredToken().then((value) {
      debugPrint(value['token']);
      updateToken(token: value['token'] ?? '', type: value['type'] ?? '');
    });
  }

  Future<bool> naverLogin() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    if (res.status == NaverLoginStatus.error) {
      throw Exception('네이버 소셜 로그인 오류 ${res.errorMessage}.');
    }
    NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;
    updateToken(token: token.accessToken, type: 'naver');
    debugPrint(token.accessToken);
    // 여기서 서버로 요청 보내서 만약 가입으로 가야하면
    return true;
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, TokenType>((ref) {
  TokenNotifier notifier = TokenNotifier();
  notifier.loadTokenFromStorage();
  return notifier;
});
