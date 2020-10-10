import 'package:flutter/material.dart';

import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './screens/recipe_detail_screen.dart';
import './screens/favourites_screen.dart';
import './screens/chef_detail_screen.dart';
import './screens/categorized_recipes_screen.dart';
import './screens/all_categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakeology',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor:Colors.greenAccent[400],
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        HomeScreen.routeName: (ctx)=> HomeScreen(),
        RecipeDetailScreen.routeName: (ctx)=> RecipeDetailScreen(),
        ChefDetailScreen.routeName: (ctx)=> ChefDetailScreen(),
        CategorizedRecipesScreen.routeName: (ctx)=> CategorizedRecipesScreen(),
        AllCategoriesScreen.routeName : (ctx)=> AllCategoriesScreen(),
        FavouritesScreen.routeName: (ctx)=> FavouritesScreen()
      },
    );
  }
}