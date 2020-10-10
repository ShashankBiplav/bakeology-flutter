import 'package:flutter/material.dart';

import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakeology',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor:Colors.greenAccent[400],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen()
    );
  }
}