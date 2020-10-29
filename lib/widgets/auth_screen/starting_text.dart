import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class StartingText extends StatelessWidget {
  final double height;
  final double width;
  final bool isPortrait;
  StartingText({
    @required this.isPortrait,
    @required this.height,
    @required this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(width * 0.07, height * 0.15, 0.0, 0.0),
          child: NeumorphicText(
            'Hello',
            style: NeumorphicStyle(depth: 4, intensity: 1, color: Colors.grey),
            textStyle: NeumorphicTextStyle(
                fontSize: 70,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold 
                ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(width * 0.07, isPortrait? height * 0.22 : height*0.3, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: NeumorphicText(
                  'There',
                  style: NeumorphicStyle(depth: 4, intensity: 1, color: Colors.black54),
                  textStyle: NeumorphicTextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 90.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                child: NeumorphicText(
                  '.',
                  style: NeumorphicStyle(
                      depth: 10, color: Theme.of(context).accentColor),
                  textStyle: NeumorphicTextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 90.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
