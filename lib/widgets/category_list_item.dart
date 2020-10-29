import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CategoryListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      provideHapticFeedback: true,
      padding: EdgeInsets.all(0),
      onPressed: () {},
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 4,
        intensity: 0.7,
        lightSource: LightSource.topLeft,
        // color: Colors.grey
      ),
      child: Container(
        decoration: BoxDecoration(
            // color: Colors.amber,
            // borderRadius: BorderRadius.all(
            //   Radius.circular(15.0),
            // ),
            ),
        width: 150,
        // color: Colors.amber,
      ),
    );
  }
}
