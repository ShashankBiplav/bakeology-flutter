import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup({String name, String email, String password}) async {
    var url = 'https://bakeology-alpha-stage.herokuapp.com/auth/user/signup';
    try {
      final response = await http.post(
        url, 
        headers: <String, String>{
      'Content-Type': 'application/json',
    },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password
        }),
      );
      print(jsonDecode(response.body));
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
