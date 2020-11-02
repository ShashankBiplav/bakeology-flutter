import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/recipe_provider.dart';
import '../providers/category_provider.dart';

import '../widgets/recipe_grid_item.dart';

import '../models/recipe.dart';

class CategorizedRecipesScreen extends StatelessWidget {
  static const routeName = '/categorized-recipes-screen';
  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context).settings.arguments as String;
    final category = Provider.of<CategoryProvider>(context, listen: false)
        .findById(categoryId);
    final recipes = Provider.of<RecipeProvider>(context, listen: false).recipes;
    List<Recipe> displayRecipes = List<Recipe>();
    if (category.recipes.isNotEmpty) {
      for (var i = 0; i < category.recipes.length; i++) {
        displayRecipes.add(
            recipes.firstWhere((recipe) => recipe.id == category.recipes[i]));
      }
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: NeumorphicText(
          '${category.title}',
          style: NeumorphicStyle(
            depth: 4,
            intensity: 1,
            color: Colors.grey[850],
          ),
          textStyle: NeumorphicTextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      ),
      body: displayRecipes.isEmpty
          ? SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphicText(
                    'No Recipes added to this category yet!',
                    style: NeumorphicStyle(
                      depth: 4,
                      intensity: 1,
                      color: Colors.grey[850],
                    ),
                    textStyle: NeumorphicTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : SafeArea(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                itemCount: displayRecipes.length,
                itemBuilder: (ctx, i) => RecipeGridItem(
                  recipeId: displayRecipes[i].id,
                  recipeTitle: displayRecipes[i].title,
                  recipeImageUrl: displayRecipes[i].imageUrl,
                  chefName: displayRecipes[i].chefName,
                  chefImageUrl: displayRecipes[i].chefImageUrl,
                  isVegetarian: displayRecipes[i].isVegetarian,
                  duration: displayRecipes[i].duration,
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 9 / 13,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            ),
    );
  }
}
