import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
        title: NeumorphicText(
          'All Categories',
          style: NeumorphicStyle(
            depth: 4,
            intensity: 1,
            color: Colors.grey[850],
          ),
          textStyle: NeumorphicTextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: AllCategoriesGrid(),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
