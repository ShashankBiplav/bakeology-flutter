import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = '/forgot password-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Text('forgot Password Screen'),
        ),
      ),
    );
  }
}
