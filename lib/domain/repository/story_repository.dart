import '../../data/data_source/result.dart';
import '../model/story.dart';

abstract class StoryRepository {
  Future<Result<void>> createStory(Story story, String videoPath);

  Future<Result<Story>> getRecommendStory();

  Future<Result<List<Story>>> getStories();

  Future<Result<String>> getStoryThumbnailPathById(int storyId);

  String getStoryVideoPathById(int storyId, {bool isAi = false});

  Future<Result<Story>> getStoryById(int storyId);

  Future<void> updateStory(Story story);

  Future<Result<int>> likeStory();

  Future<void> deleteStory(int storyId);
}
