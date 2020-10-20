import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories {
    return [..._categories];
  }

  Future<Category> fetchAndSetCategories() async {
    var url = 'https://bakeology-alpha-stage.herokuapp.com/user/categories';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return null;
      }
      final List<Category> loadedCategories = [];
      extractedData["categories"].forEach((categoryData) {
        loadedCategories.add(
          Category(
            id: categoryData["_id"],
            title: categoryData["title"],
            colorA: categoryData["colorA"],
            colorB: categoryData["colorB"],
            iconImageUrl: categoryData["iconImageUrl"],
            recipes: categoryData["recipes"],
          ),
        );
      });
      _categories = loadedCategories;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
