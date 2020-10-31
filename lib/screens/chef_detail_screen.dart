import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chef_provider.dart';

class ChefDetailScreen extends StatelessWidget {
  static const routeName = '/chef-detail-screen';

  @override
  Widget build(BuildContext context) {
    print('${Provider.of<ChefProvider>(context, listen: false).chef.email}');
    return Scaffold(
      body: Center(
        child: Text('Loaded'),
      ),
    );
  }
}
