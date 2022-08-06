import 'package:climb_balance/utils/storage/token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenType {
  String token;

  TokenType({this.token = ''});

  void clear() {
    token = '';
  }
}

class TokenNotifier extends StateNotifier<TokenType> {
  final ref;

  TokenNotifier({required this.ref}) : super(TokenType());

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
      updateToken(token: value['token'] ?? '');
    });
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, TokenType>((ref) {
  TokenNotifier notifier = TokenNotifier(ref: ref);
  notifier.loadTokenFromStorage();
  return notifier;
});
