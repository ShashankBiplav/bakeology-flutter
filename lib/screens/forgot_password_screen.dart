import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = '/forgot password-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 234, 237, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: NeumorphicText(
          'Forgot Password ?',
          textStyle:
              NeumorphicTextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          style: NeumorphicStyle(
            depth: 4,
            intensity: 1,
            color: Colors.grey[850],
          ),
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: NeumorphicText(
                'Oops,',
                style:
                    NeumorphicStyle(depth: 4, intensity: 1, color: Colors.grey),
                textStyle: NeumorphicTextStyle(
                    fontSize: 70,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Seems like you forgot your password !',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                keyboardType: TextInputType.name,
                cursorColor: Colors.greenAccent[700],
                decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent[700]),
                  ),
                ),
                validator: null,
                onSaved: (value) {},
              ),
            ),
            SizedBox(height:30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: NeumorphicButton(
                onPressed: () {},
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeumorphicIcon(
                        Icons.mobile_friendly,
                        size: 30,
                        style: NeumorphicStyle(
                          color: Colors.red[800],
                          shadowLightColor: Colors.red[200],
                          shadowDarkColor: Colors.red[900],
                        ),
                      ),
                      Text(
                        'Request OTP',
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
          ],
        ),
      ),
    );
  }
}
