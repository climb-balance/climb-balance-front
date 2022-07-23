import 'dart:async';
import 'dart:io';

import 'package:climb_balance/models/tag.dart';
import 'package:climb_balance/providers/asyncStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

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
            difficulty: Difficulty(),
            date: DateTime.now()));

  void setFile({required File file}) {
    state.file = file;
  }

  void setTags(
      {required Location location,
      required Difficulty difficulty,
      required bool success,
      required DateTime date}) {
    state.location = location;
    state.difficulty = difficulty;
    state.success = success;
    state.date = date;
  }

  void setDetail({required String detail}) {
    state.detail = detail;
  }

  void toggleSuccess() {}

  Future<bool> upload() async {
    ref.read(asyncStatusProvider.notifier).toggleLoading();
    Uri uri = Uri.parse('http://169.254.240.38:3000/story/1/video');
    final req = http.MultipartRequest('POST', uri);
    final mulitpartfile =
        await http.MultipartFile.fromPath('file', state.file!.path);

    req.files.add(mulitpartfile);
    final res = await req.send();
    ref.read(asyncStatusProvider.notifier).toggleLoading();
    if (res.statusCode == 200) {
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
