import 'dart:async';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/onboarding_screen.dart';
import '../screens/splash_screen.dart';
import '../widgets/home_auth_splash_controller.dart';

class OnboardingController extends StatefulWidget {
  @override
  _OnboardingControllerState createState() => _OnboardingControllerState();
}

class _OnboardingControllerState extends State<OnboardingController>
    with AfterLayoutMixin<OnboardingController> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      Navigator.of(context)
          .pushReplacementNamed(HomeAuthSplashController.routeName);
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.routeName);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
