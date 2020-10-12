import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
      width: 180,
      // color: Colors.amber,
    );
  }
}
