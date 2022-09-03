import 'package:climb_balance/data/data_source/story_server_helper.dart';
import 'package:climb_balance/domain/model/story.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/const/data.dart';
import '../data_source/result.dart';

// TODO move to di
final storyRepositoryImplProvider = Provider<StoryRepositoryImpl>((ref) {
  final server = ref.watch(storyServerHelperProvider);
  return StoryRepositoryImpl(server);
});

class StoryRepositoryImpl implements StoryRepository {
  StoryServerHelper server;

  StoryRepositoryImpl(this.server);

  @override
  Future<Result<void>> createStory(Story story, String videoPath) async {
    return await server.createStory(story, videoPath);
  }

  @override
  Future<Result<Story>> getStoryById(int id) async {
    final result = await server.getStoryById(id);
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
  Future<Result<String>> getStoryThumbnailPathById(int id) async {
    final result = await server.getStoryThumbnailPathById(id);
    return result.when(
      success: (value) => Result.success(value),
      error: (String message) => Result.error(message),
    );
  }

  // TODO this function must be removed
  // this is tmp
  String getStoryThumbnailPath(int id) {
    return '${serverUrl}$serverStoryPath/$id$serverVideoPath?type=thumbnail';
  }

  @override
  Future<Result<List<Story>>> getStories() async {
    final result = await server.getStories();
    return result.when(
      success: (iterable) => Result.success(
          StoryList.fromJson({"story_list": iterable}).storyList),
      error: (message) => Result.error(message),
    );
  }

  @override
  Future<void> updateStory(Story story) {
    // TODO: implement updateStory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteStory(int id) {
    // TODO: implement deleteStory
    throw UnimplementedError();
  }

  @override
  Future<Result<int>> likeStory() {
    // TODO: implement likeStory
    throw UnimplementedError();
  }
}
