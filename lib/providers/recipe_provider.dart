import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier{
  List<Recipe> _recipes = [];

  List<Recipe> get recipes{
    return [..._recipes];
  }

  Future<Recipe> fetchAndSetRecipes() async{
    var url = 'http://localhost:3300/user/recipes';
    try {
      final response = await http.get(url);
       final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return null; //TODO: check if we can simply return without 'null'
      }
      final List<Recipe> loadedRecipes = [];
      extractedData["recipes"].forEach((recipeId, recipeData) {
        loadedRecipes.add(
          Recipe(
            id: recipeId,
            title: recipeData['title'],
            duration: recipeData['duration'],
            imageUrl: recipeData['imageUrl'],
            affordability: recipeData['affordability'],
            isVegetarian:recipeData['isVegetarian'],
            steps: recipeData['steps'],
            categories: recipeData['categories'],
            chef: recipeData['chef'],
            complexity: recipeData['complexity'],
            ingredients: recipeData['ingredients']
          ),
        );
      });
      print(extractedData);
      _recipes = loadedRecipes;
      notifyListeners();
    }
    catch (error) {
      print(error);
      throw error;
    }
  }
}
