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
import './screens/all_recipes_screen.dart';

import './providers/recipe_provider.dart';
import './providers/category_provider.dart';
import './providers/authentication_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => RecipeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryProvider(),
        ),
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (context, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bakeology',
          theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.greenAccent[400],
            fontFamily: 'Poppins',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: authData.isAuthenticated? HomeScreen(): AuthenticationScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            RecipeDetailScreen.routeName: (ctx) => RecipeDetailScreen(),
            ChefDetailScreen.routeName: (ctx) => ChefDetailScreen(),
            CategorizedRecipesScreen.routeName: (ctx) =>
                CategorizedRecipesScreen(),
            AllCategoriesScreen.routeName: (ctx) => AllCategoriesScreen(),
            FavouritesScreen.routeName: (ctx) => FavouritesScreen(),
            AuthenticationScreen.routeName: (ctx) => AuthenticationScreen(),
            AllRecipesScreen.routeName: (ctx) => AllRecipesScreen(),
          },
        ),
      ),
    );
  }
}
