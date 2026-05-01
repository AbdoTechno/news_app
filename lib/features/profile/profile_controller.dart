import 'package:country_picker/src/country.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotifyMixin {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? pickedFile;
  String? userName;
  String? userEmail;
  Country? userCountry;
  String? countryCode;
  String? countryName;

  Future<String> pickImage(ImageSource source) async {
    try {
      final XFile? selectedFile = await _imagePicker.pickImage(source: source);
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
    userName =  PreferencesManager().getString(PreferencesKey.userName);
    userEmail =  PreferencesManager().getString(PreferencesKey.userEmail);
    countryName =  PreferencesManager().getString(PreferencesKey.userCountry) ;
    countryCode =  PreferencesManager().getString(PreferencesKey.countryCode) ;
    
    safeNotifyListeners();
  }

  void saveCountry(Country country) async  {
    PreferencesManager().setString(PreferencesKey.displayName, country.displayName);
    PreferencesManager().setString(PreferencesKey.countryCode, country.countryCode);
    PreferencesManager().setString(PreferencesKey. countryCode, country.countryCode);
    PreferencesManager().setString(PreferencesKey.userCountry, country.name);
    countryName  = country.name;
    countryCode = country.countryCode;
    safeNotifyListeners();
  }


}
