import 'package:flutter/material.dart';
import 'package:news/core/mixins/safe_notify_mixin.dart';
import 'package:news/core/repos/user_repository.dart';

class AuthController extends ChangeNotifier with SafeNotifyMixin {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;

  Future<bool> register() async {
    isLoading = true;
    errorMessage = null;
    safeNotifyListeners();

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();

    final String? error = await UserRepository().signup(
      name: name,
      email: email,
      password: password,
    );

    if (error != null) {
      errorMessage = error;
      isLoading = false;
      safeNotifyListeners();
      return false;
    }

    isLoading = false;
    safeNotifyListeners();
    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
