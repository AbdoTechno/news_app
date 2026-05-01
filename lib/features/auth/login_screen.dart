import 'package:flutter/material.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/widgets/custom_text_formfaild.dart';
import 'package:news/features/auth/controller/login_controller.dart';
import 'package:news/features/auth/register_screen.dart';
import 'package:news/features/main/main_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return LoginController();
      },
      child: Consumer<LoginController>(
        builder: (BuildContext context, LoginController controller, Widget? child) {
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
                  key: controller.formKey,
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
                          controller: controller.emailController,
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
                          controller: controller.passwordController,
                          hintText: "*************",
                          labelText: 'Password',
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        if (controller.errorMessage != null)
                          Text(
                            controller.errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        SizedBox(height: AppSizes.spacingHeight20),
                        ElevatedButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              final isLoggedIn = await controller.login();

                              if (!context.mounted) {
                                return;
                              }

                              if (!isLoggedIn) {
                                return;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Logged in successfully")),
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width, 52),
                          ),
                          child: controller.isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Sign In',
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
        },
      ),
    );
  }
}
