import 'dart:convert';

import 'package:climb_balance/data/data_source/service/server_service.dart';
import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/const/server_config.dart';
import '../../domain/model/result.dart';
import '../../domain/model/story.dart';
import '../../presentation/story_upload_screens/story_upload_state.dart';

// TODO move to di
final storyServerHelperProvider = Provider<StoryServerHelper>((ref) {
  final server = ref.watch(serverServiceProvider);
  return StoryServerHelper(server, ref);
});

class StoryServerHelper {
  final ServerService server;
  final ProviderRef<StoryServerHelper> ref;

  const StoryServerHelper(this.server, this.ref);

  Future<Result<void>> createStory(StoryUploadState storyUpload) async {
    int storyId;
    try {
      final result = await server.post(
        url: serverStoryPath,
        data: storyUpload,
        accessToken:
            ref.watch(currentUserProvider.select((value) => value.accessToken)),
      );
      storyId = jsonDecode(result)['storyId'];
    } catch (e) {
      return Result.error('스토리 업로드 오류. 원인 : ${e.toString()}');
    }

    return await uploadVideo(storyId, storyUpload.videoPath);
  }

  Future<Result<void>> uploadVideo(int storyId, String? videoPath) async {
    try {
      await server.multiPartUpload(
          '$serverStoryPath/$storyId$serverVideoPath', videoPath!);
      return const Result.success(null);
    } catch (e) {
      return Result.error('영상 업로드 오류. 원인 : ${e.toString()}');
    }
  }

  Future<Result<Map<String, dynamic>>> getStoryById(int storyId) async {
    try {
      final result = await server.get(url: '$serverStoryPath/$storyId');
      return Result.success(jsonDecode(result));
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
      final result = await server.get(
          url: serverStoryPath,
          accessToken: ref
              .watch(currentUserProvider.select((value) => value.accessToken)));
      return Result.success(jsonDecode(result));
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }

  Future<Result<String>> getStoryThumbnailPathById(int storyId) async {
    try {
      final result = await server.get(
          url: '$serverStoryPath/$storyId$serverVideoPath?type=thumbnail');

      return Result.success(jsonDecode(result)["url"]);
    } catch (e) {
      return const Result.error('썸네일 불러오기 오류');
    }
  }

  Future<Result<dynamic>> getStoryAiDetailById(int storyId) async {
    try {
      final body = await server.get(
          url: '$serverStoryPath/$storyId$serverVideoPath?type=overlay');
      return Result.success(jsonDecode(body));
    } catch (e) {
      return const Result.error('영상 불러오기 오류');
    }
  }

  Future<void> updateStory(Story story) async {
    // TODO: implement updateStory
    throw UnimplementedError();
  }

  Future<void> deleteStory(int storyId) async {
    // TODO: implement deleteStory
    throw UnimplementedError();
  }

  Future<Result<List<String>>> getCommentById(int storyId) {
    // TODO: implement getCommentById
    throw UnimplementedError();
  }

  Future<Result<int>> likeStory() {
    // TODO: implement likeStory
    throw UnimplementedError();
  }

  Future<Result<void>> putAiFeedback(int storyId, String pushToken) async {
    try {
      final result = await server.put(
        url: '$serverStoryPath/$storyId$serverAiFeedbackPath',
        data: {
          'token': pushToken,
        },
      );
      return const Result.success(null);
    } catch (e) {
      return const Result.error('AI 피드백 요청 오류');
    }
  }
}
