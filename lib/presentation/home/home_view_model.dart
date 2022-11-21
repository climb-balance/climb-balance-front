import 'package:climb_balance/data/repository/user_repository_impl.dart';
import 'package:climb_balance/domain/repository/user_repository.dart';
import 'package:climb_balance/presentation/home/models/home_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/common/current_user_provider.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  HomeViewModel notifier = HomeViewModel(
      repository: ref.watch(userRepositoryImplProvider), ref: ref);
  notifier._init();
  return notifier;
});

class HomeViewModel extends StateNotifier<HomeState> {
  final UserRepository repository;
  final StateNotifierProviderRef<HomeViewModel, HomeState> ref;

  HomeViewModel({required this.repository, required this.ref})
      : super(const HomeState());

  void _init() {
    Future.microtask(() => loadDatas());
  }

  Future<void> loadDatas() async {
    final result = await repository.getMainStatistics(
        ref.watch(currentUserProvider.select((value) => value.accessToken)));
    result.when(
      success: (value) {
        state = value;
      },
      error: (message) {
        debugPrint(message);
      },
    );
  }
}
