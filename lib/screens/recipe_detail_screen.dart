import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/recipe_provider.dart';

import '../widgets/recipe_details_screen/checked_items_grid.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe-detail-screen';
  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context).settings.arguments as String;
    final loadedRecipe =
        Provider.of<RecipeProvider>(context, listen: false).findById(recipeId);
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
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
                  'https://bakeology-alpha-stage.herokuapp.com/' +
                      loadedRecipe.imageUrl,
                  color: Colors.black12,
                  colorBlendMode: BlendMode.hardLight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                CheckedItemsGrid(items: loadedRecipe.ingredients, ),
                SizedBox(height: 10),
                Text(
                  '${loadedRecipe.categories}',
                ),
                SizedBox(height: 10),
                Text(
                  '${loadedRecipe.chef}',
                ),
                SizedBox(height: 10),
                Text(
                  '${loadedRecipe.imageUrl}',
                ),
                SizedBox(height: 10),
                Text(
                  '${loadedRecipe.chefImageUrl}',
                ),
                SizedBox(height: 10),
                Text(
                  '${loadedRecipe.duration}',
                ),
                SizedBox(height: 10),
                Text(
                  '${loadedRecipe.ingredients}',
                ),
                SizedBox(height: 1000),
                Text(
                  '${loadedRecipe.categories}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
