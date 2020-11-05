import 'dart:convert';

import '../models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  final String authToken;
  final String userId;

  List<Recipe> _favouriteRecipes = [];

  UserProvider({
    this.authToken,
    this.userId,
  });

  List<Recipe> get favouriteRecipes {
    return [..._favouriteRecipes];
  }

  // ignore: missing_return
  Future<Recipe> fetchAndSetFavouriteRecipes() async {
    final url =
        'https://bakeology-alpha-stage.herokuapp.com/user/get-favourites/$userId';
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData["recipes"].length <= 0) {
        return null;
      }
      final List<Recipe> loadedRecipes = [];
      extractedData["recipes"].forEach((recipeData) {
        loadedRecipes.add(
          Recipe(
              id: recipeData["_id"],
              title: recipeData["title"],
              duration: recipeData["duration"],
              imageUrl: recipeData["imageUrl"],
              affordability: recipeData["affordability"],
              isVegetarian: recipeData["isVegetarian"],
              steps: recipeData["steps"],
              categories: recipeData["categories"],
              chef: recipeData["chef"]["_id"],
              chefName: recipeData["chef"]["name"],
              chefImageUrl: recipeData["chef"]["profileImageUrl"],
              complexity: recipeData["complexity"],
              ingredients: recipeData["ingredients"]),
        );
      });
      _favouriteRecipes = loadedRecipes;
      // print(' fav recipes         ...............${_favouriteRecipes}');
      notifyListeners();
    } catch (error) {
      // print(error);
      throw error;
    }
  }

  Future<void> markRecipeAsFavourite(Recipe recipe) async {
    //status code from server is 200, 404 and 500 also exists
    final List<Recipe> originalFavouriteRecipes = _favouriteRecipes;
    _favouriteRecipes.add(recipe);
    notifyListeners();
    final url =
        'https://bakeology-alpha-stage.herokuapp.com/user/mark-favourite/${recipe.id}';
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print(extractedData);
      if (response.statusCode >= 400) {
        _favouriteRecipes = originalFavouriteRecipes;
      }
    } catch (error) {
      // print(error);
      throw error;
    }
  }

  Future<void> removeRecipeFromFavourite(Recipe recipe) async {
    //success status code is 200, 404 and 500 also exists
    final List<Recipe> originalFavouriteRecipes = _favouriteRecipes;
    _favouriteRecipes.remove(recipe);
    notifyListeners();
    final url =
        'https://bakeology-alpha-stage.herokuapp.com/user/remove-favourite/${recipe.id}';
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      if (response.statusCode >= 400) {
        _favouriteRecipes = originalFavouriteRecipes;
      }
    } catch (error) {
      // print(error);
      throw error;
    }
  }

  //function to fetch a recipe is favourite
  bool isRecipeFavourite(Recipe recipe) {
    Recipe favRecipe;
    if (_favouriteRecipes.length > 0) {
      favRecipe = _favouriteRecipes.firstWhere((rcp) => rcp.id == recipe.id,
          orElse: () => null);
      if (favRecipe != null) {
        return true;
      }
      return false;
    }
    return false;
  }
}
