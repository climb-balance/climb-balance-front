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
  });

  String getDate() {
    return '${tags.videoDate.year.toString()}-${tags.videoDate.month.toString()}-${tags.videoDate.day.toString()}';
  }

  String makeKey() {
    return '${tags.location}/${getDate()}';
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
        uploaderId = json['uploader_id'];

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
    return data;
  }
}

Story getRandomStory() {
  Random random = Random();
  return Story(
    tags: Tags(
      videoDate: DateTime.now(),
      location: random.nextInt(3),
    ),
    likes: random.nextInt(100),
    description: '안녕하세요',
    comments: random.nextInt(100),
    aiAvailable: random.nextInt(3),
    expertAvailable: random.nextInt(3),
    uploadDate: DateTime.now(),
    thumbnailUrl: 'https://i.imgur.com/IAhL4iA.jpeg',
    uploaderId: 1,
  );
}
