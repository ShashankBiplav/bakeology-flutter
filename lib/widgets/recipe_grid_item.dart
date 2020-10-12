import 'package:flutter/material.dart';

class RecipeGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
      width: 100,
      // color: Colors.amber,
    );
  }
}