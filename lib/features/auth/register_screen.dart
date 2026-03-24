import 'package:flutter/material.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/core/widgets/custom_text_formfaild.dart';
import 'package:news/features/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;
  void register() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    final savedEmail = PreferencesManager().getString(PreferencesKey.userEmail);
    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = "Email already exists";
        isLoading = false;
      });
    } else {
      PreferencesManager().setString(
        PreferencesKey.userEmail,
        emailController.text.trim(),
      );
      PreferencesManager().setString(
        PreferencesKey.userPassword,
        passwordController.text.trim(),
      );
      // PreferencesManager().setBool(PreferencesKey.isLoggedIn, true);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registered successfully")));

      await Future.delayed(Duration(seconds: 5));
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
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
                  SizedBox(height: 180),

                  Center(
                    child: Image.asset('assets/images/logo.png', height: 45),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Welcome to Newts",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16),
                  CustomTextFormFailed(
                    validator: (value) {
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
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
                      final regex = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                      );

                      if (value.isEmpty || value.trim().isEmpty) {
                        return "Password is required";
                      }

                      if (!regex.hasMatch(value)) {
                        return "Password must contain uppercase, lowercase, number and symbol";
                      }

                      return null;
                    },
                    controller: passwordController,
                    hintText: "*************",
                    labelText: 'Password',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  CustomTextFormFailed(
                    validator: (value) {
                      final regex = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                      );

                      if (value.isEmpty || value.trim().isEmpty) {
                        return "Password is required";
                      }

                      if (!regex.hasMatch(value)) {
                        return "Password must contain uppercase, lowercase, number and symbol";
                      }

                      return null;
                    },
                    controller: confirmPasswordController,
                    hintText: "*************",
                    labelText: 'Confirm Password',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  if (errorMessage != null)
                    Text(errorMessage!, style: TextStyle(color: Colors.red)),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        register();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 52),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .foregroundColor!
                                      .resolve({}),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " Already have an account?",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the login screen
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
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
