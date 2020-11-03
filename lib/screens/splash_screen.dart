import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NeumorphicText(
            'Bake<o>logy',
            style: NeumorphicStyle(depth: 4, intensity: 1, color: Colors.blueGrey),
            textStyle: NeumorphicTextStyle(
                fontSize: 45,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold 
                ),
          ),
            SizedBox(height: 20),
            SpinKitCubeGrid(
              color: Theme.of(context).accentColor,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Loading',textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
