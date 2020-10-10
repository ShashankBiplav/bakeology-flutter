import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';

class RecipesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: Attach recipe provider and change container to custom widget 
    final recipeData = Provider.of<RecipeProvider>(context);
    final recipes = recipeData.recipes;
    return GridView.builder(
      padding:const EdgeInsets.all(10),
      itemCount: recipes.length,
      itemBuilder: (ctx, i) => Container(
        height: 10,
        width: 10,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9/13,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
