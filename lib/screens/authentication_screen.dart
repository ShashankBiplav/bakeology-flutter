import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../widgets/auth_screen/starting_text.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = '/authentication-screen';
  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
            Container(
                padding: EdgeInsets.only(
                    top: height * 0.05,
                    left: width * 0.09,
                    right: width * 0.09),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: height * 0.01),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: width * 0.04),
                        Neumorphic(
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.convex,
                              border: NeumorphicBorder(
                                color: Color(0x33000000),
                                width: 0.8,
                              ),
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(50)),
                              depth: 10,
                              lightSource: LightSource.topLeft,
                              color: Colors.black45,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: NeumorphicIcon(
                                Icons.arrow_forward_ios_rounded,
                                size: 30,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(height: height*0.025),
                  ],
                )),
            SizedBox(height: height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to bakeology ? ',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
