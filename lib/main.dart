import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './screens/recipe_detail_screen.dart';
import './screens/favourites_screen.dart';
import './screens/chef_detail_screen.dart';
import './screens/categorized_recipes_screen.dart';
import './screens/all_categories_screen.dart';
import './screens/authentication_screen.dart';

import './providers/recipe_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx)=> RecipeProvider(),
          child: MaterialApp(
        title: 'Bakeology',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.greenAccent[400],
          fontFamily: 'Poppins',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          RecipeDetailScreen.routeName: (ctx) => RecipeDetailScreen(),
          ChefDetailScreen.routeName: (ctx) => ChefDetailScreen(),
          CategorizedRecipesScreen.routeName: (ctx) => CategorizedRecipesScreen(),
          AllCategoriesScreen.routeName: (ctx) => AllCategoriesScreen(),
          FavouritesScreen.routeName: (ctx) => FavouritesScreen(),
          AuthenticationScreen.routeName: (ctx) => AuthenticationScreen(),
        },
      ),
    );
  }
}
