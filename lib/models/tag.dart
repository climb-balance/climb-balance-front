import 'package:flutter/material.dart';

class Tags {
  int location;
  int difficulty;
  bool success;
  DateTime videoDate;

  Tags(
      {this.location = -1,
      this.difficulty = -1,
      this.success = false,
      required this.videoDate});

  String getDateString() {
    return '${videoDate.year}-${videoDate.month < 10 ? "0" + videoDate.month.toString() : videoDate.month}-${videoDate.day < 10 ? "0" + videoDate.day.toString() : videoDate.day}';
  }

  Tags.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        difficulty = json['difficulty'],
        success = json['success'] == 'true',
        videoDate = DateTime.parse(json['video_date']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['difficulty'] = difficulty;
    data['success'] = success;
    data['video_date'] = videoDate;
    return data;
  }
}

class TagSelection {
  String detail;
  int id;

  TagSelection({this.detail = "-", this.id = -1});

  String getDetail() {
    return detail;
  }
}

class Location {
  int id;
  String name;

  Location({this.id = -1, this.name = ''});
}

class Difficulty {
  int id;
  String name;
  Color color;

  Difficulty({this.id = -1, this.name = '', required this.color});
}

@immutable
class TagsSelection {
  List<Location> locations = [];
  List<Difficulty> difficulties = [];

  TagsSelection({this.locations = const [], this.difficulties = const []});
}
