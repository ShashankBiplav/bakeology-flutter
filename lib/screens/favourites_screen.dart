import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/user_provider.dart';

import '../widgets/navigation_drawer.dart';
import '../widgets/recipe_grid_item.dart';
import '../screens/all_recipes_screen.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = '/favourites-screen';
  @override
  Widget build(BuildContext context) {
    final userFavourites = Provider.of<UserProvider>(context).favouriteRecipes;
    final favouritesArrayLength = userFavourites.length;
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: NeumorphicText(
          'Your Favourites',
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
      body: (favouritesArrayLength < 1)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeumorphicText(
                  'No favourites added yet! \n Let\'s add some...',
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: NeumorphicButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AllRecipesScreen.routeName);
                    },
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Let\'s Go',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  itemCount: favouritesArrayLength,
                  itemBuilder: (ctx, i) => RecipeGridItem(
                    recipeId: userFavourites[i].id,
                    recipeTitle: userFavourites[i].title,
                    recipeImageUrl: userFavourites[i].imageUrl,
                    chefName: userFavourites[i].chefName,
                    chefImageUrl: userFavourites[i].chefImageUrl,
                    isVegetarian: userFavourites[i].isVegetarian,
                    duration: userFavourites[i].duration,
                  ),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 9 / 13,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              ),
            ),
      drawer: NavigationDrawer(),
    );
  }
}
