import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class AuthenticationProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuthenticated {
    return token != null; //check from token getter method if token is not null
  }

  String get userId{
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null && _userId != null) {
      return _userId;
    }
    return null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

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
      _token = responseData['token'];
      _userId = responseData['userId'];
      _expiryDate = DateTime.now().add(
        Duration(
          hours: 23,
          minutes: 55,
        ),
      );
      _autoLogout();
      notifyListeners();
    } catch (error) {
      print(error);
      print('catch block called');
      throw error;
    }
  }
  void logout(){
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }
  void _autoLogout() {
    if (_authTimer != null) {
        _authTimer.cancel();
    }
   final timeToExpiry =  _expiryDate.difference(DateTime.now()).inMinutes;
    _authTimer = Timer(Duration(minutes: timeToExpiry), logout);
  }
}
