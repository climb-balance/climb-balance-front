import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'server_config.dart';

class ServerRequest {
  static const timeOutDuration = Duration(seconds: 2);
  static String ServerUrl = 'http://15.164.163.153:3000';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accpet': 'application/json'
  };

  static Future<dynamic> get(String url) async {
    http.Response res = await http
        .get(Uri.parse(ServerUrl + url), headers: headers)
        .timeout(timeOutDuration)
        .catchError((err) => throw err)
        .whenComplete(() {});
    final statusCode = res.statusCode;
    final body = json.decode(utf8.decode(res.bodyBytes));
    if (statusCode < 200 || statusCode > 400 || body == null) {
      throw const HttpException('요청 에러');
    }
    return body;
  }

  static Future<String> getLoginHtml() async {
    Uri uri = Uri.parse(ServerUrl + ServerNaverPath);
    http.Response res = await http
        .get(uri)
        .timeout(timeOutDuration)
        .catchError((err) => throw err)
        .whenComplete(() => {});
    return res.body;
  }
}
