import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String url = 'https://naver.com';

class AuthType {
  String token;
  String type;

  AuthType({this.token = '', this.type = ''});

  void clear() {
    token = '';
    type = '';
  }
}

Future<AuthType> getStoredToken() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  String type = prefs.getString('socialType') ?? '';
  return AuthType(token: token, type: type);
}

Future<void> storeToken({token, type}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  await prefs.setString('socialType', type);
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
      updateToken(token: value.token, type: value.type);
    });
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthType>((ref) {
  AuthNotifier notifier = AuthNotifier();
  notifier.load();
  return notifier;
});

class NaverLogin extends ConsumerStatefulWidget {
  const NaverLogin({Key? key}) : super(key: key);

  @override
  NaverLoginState createState() => NaverLoginState();
}

class NaverLoginState extends ConsumerState<NaverLogin> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> naverLogin() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    //FlutterNaverLogin.refreshAccessTokenWithRefreshToken();
    if (res.status == NaverLoginStatus.error) {
      throw Exception('네이버 소셜 로그인 오류 ${res.errorMessage}.');
    }
    NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;
    ref
        .read(authProvider.notifier)
        .updateToken(token: token.accessToken, type: 'naver');
    debugPrint(token.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return TextButton(
      onPressed: () {
        naverLogin();
      },
      child: Text('${auth.token}'),
    );
  }
}
