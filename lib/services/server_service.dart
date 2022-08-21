import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/services/server_request.dart';

import '../models/result.dart';
import '../models/story_upload.dart';
import 'server_config.dart';

class ServerService {
  static Future<Result<List<Story>>> getUserStories() async {
    try {
      final preResult = await ServerRequest.get(ServerStoryPath);
      final result = StoryList.fromJson({"storyList": preResult["stories"]});
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
      storyId = result;
    } catch (e) {
      return Result.error('스토리 업로드 오류');
    }

    try {
      ServerRequest.multiPartUpload('$ServerStoryPath/$storyId', data.file!);
    } catch (e) {
      return Result.error('영상 업로드 오류');
    }
    return Result.success(true);
  }
}
