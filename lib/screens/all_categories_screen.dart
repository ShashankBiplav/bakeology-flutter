import 'package:flutter/material.dart';

import '../widgets/all_categories_grid.dart';

class AllCategoriesScreen extends StatelessWidget {
  static const routeName = '/all-categories-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: AllCategoriesGrid(),
    );
  }
}