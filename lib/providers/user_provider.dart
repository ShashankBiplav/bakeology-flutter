import 'dart:convert';
import 'dart:io';

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

  Future<Recipe> fetchAndSetFavouriteRecipes() async {
    final url =
        'https://bakeology-alpha-stage.herokuapp.com/user/get-favourites/$userId';
  }
}
