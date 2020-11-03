import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/authentication_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home_screen.dart';
import '../screens/authentication_screen.dart';
import '../screens/splash_screen.dart';

class HomeAuthSplashController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isAuthenticated =
        Provider.of<AuthenticationProvider>(context, listen: false)
            .isAuthenticated;
    return _isAuthenticated
        ? HomeScreen()
        : FutureBuilder(
            future: Provider.of<AuthenticationProvider>(context, listen: false)
                .tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
                authResultSnapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : AuthenticationScreen(),
          );
  }
}
