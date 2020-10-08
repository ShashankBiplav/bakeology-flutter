import 'package:flutter/foundation.dart';

class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final List<String> ingredients;
  final List<String> categories;
  final List<String> steps;
  final String chef;
  final String complexity;
  final String affordability;
  final String isVegetarian;

  Recipe(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.duration,
      @required this.ingredients,
      @required this.categories,
      @required this.steps,
      @required this.chef,
      @required this.complexity,
      @required this.affordability,
      @required this.isVegetarian});
}
