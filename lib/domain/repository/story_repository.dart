import '../../presentation/ai_feedback/ai_feedback_state.dart';
import '../../presentation/story_upload_screens/story_upload_state.dart';
import '../model/result.dart';
import '../model/story.dart';

abstract class StoryRepository {
  Future<Result<void>> createStory({required StoryUploadState storyUpload});

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
