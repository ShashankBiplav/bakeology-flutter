import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './category_list_item.dart';

import '../providers/category_provider.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<CategoryProvider>(context, listen: false)
        .fetchAndSetCategories()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = Provider.of<CategoryProvider>(context);
    final fetchedCategories = categoryData.categories;
    return _isLoading
        ? Center(
            child: SpinKitWave(
              color: Theme.of(context).accentColor,
              size: 50,
            ),
          )
        : Container(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: fetchedCategories.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: CategoryListItem(
                  categoryId: fetchedCategories[index].id,
                  colorA: fetchedCategories[index].colorA,
                  colorB: fetchedCategories[index].colorB,
                  iconImageUrl: fetchedCategories[index].iconImageUrl,
                  title: fetchedCategories[index].title,
                ),
              ),
            ),
          );
  }
}
