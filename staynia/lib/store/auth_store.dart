import 'dart:convert';

import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/secure_storage.dart';
import 'package:staynia/data/entity/model/auth_token.dart';
import 'package:staynia/data/entity/model/user.dart';

class AuthStore {
  static Future<void> saveAuthToken(AuthToken token) async {
    final jsonString = jsonEncode(token.toJson());
    return await SecureStorage.save(Constants.token, jsonString);
  }

  static Future<AuthToken?> getAuthToken() async {
    final jsonString = await SecureStorage.get(Constants.token);
    if (jsonString == null) return null;
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return AuthToken.fromJson(json);
  }

  static Future<void> saveAccount({required User user}) async {
    final jsonString = jsonEncode(user.toJson());
    return await SecureStorage.save(Constants.user, jsonString);
  }

  static Future<User?> getAccount() async {
    final jsonString = await SecureStorage.get(Constants.user);
    if (jsonString == null) return null;
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return User.fromJson(json);
  }

  static Future<void> clearAccount() async {
    await SecureStorage.remove(Constants.user);
  }
}
