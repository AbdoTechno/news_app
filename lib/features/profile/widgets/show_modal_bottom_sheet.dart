import 'package:flutter/material.dart';
import 'package:news/core/models/user_model.dart';
import 'package:news/core/repos/user_repository.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/widgets/custom_text_formfaild.dart';
import 'package:news/features/profile/profile_controller.dart';
import 'package:provider/provider.dart';

class ShowModalBottomSheet extends StatefulWidget {
  const ShowModalBottomSheet({super.key});

  @override
  State<ShowModalBottomSheet> createState() =>
      _ShowModalBottomSheetState();
}

class _ShowModalBottomSheetState extends State<ShowModalBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  void _loadUserData() {
    final UserModel? user = UserRepository().getCurrentUser();
    _nameController.text = user?.name ?? "User Name";
    _emailController.text = user?.email ?? "User Email";
  }

  void _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      await UserRepository().updateUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );
      if (!context.mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (BuildContext context, ProfileController value, Widget? child) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCirc,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(AppSizes.spacingWidth16),
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFf5f5f5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.borderRadius20),
                topRight: Radius.circular(AppSizes.borderRadius20),
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(vertical: AppSizes.spacingHeight12),
                      width: AppSizes.spacingWidth32,
                      height: AppSizes.spacingHeight4,
                      decoration: BoxDecoration(
                        color: Color(0xFF363636),
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius4,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.spacingHeight16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Profile Info",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.spacingHeight16),
                    CustomTextFormFailed(
                      controller: _nameController,
                      hintText: "Name",
                      labelText: "Name",
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextFormFailed(
                      controller: _emailController,
                      hintText: "Email",
                      labelText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: AppSizes.spacingHeight60),
                    // clear image button
                    ElevatedButton(
                      onPressed: () async {
                        value.clearImage();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: Size(
                          double.infinity,
                          AppSizes.spacingHeight45,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius4,
                          ),
                        ),
                      ),
                      child: Text(
                        "Remove Image",
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: AppSizes.spacingHeight16),
                    ElevatedButton(
                      onPressed: () {
                        _saveUserData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: Size(
                          double.infinity,
                          AppSizes.spacingHeight45,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius4,
                          ),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
