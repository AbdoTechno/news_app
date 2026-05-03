import 'package:flutter/material.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/widgets/custom_text_formfaild.dart';
import 'package:news/features/auth/controller/auth_controller.dart';
import 'package:news/features/main/main_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return AuthController();
      },
      child: Consumer<AuthController>(
        builder:
            (
              BuildContext context,
              AuthController controller,
              Widget? child,
            ) {
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
                            SizedBox(height: AppSizes.spacingHeight40),
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
                                if (value.isEmpty ||
                                    value.trim().isEmpty) {
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
                            // username field can be added here if needed
                            CustomTextFormFailed(
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.trim().isEmpty) {
                                  return "Username is required";
                                }
                                return null;
                              },
                              controller: controller.nameController,
                              hintText: 'Username',
                              labelText: 'Username',
                              keyboardType: TextInputType.text,
                            ),

                            CustomTextFormFailed(
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.trim().isEmpty) {
                                  return "Password is required";
                                }

                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }

                                return null;
                              },
                              controller: controller.passwordController,
                              hintText: "*************",
                              labelText: 'Password',
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            CustomTextFormFailed(
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.trim().isEmpty) {
                                  return "Confirm password is required";
                                }

                                if (value.trim() !=
                                    controller.passwordController.text
                                        .trim()) {
                                  return "Passwords do not match";
                                }

                                return null;
                              },
                              controller:
                                  controller.confirmPasswordController,
                              hintText: "*************",
                              labelText: 'Confirm Password',
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
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  final isRegistered = await controller
                                      .register();

                                  if (!context.mounted) {
                                    return;
                                  }

                                  if (!isRegistered) {
                                    return;
                                  }

                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Registered successfully",
                                      ),
                                    ),
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
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width,
                                  52,
                                ),
                              ),
                              child: controller.isLoading
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'Sign Up',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
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
                                  " Already have an account?",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to the login screen
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).primaryColor,
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
