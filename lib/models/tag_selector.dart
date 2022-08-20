import 'package:flutter/material.dart';

class LocationSelector {
  int id;
  String name;

  LocationSelector({this.id = -1, this.name = ''});
}

class DifficultySelector {
  int id;
  String name;
  Color color;

  DifficultySelector({this.id = -1, this.name = '', required this.color});
}
