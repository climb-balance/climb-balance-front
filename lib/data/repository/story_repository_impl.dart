import 'package:climb_balance/data/data_source/story_server_helper.dart';
import 'package:climb_balance/domain/model/story.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:climb_balance/presentation/ai_feedback/models/ai_feedback_state.dart';
import 'package:climb_balance/presentation/story_upload_screens/story_upload_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/const/server_config.dart';
import '../../domain/model/result.dart';

// TODO move to di
final storyRepositoryImplProvider = Provider<StoryRepositoryImpl>((ref) {
  final server = ref.watch(storyServerHelperProvider);
  return StoryRepositoryImpl(server);
});

class StoryRepositoryImpl implements StoryRepository {
  StoryServerHelper server;

  StoryRepositoryImpl(this.server);

  @override
  Future<Result<void>> createStory({
    required StoryUploadState storyUpload,
  }) async {
    return await server.createStory(storyUpload);
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
  Future<Result<String>> getStoryThumbnailPathById(int storyId) async {
    final result = await server.getStoryThumbnailPathById(storyId);
    return result.when(
      success: (value) => Result.success(value),
      error: (String message) => Result.error(message),
    );
  }

  /// TODO this function must be removed
  /// 임시 함수입니다.
  /// 스토리 경로를 만들어서 가져옵니다.
  @override
  String getStoryThumbnailPath(int storyId) {
    return '$serverUrl$serverStoryPath/$storyId$serverVideoPath?type=thumbnail';
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
  Future<void> deleteStory(int storyId) {
    // TODO: implement deleteStory
    throw UnimplementedError();
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
}
