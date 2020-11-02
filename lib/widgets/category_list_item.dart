import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../helpers/color_generator.dart';

import '../screens/categorized_recipes_screen.dart';

class CategoryListItem extends StatelessWidget {
  final String categoryId;
  final String colorA;
  final String colorB;
  final String iconImageUrl;
  final String title;
  CategoryListItem(
      {@required this.title,
      @required this.categoryId,
      @required this.colorA,
      @required this.colorB,
      @required this.iconImageUrl});
  @override
  Widget build(BuildContext context) {
    Color colorOne = ColorGenerator(colorA);
    Color colorTwo = ColorGenerator(colorB);
    return NeumorphicButton(
      provideHapticFeedback: true,
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.of(context).pushNamed(CategorizedRecipesScreen.routeName,
            arguments: categoryId);
      },
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 4,
        intensity: 0.7,
        lightSource: LightSource.topLeft,
        // color: Colors.grey
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.3, 1],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [colorOne, colorTwo],
          ),
        ),
        width: 150,
        child: FractionallySizedBox(
          heightFactor: 0.9,
          widthFactor: 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5, top: 5),
                    height: 30,
                    width: 30,
                    child: Image.network(
                        'https://bakeology-alpha-stage.herokuapp.com/$iconImageUrl'),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Text(
                  '$title',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      color: Colors.grey[800]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
