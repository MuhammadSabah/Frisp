import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/features/authentication/screens/error_screen.dart';
import 'package:food_recipe_final/src/features/authentication/screens/sign_up_screen.dart';
import 'package:food_recipe_final/src/features/home/screens/home_screen.dart';
import 'package:food_recipe_final/src/providers/app_state_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<AppStateManager>(context, listen: false);
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
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const SignUpScreen();
        }
        userState.initializeApp();
        return const HomeScreen();
      },
    ));
  }
}
