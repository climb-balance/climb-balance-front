import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String email;
  late String accessToken;
  late String tokenType;
  Future<void> naverLogin() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;
    setState(() {
      email = res.account.email;
      accessToken = token.accessToken;
      tokenType = token.tokenType;
    });
    debugPrint(email);
  }

  Future<void> naverLogout() async {
    NaverLoginResult res = await FlutterNaverLogin.logOut();
    setState(() {
      email = '';
      accessToken = '';
      tokenType = '';
    });
    debugPrint(email);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('naver'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                naverLogin();
              },
              child: Text('naver login'),
            ),
            TextButton(
              onPressed: () {},
              child: TextButton(
                onPressed: () {
                  naverLogout();
                },
                child: Text('naver logout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
