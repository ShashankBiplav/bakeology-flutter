import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/recipe_provider.dart';
import '../providers/chef_provider.dart';

import '../widgets/recipe_details_screen/checked_items_grid.dart';
import '../widgets/recipe_details_screen/checked_items_list.dart';
import '../widgets/recipe_details_screen/heading.dart';
import '../widgets/recipe_details_screen/display_avatar.dart';
import '../widgets/recipe_details_screen/stateful_button.dart';

import '../models/checked_item.dart';

import '../screens/chef_detail_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe-detail-screen';
  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context).settings.arguments as String;
    final loadedRecipe =
        Provider.of<RecipeProvider>(context, listen: false).findById(recipeId);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
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
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
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
                            width: isPortrait ? width * 0.15 : width * 0.2,
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
                Text(
                  '${loadedRecipe.categories}',
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
