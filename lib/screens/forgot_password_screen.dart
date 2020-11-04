import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../providers/authentication_provider.dart';

import '../helpers/email_validation_helper.dart';
import '../models/http_exception.dart';

enum FormMode {
  REQUEST,
  OTP_SENT,
}

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot password-screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  FormMode _formMode = FormMode.REQUEST;
  Map<String, String> _formData = {'email': '', 'otp': '', 'password': ''};
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
    if (!_formKey.currentState.validate()) {
      //Invalid
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formMode == FormMode.REQUEST) {
        //Initiate send OTP
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .sendOTP(
          email: _formData['email'],
        );
      } else {
        //Initiate RESET Password
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .resetPassword(
          email: _formData['email'],
          otp: _formData['name'],
          newPassword: _formData['password'],
        );
      }
      setState(() {
        //after successful reset password to initial state state
        _formMode = FormMode.REQUEST;
      });
    } on HttpException catch (error) {
      var errorMessage = 'Something Went Wrong! Please try again later.';
      if (error.toString().contains('email doesn\'t exist')) {
        errorMessage = error.toString();
      } else if (error.toString().contains('Wrong Password')) {
        errorMessage = 'Email or Password is incorrect!';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Something Went Wrong! Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: NeumorphicText(
          'Forgot Password ?',
          textStyle:
              NeumorphicTextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          style: NeumorphicStyle(
            depth: 4,
            intensity: 1,
            color: Colors.grey[850],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: NeumorphicText(
                  _formMode == FormMode.REQUEST ? 'Oops,' : 'Okay,',
                  style: NeumorphicStyle(
                      depth: 4, intensity: 1, color: Colors.blueGrey),
                  textStyle: NeumorphicTextStyle(
                      fontSize: 70,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  _formMode == FormMode.REQUEST
                      ? 'Seems like you forgot your password !'
                      : 'OTP has been sent to \n${_formData['email']}\n \nEnter OTP and your new Password.',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: _formMode == FormMode.REQUEST ? 30 : 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (_formMode == FormMode.REQUEST) SizedBox(height: 30),
              if (_formMode == FormMode.REQUEST)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.greenAccent[700],
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent[700]),
                      ),
                    ),
                    validator: (value) {
                      return validateEmail(value); // helper function
                    },
                    onSaved: (value) {
                      _formData['email'] = value;
                    },
                  ),
                ),
              if (_formMode == FormMode.REQUEST) SizedBox(height: 30),
              if (_formMode == FormMode.REQUEST)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: NeumorphicButton(
                    onPressed: () {
                      _submit();
                    },
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NeumorphicIcon(
                            Icons.mobile_friendly,
                            size: 30,
                            style: NeumorphicStyle(
                              color: Colors.blue[800],
                              shadowLightColor: Colors.blue[200],
                              shadowDarkColor: Colors.blue[900],
                            ),
                          ),
                          Text(
                            'Request OTP',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 20),
              if (_formMode == FormMode.OTP_SENT)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.greenAccent[700],
                    decoration: InputDecoration(
                      labelText: 'OTP',
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent[700]),
                      ),
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'OTP too short!';
                      }
                    },
                    onSaved: (value) {
                      _formData['otp'] = value;
                    },
                  ),
                ),
              if (_formMode == FormMode.OTP_SENT) SizedBox(height: 30),
              if (_formMode == FormMode.OTP_SENT)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    enabled: _formMode == FormMode.OTP_SENT,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.greenAccent[700],
                    decoration: InputDecoration(
                      labelText: 'NEW PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent[700]),
                      ),
                    ),
                    obscureText: true,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password too short!';
                      }
                    },
                    onSaved: (value) {
                      _formData['password'] = value;
                    },
                  ),
                ),
              if (_formMode == FormMode.OTP_SENT) SizedBox(height: 30),
              if (_formMode == FormMode.OTP_SENT)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    enabled: _formMode == FormMode.OTP_SENT,
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.greenAccent[700],
                    decoration: InputDecoration(
                      labelText: 'CONFIRM PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent[700]),
                      ),
                    ),
                    obscureText: true,
                    validator: _formMode == FormMode.OTP_SENT
                        // ignore: missing_return
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                    onSaved: (value) {},
                  ),
                ),
              if (_formMode == FormMode.OTP_SENT) SizedBox(height: 30),
              if (_formMode == FormMode.OTP_SENT)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: NeumorphicButton(
                    onPressed: () {
                      _submit();
                    },
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NeumorphicIcon(
                            Icons.vpn_key_rounded,
                            size: 30,
                            style: NeumorphicStyle(
                              color: Colors.purple[800],
                              shadowLightColor: Colors.purple[200],
                              shadowDarkColor: Colors.purple[900],
                            ),
                          ),
                          Text(
                            'Change Password',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
