import 'package:flutter/material.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/features/home/home_screen.dart';
import 'package:news/features/auth/login_screen.dart';
import 'package:news/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    final doneOnboarding =
        PreferencesManager().getBool(PreferencesKey.doneOnboarding) ?? false;
    final isLoggedIn =
        PreferencesManager().getBool(PreferencesKey.isLoggedIn) ?? false;
    if (!mounted) return;
    if (!doneOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        width: double.infinity,
        'assets/images/splash.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
