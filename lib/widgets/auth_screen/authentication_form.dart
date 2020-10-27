import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication_provider.dart';

import '../../helpers/email_validation_helper.dart';
import '../../models/http_exception.dart';
import '../../screens/home_screen.dart';

enum AuthenticationMode {
  SIGNUP,
  LOGIN,
}

class AuthenticationForm extends StatefulWidget {
  final height;
  final width;
  AuthenticationForm({
    @required this.height,
    @required this.width,
  });
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthenticationMode _authenticationMode = AuthenticationMode.LOGIN;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  bool _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Authentication Error'),
        content: Text(message),
        actions: [
          NeumorphicButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: NeumorphicStyle(
              color: Colors.grey.withOpacity(0.5),
              shape: NeumorphicShape.convex,
              depth: 3,
              lightSource: LightSource.topLeft,
            ),
            provideHapticFeedback: true,
          ),
        ],
      ),
    );
  }

  // function for form submission and valiadtion
  Future<void> _submit() async {
    print('Submit called');
    print(_authData['name']);
    print(_authData['email']);
    print(_authData['password']);
    if (!_formKey.currentState.validate()) {
      //Invalid
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authenticationMode == AuthenticationMode.LOGIN) {
        //Initiate User Login
        await Provider.of<AuthenticationProvider>(context, listen: false).login(
          email: _authData['email'],
          password: _authData['password'],
        );
      } else {
        //Initiate User Signup
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .signup(
          name: _authData['name'],
          email: _authData['email'],
          password: _authData['password'],
        );
      }
      setState(() { //after successful signup change to login state
        _authenticationMode = AuthenticationMode.LOGIN;
      });
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed! Please try again later.';
      if (error.toString().contains('email doesn\'t exist')) {
        errorMessage = error.toString();
      } else if (error.toString().contains('Wrong Password')) {
        errorMessage = 'Email or Password is incorrect!';
      } else if (error
          .toString()
          .contains('User with this email already exists')) {
        errorMessage = error.toString();
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Authentication Failed! Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  // function to switch AuthenticationMode
  void _switchAuthenticationMode() {
    if (_authenticationMode == AuthenticationMode.LOGIN) {
      setState(() {
        _authenticationMode = AuthenticationMode.SIGNUP;
      });
    } else {
      setState(() {
        _authenticationMode = AuthenticationMode.LOGIN;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: _authenticationMode == AuthenticationMode.LOGIN
                  ? widget.height * 0.05
                  : 0,
              left: widget.width * 0.09,
              right: widget.width * 0.09),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                if (_authenticationMode == AuthenticationMode.SIGNUP)
                  TextFormField(
                    keyboardType: TextInputType.name,
                    cursorColor: Theme.of(context).accentColor,
                    enabled: _authenticationMode == AuthenticationMode.SIGNUP,
                    decoration: InputDecoration(
                      labelText: 'NAME',
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),
                    ),
                    validator: _authenticationMode == AuthenticationMode.SIGNUP
                        ? (value) {
                            if (value.isEmpty) {
                              return 'Enter your name!';
                            }
                          }
                        : null,
                    onSaved: (value) {
                      _authData['name'] = value;
                    },
                  ),
                SizedBox(height: widget.height * 0.025),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Theme.of(context).accentColor,
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                    ),
                  ),
                  validator: (value) {
                    return validateEmail(value); // helper function
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                SizedBox(height: widget.height * 0.025),
                TextFormField(
                  cursorColor: Theme.of(context).accentColor,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                SizedBox(height: widget.height * 0.025),
                if (_authenticationMode == AuthenticationMode.SIGNUP)
                  TextFormField(
                    cursorColor: Theme.of(context).accentColor,
                    enabled: _authenticationMode == AuthenticationMode.SIGNUP,
                    decoration: InputDecoration(
                      labelText: 'CONFIRM PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: _authenticationMode == AuthenticationMode.SIGNUP
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                if (_authenticationMode == AuthenticationMode.SIGNUP)
                  SizedBox(height: widget.height * 0.01),
                if (_authenticationMode == AuthenticationMode.LOGIN)
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                SizedBox(height: widget.height * 0.05),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _authenticationMode == AuthenticationMode.LOGIN
                            ? 'Login'
                            : 'SignUp',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: widget.width * 0.04),
                      NeumorphicButton(
                        onPressed: () {
                          _submit();
                        },
                        provideHapticFeedback: true,
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          border: NeumorphicBorder(
                            color: Color(0x33000000),
                            width: 0.8,
                          ),
                          boxShape: NeumorphicBoxShape.circle(),
                          depth: 5,
                          lightSource: LightSource.topLeft,
                          color: Colors.black45,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: NeumorphicIcon(
                            Icons.arrow_forward_ios_rounded,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                SizedBox(height: widget.height * 0.025),
              ],
            ),
          ),
        ),
        SizedBox(height: widget.height * 0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _authenticationMode == AuthenticationMode.LOGIN
                  ? 'New to bakeology ? '
                  : 'Already have an account ? ',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
            ),
            SizedBox(width: 5.0),
            InkWell(
              onTap: () {
                _switchAuthenticationMode();
              },
              child: Text(
                _authenticationMode == AuthenticationMode.LOGIN
                    ? 'Sign Up'
                    : 'Login',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).accentColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
        SizedBox(
          height: widget.height * 0.025,
        ),
        NeumorphicButton(
          provideHapticFeedback: true,
          style: NeumorphicStyle(
            shape: NeumorphicShape.convex,
            depth: 3,
            lightSource: LightSource.topLeft,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              HomeScreen.routeName,
            );
          },
          child: Text(
            'Skip',
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).accentColor.withOpacity(0.3),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
        ),
        SizedBox(
          height: widget.height * 0.025,
        ),
      ],
    );
  }
}
