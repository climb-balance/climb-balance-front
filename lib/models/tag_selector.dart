import 'package:flutter/material.dart';

abstract class Selector {
  int id;
  String name;
  Color? color;

  Selector({this.id = -1, this.name = '', this.color});
}

class LocationSelector extends Selector {
  LocationSelector({super.id = -1, super.name = ''});
}

class DifficultySelector extends Selector {
  DifficultySelector({super.id = -1, super.name = '', required super.color});
}
