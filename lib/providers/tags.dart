import 'package:climb_balance/models/tag.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List difficultyData = [
  ['-', -1],
  ['빨강', 0],
  ['파랑', 2],
  ['초록', 3],
  ['검정', 4],
];

const List locationData = [
  ['-', -1],
  ['강남 클라이밍파크', 0],
  ['신논현 더클라이밍', 1],
  ['수원 클라임바운스', 2],
  ['이천 클라임바운스', 3],
];

class TagsNotifier extends StateNotifier<Tags> {
  final ref;

  TagsNotifier({required this.ref}) : super(Tags());

  void loadTagsData() {
    // dummy logics
    List<Location> locations = [];
    List<Difficulty> difficulties = [];
    for (List tmp in locationData) {
      String detail = tmp[0];
      int id = tmp[1];
      locations.add(Location(detail: detail, id: id));
    }
    for (List tmp in difficultyData) {
      String detail = tmp[0];
      int id = tmp[1];
      difficulties.add(Difficulty(detail: detail, id: id));
    }
    state.updateTags(locations: locations, difficulties: difficulties);
  }
}

final tagsNotifier = StateNotifierProvider<TagsNotifier, Tags>((ref) {
  TagsNotifier notifier = TagsNotifier(ref: ref);
  return notifier;
});
