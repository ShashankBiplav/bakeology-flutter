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
    Provider.of<RecipeProvider>(context, listen: false).fetchAndSetRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO:change container to custom widget
    final recipeData = Provider.of<RecipeProvider>(context);
    final recipes = recipeData.recipes;
    // print(recipes);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GridView.builder(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
        itemCount: recipes.length,
        itemBuilder: (ctx, i) => Container(
              // height: 100,
              // width: 100,
              color: Colors.blue,
              // child: ListView.builder(
              //   itemCount: recipes[i].steps.length,
              //   itemBuilder: (ctx, index) => ListTile(
              //     title: Text('${index + 1}. ${recipes[i].steps[index]}'),
              //   ),
              // ),
            ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 9 / 13,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ));
  }
}
