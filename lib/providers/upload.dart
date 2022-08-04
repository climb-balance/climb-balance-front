import 'dart:async';
import 'dart:io';
import 'package:climb_balance/models/tag.dart';
import 'package:climb_balance/providers/asyncStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UploadType {
  double start, end;
  Location location;
  Difficulty difficulty;
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
            location: Location(),
            difficulty: Difficulty(color: Colors.black),
            date: DateTime.now()));

  void setFile({required File file}) {
    UploadType newState = state;
    newState.file = file;
    state = newState;
  }

  void setTags(
      {required Location location,
      required Difficulty difficulty,
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
    ref.read(asyncStatusProvider.notifier).toggleLoading();
    Uri uri = Uri.parse('http://192.168.107.189:3000/story/1/video');
    final req = http.MultipartRequest('POST', uri);
    final mulitpartfile =
        await http.MultipartFile.fromPath('file', state.file!.path)
            .timeout(const Duration(seconds: 2))
            .onError((error, stackTrace) {
      ref.read(asyncStatusProvider.notifier).toggleLoading();
      throw error!;
    });

    req.files.add(mulitpartfile);
    final res = await req.send();
    ref.read(asyncStatusProvider.notifier).toggleLoading();
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
