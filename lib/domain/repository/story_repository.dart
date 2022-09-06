import '../../common/models/result.dart';
import '../../presentation/ai_feedback/ai_feedback_state.dart';
import '../model/story.dart';

abstract class StoryRepository {
  Future<Result<void>> createStory({
    required Story story,
    required String videoPath,
    double? start,
    double? end,
  });

  Future<Result<Story>> getRecommendStory();

  Future<Result<List<Story>>> getStories();

  Future<Result<String>> getStoryThumbnailPathById(int storyId);

  String getStoryVideoPathById(int storyId, {bool isAi = false});

  Future<Result<AiFeedbackState>> getStoryAiDetailById(int storyId);

  Future<Result<Story>> getStoryById(int storyId);

  Future<void> updateStory(Story story);

  Future<void> deleteStory(int storyId);

  Future<Result<int>> likeStory();

  Future<Result<void>> putAiFeedback(int storyId);
}
