import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding-screen';
  List<PageViewModel> _getPages() {
    return [
      PageViewModel(
        image: Image.asset("assets/images/be_chef.png"),
        title: "Be a Chef",
        body:
            "Kickstart your cooking journey.\nEnjoy cooking hassle-free. Cooking is a therapy for the heart and soul.",
        footer: NeumorphicText(
          'Welcome Fella',
          style:
              NeumorphicStyle(depth: 3, intensity: 1, color: Colors.grey[700]),
          textStyle: NeumorphicTextStyle(
              fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/browse_recipes.png"),
        title: "Use the app",
        body:
            "Browse through our recipe collections.\nNothing as creative as cooking. Cooking will never break your heart.",
        footer: NeumorphicText(
          'Bakeology is Fun',
          style:
              NeumorphicStyle(depth: 3, intensity: 1, color: Colors.grey[700]),
          textStyle: NeumorphicTextStyle(
              fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/cook_perfection.png"),
        title: "Browse, Cook, Eat then Repeat",
        body: "Let's explore the foodie in you.",
        footer: NeumorphicText(
          'Who says Healthy is not Yummyyy !!!',
          style:
              NeumorphicStyle(depth: 3, intensity: 1, color: Colors.grey[700]),
          textStyle: NeumorphicTextStyle(
              fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/share_meal.png"),
        title: "Enjoy together",
        body: "Cook together and share the meal.\n",
        footer: NeumorphicText(
          'Enjoyment Maximized',
          style:
              NeumorphicStyle(depth: 3, intensity: 1, color: Colors.grey[700]),
          textStyle: NeumorphicTextStyle(
              fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/showcase_skills.png"),
        title: "Be a Wizard",
        body:
            "Let others know how much of a cooking wizardry you have.\n Make your guests go crazy.",
        footer: NeumorphicText(
          'The Bake<o>logy Team.',
          style:
              NeumorphicStyle(depth: 3, intensity: 1, color: Colors.grey[700]),
          textStyle: NeumorphicTextStyle(
              fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/mark_favourite.png"),
        title: "Browse and save favourite Recipes",
        body:
            "Browse through our handpicked and assorted recipe collections.\nCook to perfection and maybe make the recipe yours by adding a slight personal touch!",
        footer: NeumorphicText(
          'Let\'s Get Started',
          style:
              NeumorphicStyle(depth: 3, intensity: 1, color: Colors.grey[700]),
          textStyle: NeumorphicTextStyle(
              fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        dotsFlex: 0,
        curve: Curves.elasticIn,
        skip: FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          child: NeumorphicText(
            'Skip',
            style: NeumorphicStyle(depth: 4, intensity: 1, color: Colors.grey),
            textStyle: NeumorphicTextStyle(
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
          ),
        ),
        showSkipButton: true,
        dotsDecorator: DotsDecorator(
          activeColor: Colors.greenAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        globalBackgroundColor: Colors.white,
        pages: _getPages(),
        onDone: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
        done: NeumorphicText(
          'Done',
          style: NeumorphicStyle(depth: 4, intensity: 1, color: Colors.grey),
          textStyle: NeumorphicTextStyle(
              fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
