import 'package:climb_balance/data/data_source/story_server_helper.dart';
import 'package:climb_balance/domain/model/story.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storyRepositoryProvider = Provider<StoryRepositoryImpl>((ref) {
  final server = ref.watch(storyServerHelperProvider);
  return StoryRepositoryImpl(server);
});

class StoryRepositoryImpl implements StoryRepository {
  StoryServerHelper server;

  StoryRepositoryImpl(this.server);

  @override
  Future<void> createStory(Story story, String videoPath) async {
    await server.createStory(story, videoPath);
  }

  @override
  Future<void> deleteStory(Story story) {
    // TODO: implement deleteStory
    throw UnimplementedError();
  }

  @override
  Future<Story?> getStoryById(int id) {
    // TODO: implement getStoryById
    throw UnimplementedError();
  }

  @override
  Future<void> updateStory(Story story) {
    // TODO: implement updateStory
    throw UnimplementedError();
  }

  @override
  Future<Story> getRecommendStory() {
    // TODO: implement getRecommendStory
    throw UnimplementedError();
  }

  @override
  Future<List<Story>> getStories() {
    // TODO: implement getStories
    throw UnimplementedError();
  }
}
