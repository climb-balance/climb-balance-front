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

class LocationSelectorNotifier extends StateNotifier<List<LocationSelector>> {
  LocationSelectorNotifier() : super([]);
  List<LocationSelector> filteredLocationSelector = [];

  void _loadLocationDatas() {
    state = locationData;
    filteredLocationSelector = locationData;
  }

  LocationSelector getLocationSelector(int idx) {
    return state[idx + 1];
  }

  get getFilteredLocationSelector => filteredLocationSelector;

  void updateFilteredLocationSelector(String query) {
    filteredLocationSelector =
        state.where((location) => location.name.contains(query)).toList();
  }
}

final locationSelectorProvider = StateNotifierProvider.autoDispose<
    LocationSelectorNotifier, List<LocationSelector>>((_) {
  LocationSelectorNotifier notifier = LocationSelectorNotifier();
  notifier._loadLocationDatas();
  return notifier;
});

class DifficultySelectorNotifier
    extends StateNotifier<List<DifficultySelector>> {
  DifficultySelectorNotifier() : super([]);
  List<DifficultySelector> filteredDifficultySelector = [];

  void _loadDifficultyDatas() {
    state = difficultyData;
    filteredDifficultySelector = difficultyData;
  }

  DifficultySelector getDifficultySelector(int idx) {
    return state[idx + 1];
  }

  void updateFilteredDifficultySelector(String query) {
    filteredDifficultySelector =
        state.where((difficulty) => difficulty.name.contains(query)).toList();
  }

  get getFilteredDifficultySelector => filteredDifficultySelector;
}

final difficultySelectorProvider = StateNotifierProvider.autoDispose<
    DifficultySelectorNotifier, List<DifficultySelector>>((_) {
  DifficultySelectorNotifier notifier = DifficultySelectorNotifier();
  notifier._loadDifficultyDatas();
  return notifier;
});
