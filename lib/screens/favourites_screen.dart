import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = '/favourites-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Favourites'),),
        drawer: NavigationDrawer(),
    );
  }
}