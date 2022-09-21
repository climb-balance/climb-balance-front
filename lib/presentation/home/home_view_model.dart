import 'package:climb_balance/presentation/home/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  // TODO home repo
  HomeViewModel notifier = HomeViewModel(repository: null);
  notifier._loadDatas();
  return notifier;
});

class HomeViewModel extends StateNotifier<HomeState> {
  final repository;

  HomeViewModel({required this.repository}) : super(const HomeState());

  void _loadDatas() {}
}
