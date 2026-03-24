import 'package:flutter/material.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/features/auth/login_screen.dart';

class OnboardingController extends ChangeNotifier {
  int currentPage = 0;
  PageController pageController = PageController();
  bool isLastIndex = false;

  void onPageChanged(int index) {
    currentPage = index;
    if (index == 2) {
      isLastIndex = true;
    } else {
      isLastIndex = false;
    }
    notifyListeners();
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void animateToPage(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> onFinish(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    PreferencesManager().setBool(PreferencesKey.doneOnboarding, true);
  }
}
