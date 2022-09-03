import 'package:climb_balance/data/data_source/server.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/const/data.dart';
import '../../domain/model/story.dart';
import 'result.dart';

// TODO move to di
final storyServerHelperProvider = Provider<StoryServerHelper>((ref) {
  final server = ref.watch(serverProvider);
  return StoryServerHelper(server);
});

class StoryServerHelper {
  Server server;

  StoryServerHelper(this.server);

  Future<Result<void>> createStory(Story story, String videoPath) async {
    int id;
    try {
      final result = await server.post(serverStoryPath, story);
      id = result['story_id'];
    } catch (e) {
      return const Result.error('스토리 업로드 오류');
    }

    return await uploadVideo(id, videoPath);
  }

  Future<Result<void>> uploadVideo(int id, String videoPath) async {
    try {
      server.multiPartUpload('$serverStoryPath/$id$serverVideoPath', videoPath);
    } catch (e) {
      return const Result.error('영상 업로드 오류');
    }
    return const Result.success(null);
  }

  Future<Result<Map<String, dynamic>>> getStoryById(int id) async {
    try {
      final result = await server.get('$serverStoryPath/$id');
      return Result.success(result);
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }

  Future<Story> getRecommendStory() async {
    // TODO: implement getRecommendStory
    throw UnimplementedError();
  }

  Future<Result<Iterable>> getStories() async {
    try {
      final result = await server.get(serverStoryPath);
      // TODO : 임시로 버그 막음 임 원래 result["stories"]
      return result;
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }

  Future<void> updateStory(Story story) async {
    // TODO: implement updateStory
    throw UnimplementedError();
  }

  Future<void> deleteStory(int id) async {
    // TODO: implement deleteStory
    throw UnimplementedError();
  }
}
