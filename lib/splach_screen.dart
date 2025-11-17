import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/onboarding_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});
  static const routeName = 'SplachScreen';

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5F33E1),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInLeft(
              child: Image.asset('assets/icons/Task_icon.png'),
            ),
            BounceInDown(
              from: 50,
              child: Image.asset('assets/icons/y_icon.png'),
            ),
          ],
        ),
      ),
    );
  }
}
