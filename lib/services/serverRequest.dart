import 'dart:async';
import 'dart:convert';
import 'package:climb_balance/providers/asyncStatus.dart';
import 'package:http/http.dart' as http;

import '../configs/serverConfig.dart';

class Err {
  String title;
  String content;

  Err({this.title = '알 수 없는 에러', this.content = '으악'});
}

class ServerRequest {
  final ref;
  static const timeOutDuration = Duration(seconds: 2);

  ServerRequest({required this.ref});

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accpet': 'application/json'
  };

  void _toggleLoading() {
    ref.read(asyncStatusProvider.notifier).toggleLoading();
  }

  Future<dynamic> get(String url) async {
    _toggleLoading();
    http.Response res = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(timeOutDuration)
        .catchError((err) => throw errorHandler(err, url))
        .whenComplete(_toggleLoading);
    final statusCode = res.statusCode;
    final body = json.decode(utf8.decode(res.bodyBytes));
    if (statusCode < 200 || statusCode > 400 || body == null) {
      throw errorHandler(NullThrownError, url);
    }
    return body;
  }

  Future<String> getLoginHtml() async {
    Uri uri = Uri.parse(ServerUrl + ServerNaverPath);
    ref.read(asyncStatusProvider.notifier).toggleLoading();
    http.Response res = await http
        .get(uri)
        .timeout(timeOutDuration)
        .catchError((err) => throw errorHandler(err, ServerNaverPath))
        .whenComplete(
            () => ref.read(asyncStatusProvider.notifier).toggleLoading());
    return res.body;
  }

  errorHandler(err, path) {
    if (err == TimeoutException) {
      throw Err(title: '[$path]타임아웃', content: 'content');
    }
  }
}
