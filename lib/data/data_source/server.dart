import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../common/const/data.dart';

final serverProvider = Provider<Server>((ref) {
  return Server();
});

class Server {
  // TODO auth change
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accpet': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzbnNfaWQiOjEsImVtYWlsIjoicGluZWRlbHRhQGljbG91ZC5jb20iLCJpYXQiOjE2NjEyMzQ0MzMsImV4cCI6MTY5Mjc5MjAzM30.BilNsIT7wxUTyEL1PK4dSzkjCReg54YgsIqQZyuo0N8',
  };
  final _timeOutDuration = const Duration(
    seconds: 5,
  );

  Future<dynamic> get(String url) async {
    http.Response res = await http
        .get(Uri.parse(serverUrl + url), headers: headers)
        .timeout(_timeOutDuration)
        .catchError((err) => throw err)
        .whenComplete(() {});
    final statusCode = res.statusCode;
    final body = res.bodyBytes;
    if (statusCode < 200 || statusCode >= 400) {
      throw const HttpException('요청 에러');
    }
    return body;
  }

  Future<dynamic> post(String url, dynamic data) async {
    http.Response res = await http
        .post(
          Uri.parse(serverUrl + url),
          body: jsonEncode(data),
          headers: headers,
        )
        .timeout(_timeOutDuration)
        .catchError((err) => throw err)
        .whenComplete(() {});
    final statusCode = res.statusCode;
    final body = res.bodyBytes;
    if (statusCode < 200 || statusCode >= 400) {
      throw const HttpException('요청 에러');
    }
    return body;
  }

  Future<dynamic> put(String url, dynamic data) async {
    http.Response res = await http
        .put(
          Uri.parse(serverUrl + url),
          body: jsonEncode(data),
          headers: headers,
        )
        .timeout(_timeOutDuration)
        .catchError((err) => throw err)
        .whenComplete(() {});
    final statusCode = res.statusCode;
    final body = res.bodyBytes;
    if (statusCode < 200 || statusCode >= 400) {
      throw const HttpException('요청 에러');
    }
    return body;
  }

  Future<dynamic> multiPartUpload(String url, String videoPath) async {
    Uri uri = Uri.parse('${serverUrl}${url}');
    final req = http.MultipartRequest('POST', uri);
    try {
      final multiPartFile = await http.MultipartFile.fromPath('file', videoPath)
          .timeout(const Duration(seconds: 2));
      req.files.add(multiPartFile);
      final res = await req.send();
      final statusCode = res.statusCode;
      if (statusCode < 200 || statusCode >= 400) {
        throw const HttpException('요청 에러');
      }
    } catch (e) {
      rethrow;
    }
  }
}
