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
  @override
  Widget build(BuildContext context) {
    bool isAuthenticated =
        Provider.of<AuthenticationProvider>(context, listen: false)
            .isAuthenticated;
    bool isCurrentRecipeFavourite = false;
    if (isAuthenticated) {
      isCurrentRecipeFavourite =
          Provider.of<UserProvider>(context, listen: false)
              .isRecipeFavourite(widget.recipe);
    }
    return Row(
      children: [
        NeumorphicButton(
          onPressed: () {
            if (isAuthenticated) {
              if (isCurrentRecipeFavourite) {
                Provider.of<UserProvider>(context, listen: false)
                    .removeRecipeFromFavourite(widget.recipe)
                    .then((_) => setState(() {
                          isCurrentRecipeFavourite = false;
                        }));
                if (this.mounted) {
                  setState(() {
                    isCurrentRecipeFavourite = true;
                  });
                }
              } else {
                Provider.of<UserProvider>(context, listen: false)
                    .markRecipeAsFavourite(widget.recipe)
                    .then((_) => setState(() {
                          isCurrentRecipeFavourite = true;
                        }));
                if (this.mounted) {
                  setState(() {
                    isCurrentRecipeFavourite = true;
                  });
                }
              }
            } else {
              Navigator.of(context).pushReplacementNamed('/');
            }
          },
          child: Container(
            child: Row(
              children: [
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
