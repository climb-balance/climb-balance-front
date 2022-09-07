import 'package:flutter/material.dart';

abstract class Selector {
  int id;
  String name;
  Color? color;

  Selector({this.id = 0, this.name = '', this.color});
}

class LocationSelector extends Selector {
  LocationSelector({super.id = 0, super.name = ''});
}

class DifficultySelector extends Selector {
  DifficultySelector({super.id = 0, super.name = '', required super.color});
}
