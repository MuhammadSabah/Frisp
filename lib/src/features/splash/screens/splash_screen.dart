import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/main.dart';
import 'package:food_recipe_final/src/features/authentication/screens/error_screen.dart';
import 'package:food_recipe_final/src/features/home/screens/home_screen.dart';
import 'package:food_recipe_final/src/features/onboarding/screens/onboarding_screen.dart';
import 'package:food_recipe_final/src/features/welcome/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const ErrorScreen();
        } else if (snapshot.data == null) {
          if (onboardingBox?.get(1) ?? false) {
            return const WelcomeScreen();
          }
          return const OnboardingScreen();
        }
        return const HomeScreen();
      },
    ));
  }
}
