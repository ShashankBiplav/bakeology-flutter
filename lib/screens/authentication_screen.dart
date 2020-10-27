import 'package:flutter/material.dart';

import '../widgets/auth_screen/starting_text.dart';
import '../widgets/auth_screen/authentication_form.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = '/authentication-screen';
  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold( 
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
      body: SingleChildScrollView(
        child: Column(
          // main column
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: StartingText(
                //custom widget
                isPortrait: isPortrait,
                height: height,
                width: width,
              ),
            ),
            AuthenticationForm(
              height: height,
              width: width,
            ),
          ],
        ),
      ),
    );
  }
}
