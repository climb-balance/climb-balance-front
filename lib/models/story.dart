import 'dart:math';

import 'package:climb_balance/models/tag.dart';

class Story {
  Tag tag;
  int likes;
  String description;
  String thumbnailPath;
  int comments;
  int uploaderId;
  int aiAvailable;
  int expertAvailable;
  DateTime uploadDate;

  Story({
    required this.tag,
    required this.likes,
    required this.description,
    required this.comments,
    required this.aiAvailable,
    required this.expertAvailable,
    required this.uploadDate,
    required this.thumbnailPath,
    required this.uploaderId,
  });

  String getDate() {
    return '${tag.date.year.toString()}-${tag.date.month.toString()}-${tag.date.day.toString()}';
  }
}

Story getRandomStory() {
  Random random = Random();
  return Story(
    tag: Tag(
      date: DateTime.now(),
      location: random.nextInt(3),
    ),
    likes: random.nextInt(100),
    description: '안녕하세요',
    comments: random.nextInt(100),
    aiAvailable: random.nextInt(3),
    expertAvailable: random.nextInt(3),
    uploadDate: DateTime.now(),
    thumbnailPath: 'https://i.imgur.com/IAhL4iA.jpeg',
    uploaderId: 1,
  );
}
