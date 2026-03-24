import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  // Singleton pattern
  static final PreferencesManager _instance = PreferencesManager._internal();
  // Factory constructor to return the same instance
  factory PreferencesManager() => _instance;
  // Private named constructor
  PreferencesManager._internal();
  // Late initialization of SharedPreferences
  late SharedPreferences _prefs;
  // Method to initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setString(String key, String value) {
    _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  void setBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  void setInt(String key, int value) {
    _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  void setDouble(String key, double value) {
    _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  void remove(String key) {
    _prefs.remove(key);
  }

  void clear() {
    _prefs.clear();
  }
}
