import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:news/core/datasource/local_data/preferences_key.dart';
import 'package:news/core/models/user_model.dart';

class UserRepository {
  // SINGLETON
  UserRepository.internal();
  static final UserRepository _instance = UserRepository.internal();
  factory UserRepository() => _instance;

  Box<UserModel>? _userBox;

  Box<UserModel> get userBox {
    if (_userBox == null) {
      throw Exception("User box is not initialized");
    }
    return _userBox!;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    _userBox = await Hive.openBox<UserModel>(PreferencesKey.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    // save user to hive
    await userBox.put(PreferencesKey.currentUser, user);
  }

  UserModel? getCurrentUser() => userBox.get(PreferencesKey.currentUser);

  Future<void> updateUser({
    String? email,
    String? name,
    String? country,
    String? displayName,
    String? countryCode,
    String? password,
  }) async {
    final currentUser = getCurrentUser();
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(
        email: email,
        name: name,
        country: country,
        displayName: displayName,
        countryCode: countryCode,
        password: password,
      );
      await saveUser(updatedUser);
    }
  }

  // delete user data
  Future<void> deleteUser() async {
    await userBox.delete(PreferencesKey.currentUser);
  }

  // clear all user data
  Future<void> clearUserData() async {
    await userBox.clear();
  }

  // login
  Future<String?> login(String email, String password) async {
    final user = getCurrentUser();
    if (user == null) {
      return "No user found, please register first";
    }
    if (user.email != email || user.password != password) {
      return "Invalid email or password";
    }
    return null;
  }

  // signup
  Future<String?> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = getCurrentUser();
    if (user != null) {
      return "User already exists, please login";
    }
    final newUser = UserModel(
      email: email,
      name: name,
      password: password,
    );
    await saveUser(newUser);
    return null;
  }
}
