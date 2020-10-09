import 'package:flutter/material.dart';

class RecipesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: Attach recipe provider and change container to custom widget 
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 10,
      itemBuilder: (ctx, i) => Container(
        height: 10,
        width: 10,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9/ 13,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
