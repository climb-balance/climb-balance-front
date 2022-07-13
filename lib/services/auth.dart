import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String URL = 'http://54.180.155.137:3000/auth/naver';

Future<String> getLoginHtml() async {
  Uri uri = Uri.parse(URL + '/auth/naver');
  http.Response res = await http.get(uri);
  debugPrint(res.toString());
  debugPrint(res.statusCode.toString());
  return res.body;
}
