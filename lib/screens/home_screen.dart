import 'package:flutter/material.dart';

import '../widgets/recipes_grid.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: RecipesGrid(),
      ),
    );
  }
}
