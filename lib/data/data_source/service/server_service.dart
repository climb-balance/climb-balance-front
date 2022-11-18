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
    final body = res.body;
    if (statusCode < 200 || statusCode >= 400) {
      throw HttpException(res.body);
    }
    return body;
  }

  Future<dynamic> delete({required String url, String? accessToken}) async {
    http.Response res = await http
        .delete(Uri.parse(serverUrl + url), headers: makeHeaders(accessToken))
        .timeout(_timeOutDuration)
        .catchError((err) => throw err)
        .whenComplete(() {});
    final statusCode = res.statusCode;
    final body = res.body;
    if (statusCode < 200 || statusCode >= 400) {
      throw HttpException(res.body);
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
    final body = res.body;
    if (statusCode < 200 || statusCode >= 400) {
      throw HttpException(res.body);
    }
    return body;
  }

  Future<dynamic> patch(
      {required String url, required dynamic data, String? accessToken}) async {
    http.Response res = await http
        .patch(
          Uri.parse(serverUrl + url),
          body: jsonEncode(data),
          headers: makeHeaders(accessToken),
        )
        .timeout(_timeOutDuration)
        .catchError((err) => throw err)
        .whenComplete(() {});
    final statusCode = res.statusCode;
    final body = res.body;
    if (statusCode < 200 || statusCode >= 400) {
      throw HttpException(res.body);
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
    final body = res.body;
    if (statusCode < 200 || statusCode >= 400) {
      throw HttpException(res.body);
    }
    return body;
  }

  Future<dynamic> multiPartUpload(String url, String filePath,
      {String fileName = 'file',
      String methodType = 'POST',
      String? accessToken}) async {
    Uri uri = Uri.parse('$serverUrl$url');
    final req = http.MultipartRequest(methodType, uri);
    if (accessToken != null) {
      req.headers['Authorization'] = 'Bearer ${accessToken}';
    }
    try {
      final multiPartFile =
          await http.MultipartFile.fromPath(fileName, filePath)
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

  Future<dynamic> multiPartRegister(
    String url, {
    String fileField = 'file',
    required String? filePath,
    required dynamic data,
  }) async {
    Uri uri = Uri.parse('$serverUrl$url');
    final req = http.MultipartRequest('POST', uri);
    req.headers['Authorization'] = 'Bearer ${data.accessToken}';
    try {
      if (filePath != null) {
        final multiPartFile =
            await http.MultipartFile.fromPath(fileField, filePath)
                .timeout(const Duration(seconds: 2));
        req.files.add(multiPartFile);
      }
      Map<String, dynamic> mapData = {
        'nickname': data.nickname,
        'height': data.height,
        'weight': data.weight,
        'sex': data.sex,
        'description': data.description,
        'promotionCheck': data.promotionCheck,
        'requiredCheck': data.requiredCheck,
        'personalCheck': data.personalCheck,
      };
      req.fields['data'] = jsonEncode(mapData);

      final res = await req.send();
      final statusCode = res.statusCode;
      if (statusCode < 200 || statusCode >= 400) {
        throw HttpException('요청 에러 ${res.reasonPhrase ?? ''}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> healthCheck() async {
    try {
      await get(url: '/ping');
    } catch (e) {
      rethrow;
    }
  }
}
