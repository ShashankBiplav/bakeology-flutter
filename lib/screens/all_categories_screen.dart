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
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'All Categories',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        body: AllCategoriesGrid(),
    );
  }
}