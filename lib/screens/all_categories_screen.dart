import 'package:flutter/material.dart';

import '../widgets/all_categories_grid.dart';
import '../widgets/navigation_drawer.dart';

class AllCategoriesScreen extends StatelessWidget {
  static const routeName = '/all-categories-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
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
      body: Container(
        padding: EdgeInsets.only(top:10),
        child: AllCategoriesGrid(),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
