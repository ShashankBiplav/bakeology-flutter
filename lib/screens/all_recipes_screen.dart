import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';

import '../widgets/recipe_grid_item.dart';
import '../widgets/navigation_drawer.dart';

class AllRecipesScreen extends StatelessWidget {
  static const routeName = '/all-recipes-screen';
  @override
  Widget build(BuildContext context) {
    final recipeData = Provider.of<RecipeProvider>(context);
    final fetchedRecipes = recipeData.recipes;
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'All Recipes',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
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
      drawer: NavigationDrawer(),
    );
  }
}
