import 'package:depi_project/core/app_color.dart';
import 'package:depi_project/core/app_const.dart';
import 'package:depi_project/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime == true) {
      Navigator.pushNamed(context, onBoardingScreen);
    } else {
      Navigator.pushNamed(context, homeLayout);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      checkOnboarding();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(child: Lottie.asset('assets/animation/cooking.json')),
    );
  }
}
