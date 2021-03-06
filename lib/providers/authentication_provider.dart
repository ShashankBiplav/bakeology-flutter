import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class AuthenticationProvider with ChangeNotifier {
  String _token;
  String _email;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuthenticated {
    return token != null; //check from token getter method if token is not null
  }

  String get userId {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null &&
        _userId != null) {
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

  String get email {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _email;
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
        // print(responseData);
        print(statusCode);
      } else if (statusCode == 401) {
        // print('Not Authorized');
        // print(responseData);
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
        // print(responseData);
        print(statusCode);
      } else if (statusCode == 401) {
        // print('Not Authorized');
        // print(responseData);
        throw HttpException(responseData['message']);
      }
      _token = responseData['token'];
      _userId = responseData['userId'];
      _email = email;
      _expiryDate = DateTime.now().add(
        Duration(
          hours: 23,
          minutes: 55,
        ),
      );
      _autoLogout();
      notifyListeners();
      //store login data
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'email': _email,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      // print(error);
      // print('catch block called');
      throw error;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    _email = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inMinutes;
    _authTimer = Timer(Duration(minutes: timeToExpiry), logout);
  }

  //autologin method
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _email = extractedUserData['email'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  //send OTP function
  Future<void> sendOTP({String email}) async {
    const url = 'https://bakeology-alpha-stage.herokuapp.com/auth/user/get-otp';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{'email': email}),
      );
      final statusCode = response.statusCode;
      final responseData = jsonDecode(response.body);
      if (statusCode == 200) {
        // print(responseData);
        // print(statusCode);
      } else if (statusCode >= 400) {
        // print('Not Authorized');
        // print(responseData);
        // print(statusCode);
        throw HttpException(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      // print(error);
      // print('catch block called');
      throw error;
    }
  }

  //reset password function
  Future<void> resetPassword(
      {String email, String otp, String newPassword}) async {
    const url =
        'https://bakeology-alpha-stage.herokuapp.com/auth/user/reset-password';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'otp': otp,
          'password': newPassword
        }),
      );
      final statusCode = response.statusCode;
      final responseData = jsonDecode(response.body);
      if (statusCode == 201) {
        // print(responseData);
        print(statusCode);
      } else if (statusCode >= 400) {
        print('Not Authorized');
        // print(responseData);
        throw HttpException(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      // print(error);
      // print('catch block called');
      throw error;
    }
  }
}
