import 'package:flutter/material.dart';

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
  final List<Location> locations;
  final List<Difficulty> difficulties;

  const TagsSelection(
      {this.locations = const [], this.difficulties = const []});
}
