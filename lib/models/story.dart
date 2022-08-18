import 'dart:math';

import 'package:climb_balance/models/tag.dart';

class Story {
  Tags tags;
  int likes;
  String description;
  String thumbnailUrl;
  int comments;
  int uploaderId;
  int aiAvailable;
  int expertAvailable;
  DateTime uploadDate;
  int videoId;

  Story({
    required this.tags,
    required this.likes,
    required this.description,
    required this.comments,
    required this.aiAvailable,
    required this.expertAvailable,
    required this.uploadDate,
    required this.thumbnailUrl,
    required this.uploaderId,
    required this.videoId,
  });

  String getDateString() {
    return tags.getDateString();
  }

  String makeKey() {
    return '${tags.location}/${getDateString()}';
  }

  Story.fromJson(Map<String, dynamic> json)
      : tags = (json['tags'] != null ? Tags.fromJson(json['tags']) : null)!,
        likes = json['likes'],
        description = json['description'],
        comments = json['comments'],
        thumbnailUrl = json['thumbnail_url'],
        uploadDate = DateTime.parse(json['upload_date']),
        aiAvailable = json['ai_available'],
        expertAvailable = json['expert_available'],
        uploaderId = json['uploader_id'],
        videoId = json['video_id'] ?? 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tags'] = tags.toJson();
    data['likes'] = likes;
    data['description'] = description;
    data['comments'] = comments;
    data['thumbnail_url'] = thumbnailUrl;
    data['upload_date'] = uploadDate;
    data['ai_available'] = aiAvailable;
    data['expert_available'] = expertAvailable;
    data['video_id'] = videoId;
    return data;
  }
}

Story getRandomStory() {
  Random random = Random();
  return Story(
    tags: Tags(
      videoDate: DateTime.now(),
      difficulty: random.nextInt(4) - 1,
      location: random.nextInt(4) - 1,
    ),
    likes: random.nextInt(100),
    description: '안녕하세요',
    comments: random.nextInt(100),
    aiAvailable: 0,
    expertAvailable: random.nextInt(3) - 1,
    uploadDate: DateTime.now(),
    thumbnailUrl: 'https://i.imgur.com/IAhL4iA.jpeg',
    uploaderId: 1,
    videoId: random.nextInt(4),
  );
}
