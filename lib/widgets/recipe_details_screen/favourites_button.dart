import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../models/recipe.dart';

import '../../providers/authentication_provider.dart';
import '../../providers/user_provider.dart';

class FavouritesButton extends StatefulWidget {
  final Recipe recipe;
  FavouritesButton({
    @required this.recipe
  });
  @override
  _FavouritesButtonState createState() => _FavouritesButtonState();
}

class _FavouritesButtonState extends State<FavouritesButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authData, _) => Row(
        children: [
          NeumorphicButton(
            onPressed: () {
              authData.isAuthenticated ?  Provider.of<UserProvider>(context).markRecipeAsFavourite(widget.recipe.id, widget.recipe) :
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Container(
              child: Row(
                children: [
                  Text('Add to Favourites'),
                  SizedBox(width: 10),
                  Icon(
                    Icons.favorite,
                    color: Colors.red[400],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
