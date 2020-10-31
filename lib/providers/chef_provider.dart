import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/chef.dart';
import '../models/recipe.dart';

class ChefProvider with ChangeNotifier {
  Chef _chef;
  List<Recipe> _chefRecipes;

  Chef get chef {
    return _chef;
  }

  List<Recipe> get chefRecipes {
    return _chefRecipes;
  }

  Future<Chef> fetchAndSetChef({String chefId}) async {
    final url =
        'https://bakeology-alpha-stage.herokuapp.com/user//chef-details/$chefId';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return null;
      }
      final Chef fetchedChef = null;
      final List<Recipe> loadedRecipes = [];
      extractedData["chef"]["recipes"].forEach((recipeData) {
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
      _chef = Chef( 
        id: extractedData["chef"]["_id"],
        name: extractedData["chef"]["name"],
        email: extractedData["chef"]["email"],
        isApproved: extractedData["chef"]["status"],
        profileImageUrl: extractedData["chef"]["profileImageUrl"],
        status: extractedData["chef"]["status"],
       );
      _chefRecipes = loadedRecipes;
      _chef = fetchedChef;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
