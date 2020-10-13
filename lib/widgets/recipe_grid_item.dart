import 'package:flutter/material.dart';

import '../screens/recipe_detail_screen.dart';

class RecipeGridItem extends StatelessWidget {
  final String recipeId;
  final String recipeTitle;
  final String recipeImageUrl;
  final String chefName;
  final String chefImageUrl;
  final bool isVegetarian;
  RecipeGridItem({
    @required this.recipeId,
    @required this.recipeTitle,
    @required this.recipeImageUrl,
    @required this.chefName,
    @required this.chefImageUrl,
    @required this.isVegetarian,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: () {
                print(recipeId);
                Navigator.of(context).pushNamed(
                  RecipeDetailScreen.routeName,
                  arguments: recipeId,
                );},
              child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
              children: [
                Image.network(
                  'http://192.168.29.31:3300/'+recipeImageUrl,
                  fit: BoxFit.contain,
                ),
                Text(recipeTitle),
                Text(chefName),
                Text(chefImageUrl),
              ],
            ),
        ),
      ),
    );
  }
}
