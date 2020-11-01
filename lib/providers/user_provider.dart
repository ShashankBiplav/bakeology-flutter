import 'dart:convert';

import '../models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  final String authToken;
  final String userId;

  UserProvider({
    @required this.authToken,
    @required this.userId,
  });

  List<Recipe> _favouriteRecipes = [];

  List<Recipe> get recipes {
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
      print(extractedData);
      if (extractedData["recipes"]["favourites"].length > 0) {
        return null;
      }
      final List<Recipe> loadedRecipes = [];
      extractedData["recipes"]["favourites"].forEach((recipeData) {
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
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // ignore: todo
  //TODO: Check for optimistic updating here and below functions
  Future<void> markRecipeAsFavourite(String recipeId, Recipe recipe) async {
    //status code from server is 200, 404 and 500 also exists
    final List<Recipe> originalFavouriteRecipes = _favouriteRecipes;
    _favouriteRecipes.add(recipe);
    notifyListeners();
    final url =
        'https://bakeology-alpha-stage.herokuapp.com/user/mark-favourite/$recipeId';
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
      print(error);
      throw error;
    }
  }

  Future<void> removeRecipeFromFavourite(String recipeId) async {
    //success status code is 200, 404 and 500 also exists
    final List<Recipe> originalFavouriteRecipes = _favouriteRecipes;
    final List<Recipe> newRecipesList =
        _favouriteRecipes.where((recipe) => recipe.id != recipeId);
    _favouriteRecipes = newRecipesList;
    notifyListeners();
    final url =
        'https://bakeology-alpha-stage.herokuapp.com/user/remove-favourite/$recipeId';
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
      print(error);
      throw error;
    }
  }
  //function to fetch a product via its id
  bool isRecipeFavourite(String recipeId) {
    return _favouriteRecipes.contains((recipe) => recipe.id == recipeId);
  }
}
