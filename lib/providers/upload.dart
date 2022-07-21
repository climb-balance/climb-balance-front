import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadType {
  double start, end;
  int location, difficulty;
  bool success;
  DateTime date;
  String detail;
  File? file;

  UploadType({
    this.start = -1,
    this.end = -1,
    this.location = -1,
    this.difficulty = -1,
    this.success = false,
    this.detail = '',
    required this.date,
  });
}

class UploadNotifier extends StateNotifier<UploadType> {
  final ref;

  // TODO state 불변으로 만들어야함!!!!!
  UploadNotifier({required this.ref}) : super(UploadType(date: DateTime.now()));

  void setFile({required File file}) {
    state.file = file;
  }

  void setTags(
      {required int location,
      required int difficulty,
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

  Future<bool> upload() {
    // TODO upload
    state.file?.lengthSync();
    return Future(() => true);
  }
}

final uploadProvider = StateNotifierProvider<UploadNotifier, UploadType>((ref) {
  UploadNotifier notifier = UploadNotifier(ref: ref);
  return notifier;
});
