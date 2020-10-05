import 'package:flutter/foundation.dart';

class Category {
  final String title;
  final String colorA;
  final String colorB;
  final String iconImageUrl;
  final List<String> recipes;

  Category(
      {@required this.title,
      @required this.colorA,
      @required this.colorB,
      @required this.iconImageUrl,
      @required this.recipes});
}