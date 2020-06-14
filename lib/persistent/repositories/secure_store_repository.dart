import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telluslite/common/constants/app_key.dart';
import 'package:telluslite/persistent/models/user_configuration.dart';

class SecureStoreRepository {
  Future<bool> saveDarkModeSettings(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(AppKeys.DARK_MODE_KEY, value);
  }

  Future<bool> hasDarkModeSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppKeys.DARK_MODE_KEY) ?? false;
  }

  Future<UserConfiguration> loadCachedUserConfiguration() async {
    final storage = new FlutterSecureStorage();
    final data = await storage.read(key: AppKeys.USER_CONFIG_KEY);
    return UserConfiguration.fromJson(json.decode(data));
  }

  Future<void> cacheUserConfiguration(
      UserConfiguration userConfiguration) async {
    final storage = new FlutterSecureStorage();
    await storage.write(
        key: AppKeys.USER_CONFIG_KEY,
        value: userConfiguration.toJson().toString());
  }

  Future clearCache() async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }
}
