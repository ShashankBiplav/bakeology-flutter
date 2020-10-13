import 'package:flutter/material.dart';

class RecipeGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
          child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
        width: 100,
        // color: Colors.amber,
      ),
    );
  }
}