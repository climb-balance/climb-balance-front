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

  Future<Result<void>> deleteStory(int storyId) async {
    try {
      final body = await server.delete(url: '$serverStoryPath/$storyId');
      return const Result.success(null);
    } catch (e) {
      return Result.error('스토리 삭제 오류 ${e.toString()}');
    }
  }

  Future<Result<Iterable>> getStoryComments(int storyId) async {
    try {
      final body = await server.get(
          url: '$serverStoryPath/$storyId$serverStoryCommentPath');
      return Result.success(jsonDecode(body));
    } catch (e) {
      return Result.error('스토리 댓글 오류 ${e.toString()}');
    }
  }

  Future<Result<void>> addStoryComment(int storyId, String content) async {
    try {
      final body = await server.post(
        url: '$serverStoryPath/$storyId$serverStoryCommentPath',
        data: {
          'content': content,
        },
        accessToken:
            ref.watch(currentUserProvider.select((value) => value.accessToken)),
      );
      return const Result.success(null);
    } catch (e) {
      return Result.error('스토리 댓글 작성 오류 ${e.toString()}');
    }
  }

  Future<Result<void>> deleteStoryComment(
      {required int storyId, required int commentId}) async {
    try {
      final body = await server.delete(
        url: '$serverStoryPath/$storyId$serverStoryCommentPath/$commentId',
      );
      return const Result.success(null);
    } catch (e) {
      return Result.error('스토리 댓글 삭제 오류 ${e.toString()}');
    }
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
