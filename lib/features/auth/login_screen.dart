import 'package:flutter/material.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/widgets/custom_text_formfaild.dart';
import 'package:news/features/auth/register_screen.dart';
import 'package:news/features/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? errorMessage;
  void login() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    await Future.delayed(Duration(seconds: 2));
    final savedEmail = PreferencesManager().getString(PreferencesKey.userEmail);
    final savedPassword = PreferencesManager().getString(
      PreferencesKey.userPassword,
    );
    if (savedEmail == null || savedPassword == null) {
      setState(() {
        errorMessage = "No user found, please register first";
        isLoading = false;
      });
      return;
    }
    if (savedEmail == emailController.text.trim() &&
        savedPassword == passwordController.text.trim()) {
      PreferencesManager().setBool(PreferencesKey.isLoggedIn, true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Logged in successfully")));
    } else {
      setState(() {
        errorMessage = "Invalid email or password";
        isLoading = false;
      });
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizes.spacingHeight180),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: AppSizes.spacingHeight45,
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingHeight60),
                  Text(
                    "Welcome to Newts",
                    style: TextStyle(
                      fontSize: AppSizes.fontSize20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingHeight16),
                  CustomTextFormFailed(
                    validator: (value) {
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (value.isEmpty || value.trim().isEmpty) {
                        return "Email is required";
                      }
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email";
                      }

                      return null;
                    },
                    controller: emailController,
                    hintText: 'techno@gmail.com',
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextFormFailed(
                    validator: (value) {
                      if (value.isEmpty || value.trim().isEmpty) {
                        return "Password is required";
                      }

                      return null;
                    },
                    controller: passwordController,
                    hintText: "*************",
                    labelText: 'Password',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  if (errorMessage != null)
                    Text(errorMessage!, style: TextStyle(color: Colors.red)),
                  SizedBox(height: AppSizes.spacingHeight20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 52),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Sign In',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .foregroundColor!
                                  .resolve({}),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                  SizedBox(height: AppSizes.spacingHeight20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the registration screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
