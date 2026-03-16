import 'package:flutter/material.dart';

class CustomTextFormFailed extends StatelessWidget {
  const CustomTextFormFailed({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.keyboardType,
    this.obscureText,
    this.controller,
    this.suffixIcon,
  });
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final bool? obscureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            suffix: suffixIcon,
          ),
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          controller: controller,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
