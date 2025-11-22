import 'package:flutter/material.dart';
import 'package:tasky_app/feature/auth/view/onboarding_screen.dart';
import 'package:tasky_app/feature/auth/view/home_screen.dart';
import 'package:tasky_app/feature/auth/view/login_screen.dart';
import 'package:tasky_app/feature/auth/view/register_screen.dart';
import 'package:tasky_app/feature/auth/view/splach_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        SplachScreen.routeName: (context) => SplachScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
