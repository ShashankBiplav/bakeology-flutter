import 'package:bakeology/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../providers/user_provider.dart';
import '../providers/authentication_provider.dart';

import '../widgets/recipe_grid_item.dart';

class RecipesGrid extends StatefulWidget {
  @override
  _RecipesGridState createState() => _RecipesGridState();
}

class _RecipesGridState extends State<RecipesGrid> {
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<RecipeProvider>(context, listen: false)
        .fetchAndSetRecipes()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
      Provider.of<AuthenticationProvider>(context,listen: false).isAuthenticated ? 
      Provider.of<UserProvider>(context, listen: false).fetchAndSetFavouriteRecipes() : null ;
      print(Provider.of<UserProvider>(context, listen: false).fetchAndSetFavouriteRecipes());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeData = Provider.of<RecipeProvider>(context);
    final fetchedRecipes = recipeData.recipes;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
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
          );
  }
}
