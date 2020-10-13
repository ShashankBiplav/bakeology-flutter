import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe-detail-screen';
  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context).settings.arguments as String;
    final loadedRecipe =
        Provider.of<RecipeProvider>(context, listen: false).findById(recipeId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedRecipe.id),
      ),
      body: Center(
        child: Text(
          loadedRecipe.duration.toString(),
        ),
      ),
    );
  }
}
