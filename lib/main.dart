import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/recipe_detail_screen.dart';
import './screens/favourites_screen.dart';
import './screens/chef_detail_screen.dart';
import './screens/categorized_recipes_screen.dart';
import './screens/all_categories_screen.dart';
import './screens/authentication_screen.dart';
import './screens/all_recipes_screen.dart';
import './screens/forgot_password_screen.dart';
import './screens/about_screen.dart';
import './screens/onboarding_screen.dart';

import './providers/recipe_provider.dart';
import './providers/category_provider.dart';
import './providers/authentication_provider.dart';
import './providers/user_provider.dart';
import './providers/chef_provider.dart';

import './widgets/home_auth_splash_controller.dart';
import './widgets/onboarding_controller.dart';

import './helpers/custom_route.dart';

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
        ChangeNotifierProvider(
          create: (ctx) => ChefProvider(),
        ),
        ChangeNotifierProxyProvider<AuthenticationProvider, UserProvider>(
          create: null,
          update: (ctx, authObject, _) => UserProvider(
            authToken: authObject.token,
            userId: authObject.userId,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bakeology',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blueGrey[300],
          fontFamily: 'Poppins',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          ),
        ),
        home: OnboardingController(),
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
          ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
          AboutScreen.routeName: (ctx) => AboutScreen(),
          OnboardingScreen.routeName: (ctx) => OnboardingScreen(),
          HomeAuthSplashController.routeName: (ctx) =>
              HomeAuthSplashController(),
        },
      ),
    );
  }
}
