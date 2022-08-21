import 'package:flutter/material.dart';

abstract class Selector {
  abstract int id;
  abstract String name;
}

class LocationSelector implements Selector {
  @override
  int id;
  @override
  String name;

  LocationSelector({this.id = -1, this.name = ''});
}

class DifficultySelector implements Selector {
  @override
  int id;
  @override
  String name;
  Color color;

  DifficultySelector({this.id = -1, this.name = '', required this.color});
}
