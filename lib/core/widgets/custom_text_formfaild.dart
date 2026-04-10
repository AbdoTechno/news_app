import 'package:flutter/material.dart';
import 'package:news/core/sizes/app_sizes.dart';

class CustomTextFormFailed extends StatefulWidget {
  const CustomTextFormFailed({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.keyboardType,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
  });
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Function(String)? validator;

  @override
  State<CustomTextFormFailed> createState() => _CustomTextFormFailedState();
}

class _CustomTextFormFailedState extends State<CustomTextFormFailed> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
            fontSize: AppSizes.fontSize16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: AppSizes.spacingHeight8),
        TextFormField(
          validator: widget.validator != null
              ? (value) => widget.validator!(value ?? '')
              : null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : widget.suffixIcon,
          ),
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText == true ? !_isPasswordVisible : false,
          controller: widget.controller,
        ),
        SizedBox(height: AppSizes.spacingHeight12),
      ],
    );
  }
}
