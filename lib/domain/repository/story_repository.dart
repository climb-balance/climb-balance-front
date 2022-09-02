import '../model/story.dart';

abstract class StoryRepository {
  Future<Story> getRecommendStory();
  Future<List<Story>> getStories();
  Future<Story?> getStoryById(int id);

  Future<void> createStory(Story story);

  Future<void> updateStory(Story story);

  // TODO id or story
  Future<void> deleteStory(Story story);
}
