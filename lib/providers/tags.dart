import 'package:climb_balance/models/tag.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

List<Difficulty> difficultyData = [
  Difficulty(color: Colors.black),
  Difficulty(id: 0, name: '빨강', color: Colors.red),
  Difficulty(id: 2, name: '파랑', color: Colors.blue),
  Difficulty(id: 3, name: '초록', color: Colors.green),
  Difficulty(id: 4, name: '검정', color: Colors.black),
];

List<Location> locationData = [
  Location(id: 0, name: '-'),
  Location(id: 1, name: '강남 클라이밍파크'),
  Location(id: 2, name: '신논현 더클라이밍'),
  Location(id: 3, name: '수원 클라임바운스'),
  Location(id: 3, name: '이천 클라임바운스'),
];

class TagsNotifier extends StateNotifier<TagsSelection> {
  final ref;

  TagsNotifier({required this.ref}) : super(TagsSelection());

  void loadTagsData() {
    state.updateTagsSelection(
        locations: locationData, difficulties: difficultyData);
  }
}

final tagsNotifier = StateNotifierProvider<TagsNotifier, TagsSelection>((ref) {
  TagsNotifier notifier = TagsNotifier(ref: ref);
  return notifier;
});
