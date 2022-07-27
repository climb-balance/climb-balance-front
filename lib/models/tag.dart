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

  Tags.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        difficulty = json['difficulty'],
        success = json['success'],
        videoDate = json['video_date'];

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

class LocationSelection extends TagSelection {
  LocationSelection({super.detail, super.id});
}

class DifficultySelection extends TagSelection {
  DifficultySelection({super.detail, super.id});
}

class TagsSelection {
  List<LocationSelection> locations = [];
  List<DifficultySelection> difficulties = [];

  void updateTagsSelection(
      {required List<LocationSelection> locations,
      required List<DifficultySelection> difficulties}) {
    this.locations = locations;
    this.difficulties = difficulties;
  }
}
