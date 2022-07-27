import 'package:climb_balance/models/tag.dart';

class Story {
  Tag tag;
  int likes;
  String description;
  String thumbnailPath;
  int comments;
  bool aiAvailable;
  bool expertAvailable;
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
  });
  String getDate() {
    return '${tag.date.year.toString()}-${tag.date.month.toString()}-${tag.date.day.toString()}';
  }
}
