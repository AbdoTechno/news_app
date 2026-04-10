import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news/core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotifyMixin {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? pickedFile;

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
}
