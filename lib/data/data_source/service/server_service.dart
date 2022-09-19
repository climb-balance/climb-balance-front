import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../domain/const/server_config.dart';

final serverServiceProvider = Provider<ServerService>((ref) {
  return ServerService();
});

class ServerService {
  Map<String, String> makeHeaders(String? accessToken) {
    final headers = {
      'Content-Type': 'application/json',
      'Accpet': 'application/json',
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  final _timeOutDuration = const Duration(
    seconds: 5,
  );

  Future<dynamic> get({required String url, String? accessToken}) async {
    http.Response res = await http
        .get(Uri.parse(serverUrl + url), headers: makeHeaders(accessToken))
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

  Future<dynamic> post(
      {required String url, required dynamic data, String? accessToken}) async {
    http.Response res = await http
        .post(
          Uri.parse(serverUrl + url),
          body: jsonEncode(data),
          headers: makeHeaders(accessToken),
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

  Future<dynamic> put(
      {required String url, required dynamic data, String? accessToken}) async {
    http.Response res = await http
        .put(
          Uri.parse(serverUrl + url),
          body: jsonEncode(data),
          headers: makeHeaders(accessToken),
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
    Uri uri = Uri.parse('$serverUrl$url');
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
