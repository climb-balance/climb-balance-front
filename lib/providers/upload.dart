import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/tag_selector.dart';

class UploadType {
  double start, end;
  LocationSelector location;
  DifficultySelector difficulty;
  bool success;
  DateTime date;
  String detail;
  File? file;

  UploadType({
    this.start = -1,
    this.end = -1,
    required this.location,
    required this.difficulty,
    this.success = false,
    this.detail = '',
    required this.date,
  });

  UploadType.clone(UploadType uploadType)
      : this(
            start: uploadType.start,
            end: uploadType.end,
            location: uploadType.location,
            difficulty: uploadType.difficulty,
            success: uploadType.success,
            detail: uploadType.detail,
            date: uploadType.date);
}

class UploadNotifier extends StateNotifier<UploadType> {
  final ref;

  // TODO state 불변으로 만들어야함!!!!!
  UploadNotifier({required this.ref})
      : super(UploadType(
            location: LocationSelector(),
            difficulty: DifficultySelector(color: Colors.black),
            date: DateTime.now()));

  void setFile({required File file}) {
    UploadType newState = state;
    newState.file = file;
    state = newState;
  }

  void setTags(
      {required LocationSelector location,
      required DifficultySelector difficulty,
      required bool success,
      required DateTime date}) {
    UploadType newState = state;
    newState.location = location;
    newState.difficulty = difficulty;
    newState.success = success;
    newState.date = date;
    state = newState;
  }

  UploadType getState() {
    return state;
  }

  void setDetail({required String detail}) {
    UploadType newState = state;
    newState.detail = detail;
    state = newState;
  }

  void setTrim({required double startPos, required double endPos}) {
    UploadType newState = state;
    newState.start = startPos;
    newState.end = endPos;
    state = newState;
  }

  Future<bool> upload() async {
    Uri uri = Uri.parse('http://192.168.107.189:3000/story/1/video');
    final req = http.MultipartRequest('POST', uri);
    final mulitpartfile =
        await http.MultipartFile.fromPath('file', state.file!.path)
            .timeout(const Duration(seconds: 2))
            .onError((error, stackTrace) {
      throw error!;
    });

    req.files.add(mulitpartfile);
    final res = await req.send();
    if (res.statusCode < 300) {
      return true;
    } else {
      throw UnimplementedError;
    }
  }
}

final uploadProvider = StateNotifierProvider<UploadNotifier, UploadType>((ref) {
  UploadNotifier notifier = UploadNotifier(ref: ref);
  return notifier;
});
