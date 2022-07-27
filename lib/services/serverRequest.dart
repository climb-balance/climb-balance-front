import 'dart:async';
import 'dart:convert';
import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/providers/asyncStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class SERVER_INFO {
  static const String URL = 'http://15.164.163.153:3000';
  static const String NAVER_PATH = '/auth/naver';
  static const String GET_STORY_PATH = '/naver';
}

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

  Future<List<Story>> getStories() async {
    final body = await get(SERVER_INFO.URL + SERVER_INFO.GET_STORY_PATH);
    debugPrint(body["stories"]);
    return body["stories"];
  }

  Future<String> getLoginHtml() async {
    Uri uri = Uri.parse(SERVER_INFO.URL + SERVER_INFO.NAVER_PATH);
    ref.read(asyncStatusProvider.notifier).toggleLoading();
    http.Response res = await http
        .get(uri)
        .timeout(timeOutDuration)
        .catchError((err) => throw errorHandler(err, SERVER_INFO.NAVER_PATH))
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
