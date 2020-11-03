import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../providers/authentication_provider.dart';

import '../screens/all_categories_screen.dart';
import '../screens/all_recipes_screen.dart';
import '../screens/favourites_screen.dart';
import '../screens/about_screen.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Consumer<AuthenticationProvider>(
      builder: (context, authData, _) => Drawer(
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
                        'Bake<o>logy.',
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
                            authData.isAuthenticated
                                ? '${authData.email}'
                                : 'Guest',
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
                SizedBox(
                  height: 20,
                ),
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
                      leading: NeumorphicIcon(
                        Icons.home,
                        size: 30,
                        style: NeumorphicStyle(
                          color: Colors.blue,
                          shadowLightColor: Colors.blue[200],
                          shadowDarkColor: Colors.blue[900],
                        ),
                      ),
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
                      leading: NeumorphicIcon(
                        Icons.category_rounded,
                        size: 30,
                        style: NeumorphicStyle(
                          color: Colors.lime[600],
                          shadowLightColor: Colors.lime[200],
                          shadowDarkColor: Colors.lime[800],
                        ),
                      ),
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
                      leading: NeumorphicIcon(
                        Icons.restaurant_menu_rounded,
                        size: 30,
                        style: NeumorphicStyle(
                          color: Colors.teal,
                          shadowLightColor: Colors.teal[200],
                          shadowDarkColor: Colors.teal[900],
                        ),
                      ),
                      title: Text('All Recipes'),
                    ),
                  ),
                ),
                // Divider(),
                if (authData.isAuthenticated)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: NeumorphicButton(
                      provideHapticFeedback: true,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(FavouritesScreen.routeName);
                      },
                      child: ListTile(
                        leading: NeumorphicIcon(
                          Icons.favorite_rounded,
                          size: 30,
                          style: NeumorphicStyle(
                            color: Colors.red,
                            shadowLightColor: Colors.red[200],
                            shadowDarkColor: Colors.red[800],
                          ),
                        ),
                        title: Text('Your Favourites'),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: NeumorphicButton(
                    provideHapticFeedback: true,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/');
                      Provider.of<AuthenticationProvider>(context,
                              listen: false)
                          .logout();
                    },
                    child: ListTile(
                      leading: NeumorphicIcon(
                        authData.isAuthenticated ? Icons.logout : Icons.login,
                        size: 30,
                        style: NeumorphicStyle(
                          color: authData.isAuthenticated
                              ? Colors.amber[800]
                              : Colors.green,
                          shadowLightColor: authData.isAuthenticated
                              ? Colors.amber[200]
                              : Colors.green[200],
                          shadowDarkColor: authData.isAuthenticated
                              ? Colors.amber[900]
                              : Colors.green[900],
                        ),
                      ),
                      title: Text(
                        authData.isAuthenticated ? 'Logout' : 'Login',
                        style: TextStyle(
                            color: authData.isAuthenticated
                                ? Colors.amber[900]
                                : Colors.green),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: NeumorphicButton(
                    provideHapticFeedback: true,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AboutScreen.routeName);
                    },
                    child: ListTile(
                      leading: NeumorphicIcon(
                          Icons.developer_mode_rounded,
                          size: 30,
                          style: NeumorphicStyle(
                            color: Colors.greenAccent[700],
                            shadowLightColor: Colors.greenAccent[200],
                            shadowDarkColor: Colors.green[800],
                          ),
                        ),
                      title: Text('About'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
