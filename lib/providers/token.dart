import 'package:climb_balance/services/api.dart';
import 'package:climb_balance/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenType {
  String token;

  TokenType({this.token = ''});

  void clear() {
    token = '';
  }
}

class TokenNotifier extends StateNotifier<TokenType> {
  TokenNotifier() : super(TokenType());

  bool isEmpty() {
    return state.token == '';
  }

  void updateToken({required String token}) {
    state = TokenType(token: token);
    storeStoredToken(token: token);
  }

  void clearToken() {
    state = TokenType();
    clearStoredToken();
  }

  // https://stackoverflow.com/questions/64285037/flutter-riverpod-initialize-with-async-values
  void loadTokenFromStorage() {
    getStoredToken().then((value) {
      debugPrint(value['token']);
      updateToken(token: value['token'] ?? '');
    });
  }

  Future<String> naverLogin() async {
    String html = await getLoginHtml();
    // 여기서 서버로 요청 보내서 만약 가입으로 가야하면
    return html;
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, TokenType>((ref) {
  TokenNotifier notifier = TokenNotifier();
  notifier.loadTokenFromStorage();
  return notifier;
});
