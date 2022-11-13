import 'package:climb_balance/data/data_source/story_server_helper.dart';
import 'package:climb_balance/domain/model/story.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:climb_balance/presentation/ai_feedback/models/ai_feedback_state.dart';
import 'package:climb_balance/presentation/story_upload_screens/story_upload_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/common/loading_provider.dart';
import '../../domain/const/server_config.dart';
import '../../domain/model/result.dart';

// TODO move to di
final storyRepositoryImplProvider = Provider<StoryRepositoryImpl>((ref) {
  final server = ref.watch(storyServerHelperProvider);
  return StoryRepositoryImpl(server, ref);
});

class StoryRepositoryImpl implements StoryRepository {
  StoryServerHelper server;
  ProviderRef ref;

  StoryRepositoryImpl(this.server, this.ref);

  @override
  Future<Result<void>> createStory({
    required StoryUploadState storyUpload,
  }) async {
    ref.read(loadingProvider.notifier).openLoading();
    final result = await server.createStory(storyUpload);
    ref.read(loadingProvider.notifier).closeLoading();
    return result;
  }

  @override
  Future<Result<Story>> getStoryById(int storyId) async {
    final result = await server.getStoryById(storyId);
    return result.when(
      success: (data) => Result.success(Story.fromJson(data)),
      error: (message) => Result.error(message),
    );
  }

  @override
  Future<Result<Story>> getRecommendStory() async {
    // TODO: implement getRecommendStory
    throw UnimplementedError();
  }

  @override
  String getStoryVideoPathById(int storyId, {bool isAi = false}) {
    return '$serverUrl$serverStoryPath/$storyId$serverVideoPath/?type=${isAi ? 'ai' : 'raw'}';
  }

  @override
  Future<Result<List<Story>>> getStories() async {
    final result = await server.getStories();
    return result.when(
      success: (iterable) =>
          Result.success(StoryList.fromJson({"storyList": iterable}).storyList),
      error: (message) => Result.error(message),
    );
  }

  @override
  Future<Result<AiFeedbackState>> getStoryAiDetailById(int storyId) async {
    final result = await server.getStoryAiDetailById(storyId);

    return result.when(
      success: (value) => Result.success(AiFeedbackState.fromJson(value)),
      error: (message) => Result.error(message),
    );
  }

  @override
  Future<void> updateStory(Story story) {
    // TODO: implement updateStory
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteStory(int storyId) async {
    final result = await server.deleteStory(storyId);
    return result.when(
      success: (value) {
        return const Result.success(null);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  @override
  Future<Result<int>> likeStory() {
    // TODO: implement likeStory
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> putAiFeedback(int storyId, String pushToken) async {
    final result = await server.putAiFeedback(storyId, pushToken);
    return result.when(
      success: (value) {
        return const Result.success(null);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  @override
  String getStoryVideoUrl({required int storyId, bool isAi = false}) {
    return '$serverUrl$serverStoryPath/$storyId$serverVideoPath?type=${isAi ? 'aimp4' : 'rawmp4'}';
  }
}
