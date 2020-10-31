import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/category_provider.dart';

import '../widgets/category_list_item.dart';

class AllCategoriesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedCategories = Provider.of<CategoryProvider>(context).categories;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      itemCount: loadedCategories.length,
      itemBuilder: (ctx, i) => CategoryListItem(
        categoryId: loadedCategories[i].id,
        colorA: loadedCategories[i].colorA,
        colorB: loadedCategories[i].colorB,
        iconImageUrl: loadedCategories[i].iconImageUrl,
        title: loadedCategories[i].title,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
