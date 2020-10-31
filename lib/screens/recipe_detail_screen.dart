import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/recipe_provider.dart';

import '../widgets/recipe_details_screen/checked_items_grid.dart';
import '../widgets/recipe_details_screen/checked_items_list.dart';

import '../models/checked_item.dart';

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
                CheckedItemsGrid(
                  heading: 'Ingredients',
                  items: loadedRecipe.ingredients
                      .map(
                        (item) => CheckedItem(
                          title: item.toString(),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 10),
                Text(
                  '${loadedRecipe.categories}',
                ),
                SizedBox(height: 10),
                Text(
                  'Chef Name =>${loadedRecipe.chefName}',
                ),
                SizedBox(height: 10),
                Text(
                  'recipe image   ${loadedRecipe.imageUrl}',
                ),
                SizedBox(height: 10),
                Text(
                  'chef image${loadedRecipe.chefImageUrl}',
                ),
                SizedBox(height: 10),
                Text(
                  ' duration   ${loadedRecipe.duration} min',
                ),
                SizedBox(height: 10),
                CheckedItemsList(
                  heading: 'Steps',
                  items: loadedRecipe.steps
                      .map(
                        (item) => CheckedItem(
                          title: item.toString(),
                        ),
                      )
                      .toList(),
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
