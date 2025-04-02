import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voltify/features/Home/presentation/views/home.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/onboarding/views/onboard_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static String routeName = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    ScreenSize.intial(context);
    return AnimatedSplashScreen(
      splash: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            'assets/app_images/logo.png',
          ),
        ],
      ),
      nextScreen: FirebaseAuth.instance.currentUser == null
          ? const OnboardScreen()
          : const HomeScreens(),
      splashIconSize: ScreenSize.height / 3,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: AppTheme.kPrimaryColor,
      pageTransitionType: PageTransitionType.bottomToTop,
      duration: 5000,
    );
  }
}
