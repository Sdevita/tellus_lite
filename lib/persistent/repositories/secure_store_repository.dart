import 'package:shared_preferences/shared_preferences.dart';
import 'package:telluslite/common/constants/app_key.dart';

class SecureStoreRepository {
  Future<bool> saveDarkModeSettings(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(AppKeys.DARK_MODE_KEY, value);
  }

  Future<bool> hasDarkModeSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppKeys.DARK_MODE_KEY) ?? false;
  }
}
