import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../helpers/email_validation_helper.dart';

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
    'email': '',
    'password': '',
  };
  bool _isLoading = false;
  final _passwordController = TextEditingController();
  // function for form submission and valiadtion
  void _submit() {
    if (!_formKey.currentState.validate()) {
      //Invalid
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authenticationMode == AuthenticationMode.LOGIN) {
      //Initiate User Login
    } else {
      //Initiate User Signup
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
              top: widget.height * 0.05,
              left: widget.width * 0.09,
              right: widget.width * 0.09),
          child: Column(
            children: <Widget>[
              TextFormField(
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
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Password too short!';
                  }
                },
                onSaved: (value) {
                  _authData['password'] = value;
                },
              ),
              SizedBox(height: widget.height * 0.01),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: widget.width * 0.04),
                  Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        border: NeumorphicBorder(
                          color: Color(0x33000000),
                          width: 0.8,
                        ),
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(50)),
                        depth: 10,
                        lightSource: LightSource.topLeft,
                        color: Colors.black45,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: NeumorphicIcon(
                          Icons.arrow_forward_ios_rounded,
                          size: 30,
                        ),
                      ))
                ],
              ),
              SizedBox(height: widget.height * 0.025),
            ],
          ),
        ),
        SizedBox(height: widget.height * 0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New to bakeology ? ',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
            ),
            SizedBox(width: 5.0),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: Text(
                'Sign Up',
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
      ],
    );
  }
}
