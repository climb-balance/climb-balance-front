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
