import 'dart:async';

import 'package:http/http.dart' as http;

class SERVER_INFO {
  static const String URL = 'http://54.180.155.137:3000';
  static const String NAVER_PATH = '/auth/naver';
}

class Err {
  String title;
  String content;

  Err({this.title = '알 수 없는 에러', this.content = '으악'});
}

Future<String> getLoginHtml() async {
  Uri uri = Uri.parse(SERVER_INFO.URL + SERVER_INFO.NAVER_PATH);
  http.Response res = await http
      .get(uri)
      .timeout(const Duration(
        seconds: 1,
      ))
      .catchError((err) => errorHandler(err, SERVER_INFO.NAVER_PATH));
  return res.body;
}

errorHandler(err, path) {
  if (err == TimeoutException) {
    throw Err(title: '[${path}]타임아웃', content: 'content');
  }
}
