import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';

import '../widgets/recipe_grid_item.dart';

class AllRecipesScreen extends StatelessWidget {
  static const routeName = '/all-recipes-screen';
  @override
  Widget build(BuildContext context) {
    final recipeData = Provider.of<RecipeProvider>(context);
    final fetchedRecipes = recipeData.recipes;
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
          backgroundColor: Colors.transparent,
      ),
      body: GridView.builder( padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      itemCount: fetchedRecipes.length,
      itemBuilder: (ctx, i) => RecipeGridItem(
        recipeId: fetchedRecipes[i].id,
        recipeTitle: fetchedRecipes[i].title,
        recipeImageUrl: fetchedRecipes[i].imageUrl,
        chefName: fetchedRecipes[i].chefName,
        chefImageUrl: fetchedRecipes[i].chefImageUrl,
        isVegetarian: fetchedRecipes[i].isVegetarian,
        duration: fetchedRecipes[i].duration,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 9 / 13,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      ),
    );
  }
}