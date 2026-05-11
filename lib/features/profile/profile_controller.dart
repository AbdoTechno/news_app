import 'package:country_picker/src/country.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/core/repos/user_repository.dart';
import 'package:news/core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotifyMixin {
  final ImagePicker _imagePicker = ImagePicker();
  final UserRepository _userRepository = UserRepository();
  XFile? pickedFile;
  String? userName;
  String? userEmail;
  Country? userCountry;
  String? countryCode;
  String? countryName;

  Future<String> pickImage(ImageSource source) async {
    try {
      final XFile? selectedFile = await _imagePicker.pickImage(
        source: source,
      );
      if (selectedFile != null) {
        pickedFile = selectedFile;
        safeNotifyListeners();
        return selectedFile.path;
      } else {
        return 'No image selected.';
      }
    } catch (e) {
      return 'Error picking image: $e';
    }
  }

  void clearImage() {
    pickedFile = null;
    safeNotifyListeners();
  }

  void getUserData() {
    final currentUser = _userRepository.getCurrentUser();
    if (currentUser != null) {
      userName = currentUser.name;
      userEmail = currentUser.email;
      countryName = currentUser.country;
      countryCode = currentUser.countryCode;
    }
    safeNotifyListeners();
  }

  Future<void> saveCountry(Country country) async {
    await _userRepository.updateUser(
      displayName: country.displayName,
      countryCode: country.countryCode,
      country: country.name,
    );
    countryName = country.name;
    countryCode = country.countryCode;
    safeNotifyListeners();
  }
}
