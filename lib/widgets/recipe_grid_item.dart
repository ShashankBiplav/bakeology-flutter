import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../screens/recipe_detail_screen.dart';

class RecipeGridItem extends StatelessWidget {
  final String recipeId;
  final String recipeTitle;
  final String recipeImageUrl;
  final String chefName;
  final String chefImageUrl;
  final bool isVegetarian;
  final int duration;
  RecipeGridItem(
      {@required this.recipeId,
      @required this.recipeTitle,
      @required this.recipeImageUrl,
      @required this.chefName,
      @required this.chefImageUrl,
      @required this.isVegetarian,
      @required this.duration});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return NeumorphicButton(
      padding: EdgeInsets.all(0),
      provideHapticFeedback: true,
      onPressed: () {
        Navigator.of(context).pushNamed(
          RecipeDetailScreen.routeName,
          arguments: recipeId,
        );
      },
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 4,
        intensity: 0.7,
        lightSource: LightSource.topLeft,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(),
          child: FractionallySizedBox(
            heightFactor: 0.92,
            widthFactor: 0.92,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(
                    tag: recipeId,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                      height: isPortrait ? height * 0.19 : height * 0.35,
                      child: Image.network(
                        'https://bakeology-alpha-stage.herokuapp.com/' +
                            recipeImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isPortrait ? height * 0.01 : height * 0.025),
                Text(
                  recipeTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: isPortrait ? height * 0.01 : height * 0.025),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        // width: isPortrait ? width * 0.3 : width * 0.15,
                        color: Colors.blueGrey[100],
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.blueGrey,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white70,
                                backgroundImage: NetworkImage(
                                    'https://bakeology-alpha-stage.herokuapp.com/' +
                                        chefImageUrl),
                              ),
                            ),
                            SizedBox(
                              width: isPortrait ? width * 0.005 : width * 0.008,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: isPortrait ? width * 0.2 : width * 0.1,
                                  child: Text(
                                    chefName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'Inter'),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ),
                                Text(
                                  'Chef',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: isPortrait ? width * 0.01 : width * 0.008,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isPortrait ? width * 0.01 : width * 0.008,
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 18,
                          color: Colors.black38,
                        ),
                        Text(
                          duration.toString() + 'min',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
