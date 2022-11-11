import 'package:flutter/material.dart';

abstract class Selector {
  int id;
  String name;
  late List<Color> selectColors;

  Selector({this.id = 0, this.name = '', List<Color>? tagColors}) {
    if (tagColors == null) {
      selectColors = [Colors.transparent, Colors.transparent];
    } else if (tagColors.length == 1) {
      selectColors = [tagColors[0], tagColors[0]];
    } else {
      selectColors = tagColors;
    }
  }
}

class LocationSelector extends Selector {
  String location;

  LocationSelector({super.id = 0, super.name = '', this.location = ''});
}

class DifficultySelector extends Selector {
  DifficultySelector({super.id = 0, super.name = '', required super.tagColors});
}
