import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chef_provider.dart';

class ChefDetailScreen extends StatefulWidget {
  static const routeName = '/chef-detail-screen';

  @override
  _ChefDetailScreenState createState() => _ChefDetailScreenState();
}

class _ChefDetailScreenState extends State<ChefDetailScreen> {
  // bool _isLoading = false;
  // @override
  // void initState() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final chefRecipes  = Provider.of<ChefProvider>(context, listen: false).chefRecipes;
  //       if (chefRecipes != []) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    // print(Provider.of<ChefProvider>(context, listen: false).chefRecipes);
    return Scaffold();
  }
}
