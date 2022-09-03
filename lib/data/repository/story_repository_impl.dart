import 'package:climb_balance/data/data_source/story_server_helper.dart';
import 'package:climb_balance/domain/model/story.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data_source/result.dart';

final storyRepositoryProvider = Provider<StoryRepositoryImpl>((ref) {
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
  Future<void> deleteStory(Story story) {
    // TODO: implement deleteStory
    throw UnimplementedError();
  }
}
