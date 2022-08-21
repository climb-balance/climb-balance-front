import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tag_selector.dart';

List<DifficultySelector> difficultyData = [
  DifficultySelector(name: '난이도 정보 없음', color: Colors.white),
  DifficultySelector(id: 0, name: '빨강', color: Colors.red),
  DifficultySelector(id: 2, name: '파랑', color: Colors.blue),
  DifficultySelector(id: 3, name: '초록', color: Colors.green),
  DifficultySelector(id: 4, name: '검정', color: Colors.black),
  DifficultySelector(id: 0, name: '빨강', color: Colors.red),
  DifficultySelector(id: 2, name: '파랑', color: Colors.blue),
  DifficultySelector(id: 3, name: '초록', color: Colors.green),
  DifficultySelector(id: 4, name: '검정', color: Colors.black),
  DifficultySelector(id: 0, name: '빨강', color: Colors.red),
  DifficultySelector(id: 2, name: '파랑', color: Colors.blue),
  DifficultySelector(id: 3, name: '초록', color: Colors.green),
  DifficultySelector(id: 4, name: '검정', color: Colors.black),
];

List<LocationSelector> locationData = [
  LocationSelector(name: '위치 정보 없음'),
  LocationSelector(id: 1, name: '강남 클라이밍파크'),
  LocationSelector(id: 2, name: '신논현 더클라이밍'),
  LocationSelector(id: 3, name: '수원 클라임바운스'),
  LocationSelector(id: 3, name: '이천 클라임바운스'),
  LocationSelector(id: 1, name: '강남 클라이밍파크'),
  LocationSelector(id: 2, name: '신논현 더클라이밍'),
  LocationSelector(id: 3, name: '수원 클라임바운스'),
  LocationSelector(id: 3, name: '이천 클라임바운스'),
  LocationSelector(id: 1, name: '강남 클라이밍파크'),
  LocationSelector(id: 2, name: '신논현 더클라이밍'),
  LocationSelector(id: 3, name: '수원 클라임바운스'),
  LocationSelector(id: 3, name: '이천 클라임바운스'),
  LocationSelector(id: 1, name: '강남 클라이밍파크'),
  LocationSelector(id: 2, name: '신논현 더클라이밍'),
  LocationSelector(id: 3, name: '수원 클라임바운스'),
  LocationSelector(id: 3, name: '이천 클라임바운스'),
];

class SelectorNotifier extends StateNotifier<List<Selector>> {
  final ref;
  List<Selector> _originalData = [];

  SelectorNotifier(this.ref) : super([]);

  void initDatas(List<Selector> datas) {
    _originalData = datas;
    state = datas;
  }

  Selector getSelector(int idx) {
    return _originalData[idx + 1];
  }

  void updateDatas(String query) {
    List<Selector> newData = [];
    for (final data in _originalData) {
      if (data.name.contains(query)) {
        newData.add(data);
      }
    }
    state = newData;
  }
}

final locationSelectorProvider =
    StateNotifierProvider.autoDispose<SelectorNotifier, List<Selector>>((ref) {
  SelectorNotifier notifier = SelectorNotifier(ref);
  notifier.initDatas(locationData);
  return notifier;
});

final difficultySelectorProvider =
    StateNotifierProvider.autoDispose<SelectorNotifier, List<Selector>>((ref) {
  SelectorNotifier notifier = SelectorNotifier(ref);
  notifier.initDatas(difficultyData);
  return notifier;
});
