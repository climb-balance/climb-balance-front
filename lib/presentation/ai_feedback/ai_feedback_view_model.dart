import 'package:climb_balance/presentation/story/story_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/story_repository_impl.dart';
import '../../domain/model/story.dart';
import '../../domain/repository/story_repository.dart';
import 'models/ai_feedback_state.dart';

final aiFeedbackViewModelProvider = StateNotifierProvider.autoDispose
    .family<AiFeedbackViewModel, AiFeedbackState, int>((ref, storyId) {
  AiFeedbackViewModel notifier = AiFeedbackViewModel(
    ref.watch(storyRepositoryImplProvider),
    ref.watch(storyViewModelProvider(storyId).select((value) => value.story)),
  );
  notifier._loadDatas();
  return notifier;
});

class AiFeedbackViewModel extends StateNotifier<AiFeedbackState> {
  final StoryRepository repository;
  final Story story;

  AiFeedbackViewModel(this.repository, this.story)
      : super(const AiFeedbackState());

  void _loadDatas() async {
    final result = await repository.getStoryAiDetailById(story.storyId);
    result.when(
        success: (value) {
          state = value;
        },
        error: (message) {});
  }

  String getStoryAiVideoPath() {
    return repository.getStoryVideoPathById(story.storyId);
  }
}
