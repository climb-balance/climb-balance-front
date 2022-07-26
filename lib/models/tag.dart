class Tag {
  String detail;
  int id;

  Tag({this.detail = "-", this.id = -1});

  String getDetail() {
    return detail;
  }
}

class Location extends Tag {
  Location({super.detail, super.id});
}

class Difficulty extends Tag {
  Difficulty({super.detail, super.id});
}

class Tags {
  List<Location> locations = [];
  List<Difficulty> difficulties = [];

  void updateTags(
      {required List<Location> locations,
      required List<Difficulty> difficulties}) {
    this.locations = locations;
    this.difficulties = difficulties;
  }
}
