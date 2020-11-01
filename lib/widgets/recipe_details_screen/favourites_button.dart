import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../models/recipe.dart';

import '../../providers/authentication_provider.dart';
import '../../providers/user_provider.dart';

class FavouritesButton extends StatefulWidget {
  final Recipe recipe;
  FavouritesButton({@required this.recipe});
  @override
  _FavouritesButtonState createState() => _FavouritesButtonState();
}

class _FavouritesButtonState extends State<FavouritesButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = Provider.of<AuthenticationProvider>(context, listen: false).isAuthenticated;
    bool isCurrentRecipeFavourite = false;
    if (isAuthenticated) {
      isCurrentRecipeFavourite = Provider.of<UserProvider>(context, listen: false).isRecipeFavourite(widget.recipe);
      print(isCurrentRecipeFavourite);
    }
    return _isLoading
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: CircularProgressIndicator(),
            ),
          )
        : Row(
            children: [
              NeumorphicButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  if (isAuthenticated) {
                    if (isCurrentRecipeFavourite) {
                      Provider.of<UserProvider>(context, listen: false).removeRecipeFromFavourite(widget.recipe)
                          .then((_) => setState(() {
                                isCurrentRecipeFavourite = false;
                                _isLoading = false;
                              }));
                    } else {
                      Provider.of<UserProvider>(context, listen: false).markRecipeAsFavourite(widget.recipe).then((_) => setState(() {
                                isCurrentRecipeFavourite = true;
                                _isLoading = false;
                              }));
                    }
                  } else {
                    Navigator.of(context).pushReplacementNamed('/');
                  }
                },
                child: Container(
                  child: Row(
                    children: [
                      Text(isCurrentRecipeFavourite
                          ? 'Remove From Favourites'
                          : 'Add to Favourites'),
                      SizedBox(width: 10),
                      Icon(
                        isCurrentRecipeFavourite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: Colors.red[400],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
