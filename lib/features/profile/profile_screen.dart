import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/features/auth/login_screen.dart';
import 'package:news/features/profile/profile_controller.dart';
import 'package:news/features/profile/widgets/profile_option_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProfileController();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.spacingWidth16),
          child: Consumer<ProfileController>(
            builder:
                (BuildContext context, ProfileController controller, Widget? child) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: AppSizes.borderRadius65,
                            backgroundImage: controller.pickedFile != null
                                ? FileImage(File(controller.pickedFile!.path))
                                : const AssetImage("assets/images/splash.png")
                                      as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              // width: AppSizes.spacingWidth32,
                              // height: AppSizes.spacingHeight32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  _showImageSourceActionSheet(context);
                                },
                                icon: Icon(
                                  Icons.photo_camera_outlined,
                                  size: AppSizes.borderRadius24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.spacingHeight16),
                      Text(
                        PreferencesManager().getString(PreferencesKey.userEmail) ??
                            "User Name",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: AppSizes.spacingHeight32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Settings",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.spacingHeight16),
                      ProfileOptionWidget(
                        title: "Profile Info",
                        leadingIcon: "assets/images/person.svg",
                        trailingIcon: "assets/images/arrow.svg",
                      ),
                      // language
                      ProfileOptionWidget(
                        title: "Language",
                        leadingIcon: "assets/images/world.svg",
                        trailingIcon: "assets/images/arrow.svg",
                      ),
                      // Country
                      ProfileOptionWidget(
                        title: "Country",
                        leadingIcon: "assets/images/flag.svg",
                        trailingIcon: "assets/images/arrow.svg",
                      ),
                      // term and conditions
                      ProfileOptionWidget(
                        title: "Terms & Conditions",
                        leadingIcon: "assets/images/list.svg",
                        trailingIcon: "assets/images/arrow.svg",
                      ),
                      // logout
                      ProfileOptionWidget(
                        title: "Logout",
                        leadingIcon: "assets/images/logout.svg",
                        trailingIcon: "assets/images/arrow.svg",
                        showDivider: false,
                        onTap: () {
                          PreferencesManager().clear();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
          ),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    final controller = context.read<ProfileController>();
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select Image Source'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }
}
