import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Heading extends StatelessWidget {
  final String text;
  Heading({@required this.text});
  @override
  Widget build(BuildContext context) {
    return NeumorphicText(
      text,
      style: NeumorphicStyle(depth: 3, intensity: 1, color: Colors.grey),
      textStyle: NeumorphicTextStyle(
          fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
    );
  }
}
