import 'package:bakeology/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/recipe_provider.dart';
import '../providers/chef_provider.dart';
import '../providers/category_provider.dart';

import '../widgets/recipe_details_screen/checked_items_grid.dart';
import '../widgets/recipe_details_screen/checked_items_list.dart';
import '../widgets/recipe_details_screen/heading.dart';
import '../widgets/recipe_details_screen/display_avatar.dart';
import '../widgets/recipe_details_screen/stateful_button.dart';
import '../widgets/recipe_details_screen/favourites_button.dart';
import '../widgets/category_list_item.dart';

import '../models/checked_item.dart';

import '../screens/chef_detail_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe-detail-screen';
  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context).settings.arguments as String;
    final loadedRecipe = Provider.of<RecipeProvider>(context, listen: false)
        .findById(recipeId); //load the recipe with its id
    final allCategories = Provider.of<CategoryProvider>(context, listen: false)
        .categories; // all categories of the application

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final loadedRecipeCategories =
        loadedRecipe.categories; //all the categories that belong to this recipe
    List<Category> recipeCategories =
        []; //empty array to create list of all categories that belong to this recipe
    // loop to filter one array
    for (var i = 0; i < loadedRecipeCategories.length; i++) {
      Category category = allCategories
          .firstWhere((element) => element.id == loadedRecipeCategories[i]);
      if (category != null) {
        recipeCategories.add(category);
      } else {
        return null;
      }
    }

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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Heading(text: 'Chef'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Neumorphic(
                            style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.circle(),
                                depth: 2,
                                intensity: 1),
                            child: DisplayAvatar(
                                imageUrl:
                                    'https://bakeology-alpha-stage.herokuapp.com/' +
                                        loadedRecipe.chefImageUrl),
                          ),
                          SizedBox(
                            width: isPortrait ? width * 0.05 : width * 0.05,
                          ),
                          Text(
                            '${loadedRecipe.chefName}',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 19,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: isPortrait ? width * 0.03 : width * 0.15,
                          ),
                          StatefulButton(chefId: loadedRecipe.chef),
                        ],
                      ),
                    ],
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Heading(text: 'Cooking Time'),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 25,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                Text(
                                  '${loadedRecipe.duration} min',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                            FavouritesButton(
                              recipe: loadedRecipe,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Heading(text: 'Categories'),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: height * 0.5,
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          itemCount: loadedRecipe.categories.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (ctx, i) => CategoryListItem(
                            categoryId: recipeCategories[i].id,
                            colorA: recipeCategories[i].colorA,
                            colorB: recipeCategories[i].colorB,
                            iconImageUrl: recipeCategories[i].iconImageUrl,
                            title: recipeCategories[i].title,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
