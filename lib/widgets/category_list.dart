import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './category_list_item.dart';

import '../providers/category_provider.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
        Provider.of<CategoryProvider>(context, listen: false).fetchAndSetCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // final recipeData = Provider.of<CategoryProvider>(context);
    // final fetchedCategories = recipeData.categories;
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: CategoryListItem(),
        ),
      ),
    );
  }
}
