import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/authentication_provider.dart';

import '../screens/all_categories_screen.dart';
import '../screens/all_recipes_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/favourites_screen.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(227, 234, 237, 1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicText(
                      'Welcome to,',
                      style: NeumorphicStyle(
                          depth: 4, intensity: 1, color: Colors.grey),
                      textStyle: NeumorphicTextStyle(
                          fontSize: 22,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    NeumorphicText(
                      'Bakeology.',
                      style: NeumorphicStyle(
                          depth: 4, intensity: 1, color: Colors.grey[700]),
                      textStyle: NeumorphicTextStyle(
                          fontSize: 25,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: isPortrait
                            ? MediaQuery.of(context).size.height * 0.03
                            : MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NeumorphicText(
                          'Shashank',
                          style: NeumorphicStyle(
                            depth: 3,
                            intensity: 1,
                            color: Colors.grey[800],
                          ),
                          textStyle: NeumorphicTextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: NeumorphicButton(
                  provideHapticFeedback: true,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                ),
              ),
              // Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: NeumorphicButton(
                  provideHapticFeedback: true,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AllCategoriesScreen.routeName);
                  },
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text('All categories'),
                  ),
                ),
              ),
              // Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: NeumorphicButton(
                  provideHapticFeedback: true,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AllRecipesScreen.routeName);
                  },
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text('All Recipes'),
                  ),
                ),
              ),
              // Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: NeumorphicButton(
                  provideHapticFeedback: true,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(ForgotPasswordScreen.routeName);
                  },
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Forgot Password'),
                  ),
                ),
              ),
              // Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: NeumorphicButton(
                  provideHapticFeedback: true,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/');
                    Provider.of<AuthenticationProvider>(context, listen: false)
                        .logout();
                  },
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ),
              ),
              // Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
