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
      
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedRecipe.title),
              background: Hero(
                tag: loadedRecipe.id,
                child: Image.network(
                  'https://bakeology-alpha-stage.herokuapp.com/'+loadedRecipe.imageUrl,
                  color: Colors.black12,
                  colorBlendMode: BlendMode.hardLight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
