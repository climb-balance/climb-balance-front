import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

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

  static Future<dynamic> post(String url, dynamic data) async {
    http.Response res = await http
        .post(
          Uri.parse(ServerUrl + url),
          body: jsonEncode(data),
          headers: headers,
        )
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

  static Future<dynamic> multiPartUpload(String url, File file) async {
    Uri uri = Uri.parse('http://192.168.107.189:3000/story/1/video');
    final req = http.MultipartRequest('POST', uri);
    try {
      final multiPartFile = await http.MultipartFile.fromPath('file', file.path)
          .timeout(const Duration(seconds: 2));
      req.files.add(multiPartFile);
      final res = await req.send();
      if (res.statusCode < 300) {
        return true;
      } else {
        throw ('d');
      }
    } catch (e) {
      rethrow;
    }
  }
}
