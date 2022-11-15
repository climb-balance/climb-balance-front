import 'package:climb_balance/data/repository/story_repository_impl.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:climb_balance/presentation/community/models/community_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final communityViewModelProvider = StateNotifierProvider.autoDispose<
    CommunityViewModelNotifier, CommunityState>((ref) {
  final notifier = CommunityViewModelNotifier(
    repository: ref.watch(storyRepositoryImplProvider),
    ref: ref,
  );
  notifier.loadDatas();
  return notifier;
});

class CommunityViewModelNotifier extends StateNotifier<CommunityState> {
  final StoryRepository repository;
  final AutoDisposeStateNotifierProviderRef ref;

  CommunityViewModelNotifier({
    required this.repository,
    required this.ref,
  }) : super(const CommunityState());

  void loadDatas({int page = 0}) async {
    final result = await repository.getOtherStories(
      page: 0,
    );
    result.when(
      success: (value) {
        state = state.copyWith(storyIds: [...value, ...state.storyIds]);
      },
      error: (message) {},
    );
  }
}
