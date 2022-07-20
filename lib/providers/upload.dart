import 'package:climb_balance/utils/token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadType {
  double start, end;
  int location, difficulty;
  bool success;
  DateTime date;
  String detail;

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

  UploadNotifier({required this.ref}) : super(UploadType(date: DateTime.now()));
}

final uploadProvider = StateNotifierProvider<UploadNotifier, UploadType>((ref) {
  UploadNotifier notifier = UploadNotifier(ref: ref);
  return notifier;
});
