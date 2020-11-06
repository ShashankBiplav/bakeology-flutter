import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_drawer.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about-screen';

  _launchNativeApps(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: NeumorphicText(
          'About Developer',
          style: NeumorphicStyle(
            depth: 4,
            intensity: 1,
            color: Colors.grey[850],
          ),
          textStyle: NeumorphicTextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            Neumorphic(
              style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 4,
                  intensity: 1),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Theme.of(context).accentColor,
                child: CircleAvatar(
                  radius: 95,
                  backgroundColor: Colors.white70,
                  backgroundImage:
                      NetworkImage('https://i.ibb.co/n3RzK2L/shashank.jpg'),
                ),
              ),
            ),
            SizedBox(height: 20),
            NeumorphicText(
              'Shashank Biplav',
              style: NeumorphicStyle(
                  depth: 3, intensity: 1, color: Colors.grey[700]),
              textStyle: NeumorphicTextStyle(
                  fontSize: 22,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: _isPortrait
                  ? const EdgeInsets.symmetric(horizontal: 90)
                  : const EdgeInsets.symmetric(horizontal: 250),
              child: Divider(),
            ),
            NeumorphicText(
              'FULL STACK DEVELOPER',
              style: NeumorphicStyle(
                  depth: 3, intensity: 1, color: Colors.grey[600]),
              textStyle: NeumorphicTextStyle(
                  fontSize: 19,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: _isPortrait
                  ? const EdgeInsets.symmetric(horizontal: 70)
                  : const EdgeInsets.symmetric(horizontal: 200),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'I am an aspiring software developer and always a proud Indian 🇮🇳 . I love to build apps and services. \n\n Bakeology is made with lots of love 💜. I hope you loved this app. Its design principles are based on Neumorphism. \n\n I would love to hear your Story and convert your Ideas & Dreams to reality. Leave me a mail or give a call.',
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: NeumorphicButton(
                onPressed: () {
                  _launchNativeApps('tel:+917004026852');
                },
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeumorphicIcon(
                        Icons.wifi_calling_rounded,
                        size: 30,
                        style: NeumorphicStyle(
                          color: Colors.greenAccent[700],
                          shadowLightColor: Colors.greenAccent[100],
                          shadowDarkColor: Colors.green[900],
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        '+91- 700-402-6852',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: NeumorphicButton(
                onPressed: () {
                  _launchNativeApps(
                      'mailto:biplavshashank7@gmail.com?subject=I would like to build an app with you!&body=Hi there,\n I have an awesome app idea,\n\n');
                },
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeumorphicIcon(
                        Icons.email_rounded,
                        size: 30,
                        style: NeumorphicStyle(
                          color: Colors.red[800],
                          shadowLightColor: Colors.red[200],
                          shadowDarkColor: Colors.red[900],
                        ),
                      ),
                      Text(
                        'biplavshashank7@gmail.com',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      drawer: NavigationDrawer(),
    );
  }
}






