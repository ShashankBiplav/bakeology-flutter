import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';

class RecipesGrid extends StatefulWidget {
  @override
  _RecipesGridState createState() => _RecipesGridState();
}

class _RecipesGridState extends State<RecipesGrid> {
   @override
  void initState() { 
    Provider.of<RecipeProvider>(context, listen:false).fetchAndSetRecipes();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    //TODO: Attach recipe provider and change container to custom widget 
    final recipeData = Provider.of<RecipeProvider>(context);
    final recipes = recipeData.recipes;
    // print(recipes);
    return GridView.builder(
      padding:const EdgeInsets.all(10),
      itemCount: recipes.length,
      itemBuilder: (ctx, i) => Container(
        height: 10,
        width: 10,
        child: Text(recipes[i].id),
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
