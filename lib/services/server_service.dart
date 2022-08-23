import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/services/server_request.dart';
import 'package:video_player/video_player.dart';

import '../models/result.dart';
import '../models/story_upload.dart';
import 'server_config.dart';

List<String> testVideos = [
  'http://15.164.163.153:3000/story/1/video?type=raw',
  'http://15.164.163.153:3000/story/1/video?type=ai',
  'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-abstract-video-of-a-man-with-heads-like-matrushka-32647-large.mp4',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/house-painter-promotion-video-template-design-b0d4f2ba5aa5af51d385d0bbf813c908_screen.mp4?ts=1614933517',
];

class ServerService {
  static Future<Result<List<Story>>> getUserStories() async {
    try {
      final preResult = await ServerRequest.get(ServerStoryPath);
      // TODO : 임시로 버그 막음 임 원래 final result = StoryList.fromJson({"storyList": preResult["stories"]});
      final result = StoryList.fromJson({"story_list": preResult});
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

  static VideoPlayerController tmpStoryVideo(int storyId, {bool isAi = false}) {
    List<String> testVideos = [
      'http://15.164.163.153:3000/story/1/video?type=raw',
      'http://15.164.163.153:3000/story/1/video?type=ai',
      'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
      'https://assets.mixkit.co/videos/preview/mixkit-abstract-video-of-a-man-with-heads-like-matrushka-32647-large.mp4',
      'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/house-painter-promotion-video-template-design-b0d4f2ba5aa5af51d385d0bbf813c908_screen.mp4?ts=1614933517',
    ];
    return VideoPlayerController.network(testVideos[storyId]);
  }
}
