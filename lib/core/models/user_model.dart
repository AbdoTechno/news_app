import 'package:hive_ce_flutter/hive_ce_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String? email;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? country;
  @HiveField(3)
  final String? displayName;
  // country code
  @HiveField(4)
  final String? countryCode;
  @HiveField(5)
  final String? password;

  UserModel({
    required this.email,
    required this.name,
    this.country,
    this.displayName,
    this.countryCode,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      country: json['country'],
      displayName: json['displayName'],
      countryCode: json['countryCode'],
      password: json['password'],
    );
  }
  // to json
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'country': country,
      'displayName': displayName,
      'countryCode': countryCode,
      'password': password,
    };
  }

  // copy with
  UserModel copyWith({
    String? email,
    String? name,
    String? country,
    String? displayName,
    String? countryCode,
    String? password,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      country: country ?? this.country,
      displayName: displayName ?? this.displayName,
      countryCode: countryCode ?? this.countryCode,
      password: password ?? this.password,
    );
  }
}
