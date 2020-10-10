import 'package:flutter/material.dart';

import '../widgets/recipes_grid.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RecipesGrid(),
      // body: Center(
      //   child: Text("Loading..."),
    );
  }
}
