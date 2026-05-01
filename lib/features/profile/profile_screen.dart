import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/auth/login_screen.dart';
import 'package:news/features/profile/profile_controller.dart';
import 'package:news/features/profile/widgets/profile_option_widget.dart';
import 'package:news/features/profile/widgets/show_modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProfileController()..getUserData();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.spacingWidth16),
          child: Consumer<ProfileController>(
            builder:
                (BuildContext context, ProfileController controller, Widget? child) {
                  return SingleChildScrollView(
                    child: Column(
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
                          PreferencesManager().getString(PreferencesKey.userName) ??
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
                          onTap: () async {
                            _showModalBottomSheet(context);
                          },
                        ),
                        // language
                        ProfileOptionWidget(
                          title: "Language",
                          leadingIcon: "assets/images/world.svg",
                          trailingIcon: "assets/images/arrow.svg",
                        ),
                        // Country
                        ProfileOptionWidget(
                          title: controller.countryName ?? "Country",
                          leadingIcon: "assets/images/flag.svg",
                          trailingIcon: "assets/images/arrow.svg",
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode:
                                  true, // optional. Shows phone code before the country name.
                              countryListTheme: CountryListThemeData(
                                backgroundColor: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                                bottomSheetHeight:
                                    MediaQuery.of(context).size.height * 0.85,
                                textStyle: Theme.of(context).textTheme.bodyLarge,
                                searchTextStyle: Theme.of(
                                  context,
                                ).textTheme.bodyMedium,
                                inputDecoration: InputDecoration(
                                  hintText: "Search country",
                                  hintStyle: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: AppColors.primary),
                                  prefixIcon: const Icon(Icons.search_rounded),
                                  filled: true,
                                  fillColor: AppColors.primary.withOpacity(0.1),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                              onSelect: (Country country) {
                                controller.saveCountry(country);
                              },
                            );
                          },
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
                    ),
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

  void _showModalBottomSheet(BuildContext context) {
    final ProfileController controller = context.read<ProfileController>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      backgroundColor: Colors.transparent,
      builder: (context) {
        return ChangeNotifierProvider<ProfileController>.value(
          value: controller,
          child: ShowModalBottomSheet(),
        );
      },
    ).then((_) {
      controller.getUserData();
    });
  }
}
