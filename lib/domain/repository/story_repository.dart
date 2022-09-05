import '../../data/data_source/result.dart';
import '../model/story.dart';

abstract class StoryRepository {
  Future<Result<void>> createStory({
    required Story story,
    required String videoPath,
    required double start,
    required double end,
  });

  Future<Result<Story>> getRecommendStory();

  Future<Result<List<Story>>> getStories();

  Future<Result<String>> getStoryThumbnailPathById(int storyId);

  String getStoryVideoPathById(int storyId, {bool isAi = false});

  Future<Result<Story>> getStoryById(int storyId);

  Future<void> updateStory(Story story);

  Future<void> deleteStory(int storyId);

  Future<Result<int>> likeStory();

  Future<Result<void>> putAiFeedback(int storyId);
}
