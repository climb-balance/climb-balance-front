import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/services/server_request.dart';
import 'package:video_player/video_player.dart';

import '../models/result.dart';
import '../models/story_upload.dart';
import 'server_config.dart';

class ServerService {
  static Future<Result<List<Story>>> getUserStories() async {
    try {
      final preResult = await ServerRequest.get(ServerStoryPath);
      // TODO : 임시로 버그 막음 임 원래 final result = StoryList.fromJson({"storyList": preResult["stories"]});
      final result = StoryList.fromJson({"storyList": preResult});
      return Result.success(result.storyList);
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }

  static Future<Result<String>> getLoginHtml() async {
    try {
      final result = await ServerRequest.get(ServerNaverPath);
      return Result.success(result);
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }

  static Future<Result<bool>> storyUpload(StoryUpload data) async {
    int storyId;
    try {
      final result = await ServerRequest.post(ServerStoryPath, data);
      //TODO: storyId = result['story_id'];
      storyId = result;
    } catch (e) {
      return const Result.error('스토리 업로드 오류');
    }

    try {
      ServerRequest.multiPartUpload(
          '$ServerStoryPath/$storyId$serverVideoPath', data.file!);
    } catch (e) {
      return const Result.error('영상 업로드 오류');
    }
    return const Result.success(true);
  }

  static Future<Result<VideoPlayerController>> storyVideo(int storyId,
      {bool isAi = false}) async {
    try {
      final controller = VideoPlayerController.network(
          '$ServerStoryPath/$storyId$serverVideoPath?type=${isAi ? 'ai' : 'raw'}');
      return Result.success(controller);
    } catch (e) {
      return const Result.error('영상 불러오기 오류');
    }
  }
}
