import '../../presentation/ai_feedback/models/ai_feedback_state.dart';
import '../../presentation/community/models/story_id.dart';
import '../../presentation/story/models/comment.dart';
import '../../presentation/story_upload_screens/story_upload_state.dart';
import '../model/result.dart';
import '../model/story.dart';

abstract class StoryRepository {
  Future<Result<void>> createStory({required StoryUploadState storyUpload});

  Future<Result<Story>> getRecommendStory();

  Future<Result<List<Story>>> getStories();

  String getStoryVideoPathById(int storyId, {bool isAi = false});

  Future<Result<AiFeedbackState>> getStoryAiDetailById(int storyId);

  Future<Result<Story>> getStoryById(int storyId);

  Future<void> updateStory(Story story);

  Future<void> deleteStory(int storyId);

  Future<Result<int>> likeStory();

  Future<Result<void>> putAiFeedback(int storyId, String pushToken);

  Future<Result<List<StoryId>>> getOtherStories({required int page});

  Future<String?> getStoryVideo({
    required int storyId,
    bool isAi = false,
  });

  Future<Result<Comments>> getStoryComments(
    int storyId,
  );

  Future<Result<void>> addComment(
    int storyId,
    String content,
  );

  Future<Result<void>> deleteComment(
      {required int commentId, required int storyId});
}
