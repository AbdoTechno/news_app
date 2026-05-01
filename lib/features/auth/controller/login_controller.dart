import 'package:flutter/material.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/core/mixins/safe_notify_mixin.dart';
import 'package:news/core/repos/user_repository.dart';

class LoginController extends ChangeNotifier with SafeNotifyMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final PreferencesManager _preferencesManager = PreferencesManager();

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login() async {
    isLoading = true;
    errorMessage = null;
    safeNotifyListeners();;

   final String? error =  await UserRepository().login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (error != null) {
      errorMessage = error;
      isLoading = false;
      safeNotifyListeners();
      return false;
    }

    _preferencesManager.setBool(PreferencesKey.isLoggedIn, true);

    isLoading = false;
    safeNotifyListeners();
    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
