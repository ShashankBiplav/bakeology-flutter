import 'package:flutter/material.dart';

class CheckedItem {
  String title;
  bool value;

  CheckedItem({
    @required this.title,
    this.value = false,
  });
}
