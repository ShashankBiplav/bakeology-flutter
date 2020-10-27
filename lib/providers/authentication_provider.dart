import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class AuthenticationProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup({String name, String email, String password}) async {
    const url = 'https://bakeology-alpha-stage.herokuapp.com/auth/user/signup';
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

      final statusCode = response.statusCode;
      final responseData = jsonDecode(response.body);
      if (statusCode == 201) {
        print(responseData);
        print(statusCode);
      } else if (statusCode == 401) {
        print('Not Authorized');
        print(responseData);
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> login({String email, String password}) async {
    const url = 'https://bakeology-alpha-stage.herokuapp.com/auth/user/login';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}),
      );
      final statusCode = response.statusCode;
      final responseData = jsonDecode(response.body);
      if (statusCode == 200) {
        print(responseData);
        print(statusCode);
      } else if (statusCode == 401) {
        print('Not Authorized');
        print(responseData);
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      print(error);
      print('catch block called');
      throw error;
    }
  }
}