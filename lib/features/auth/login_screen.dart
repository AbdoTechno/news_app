import 'package:flutter/material.dart';
import 'package:news/core/widgets/custom_text_formfaild.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/logo.png', height: 45)),
              SizedBox(height: 24),
              Text(
                "Welcome to Newts",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16),
              CustomTextFormFailed(
                hintText: 'techno@gmail.com',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextFormFailed(
                hintText: "*************",
                labelText: 'Password',
                keyboardType: TextInputType.text,
                obscureText: !isPasswordVisible,
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                }, icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 52),
                ),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).elevatedButtonTheme.style!.foregroundColor!.resolve({}),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {},
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
    );
  }
}
