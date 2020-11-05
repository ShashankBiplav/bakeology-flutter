import 'package:flutter/material.dart';

class DisplayAvatar extends StatelessWidget {
  final String imageUrl;
  DisplayAvatar({@required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 27,
      backgroundColor: Colors.grey[800],
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white70,
        backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
