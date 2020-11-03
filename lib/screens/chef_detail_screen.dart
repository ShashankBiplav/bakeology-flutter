import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/chef_provider.dart';

import '../widgets/recipe_details_screen/heading.dart';
import '../widgets/recipe_grid_item.dart';

class ChefDetailScreen extends StatelessWidget {
  static const routeName = '/chef-detail-screen';

  @override
  Widget build(BuildContext context) {
    final chef = Provider.of<ChefProvider>(context, listen: false).chef;
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: NeumorphicText(
          '${chef.name}',
          style: NeumorphicStyle(
            depth: 2,
            intensity: 1,
            color: Colors.grey[850],
          ),
          textStyle: NeumorphicTextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Neumorphic(
                style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 4,
                    intensity: 1),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Theme.of(context).accentColor,
                  child: CircleAvatar(
                    radius: 95,
                    backgroundColor: Colors.white70,
                    backgroundImage: NetworkImage(
                        'https://bakeology-alpha-stage.herokuapp.com/' +
                            chef.profileImageUrl),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Heading(text: 'Status'),
                  ),
                  Row(
                    children: [
                      Icon(
                          chef.isApproved
                              ? Icons.verified_user_rounded
                              : Icons.warning,
                          color:
                              chef.isApproved ? Colors.green[600] : Colors.red),
                      Text(
                        chef.isApproved ? 'Approved' : 'Approval Pending',
                        style: TextStyle(
                            color: chef.isApproved
                                ? Colors.green[600]
                                : Colors.red),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      '${chef.status}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Heading(text: 'My Recipes'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  itemCount: chef.recipes.length,
                  itemBuilder: (ctx, i) => RecipeGridItem(
                    recipeId: chef.recipes[i].id,
                    recipeTitle: chef.recipes[i].title,
                    recipeImageUrl: chef.recipes[i].imageUrl,
                    chefName: chef.recipes[i].chefName,
                    chefImageUrl: chef.recipes[i].chefImageUrl,
                    isVegetarian: chef.recipes[i].isVegetarian,
                    duration: chef.recipes[i].duration,
                  ),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 9 / 13,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
